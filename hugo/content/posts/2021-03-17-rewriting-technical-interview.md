---
lastmod: "2021-03-27T14:34:02.0000000+00:00"
author: patrick
categories:
- programming
- g-research
comments: true
date: "2021-03-17T00:00:00Z"
title: Rewriting the Technical Interview, in Mathematica
summary: "An exploration into reaching into the internals of Mathematica to natively evaluate C code."
---

*Cross-posted at the [G-Research official blog](https://www.gresearch.co.uk/article/rewriting-the-technical-interview-in-mathematica/).*

*Mandatory prerequisite reading for this post: Kyle Kingsbury's ["Technical Interview"](https://aphyr.com/tags/Interviews) series. Don't read further until you've read from at least "[Reversing the Technical Interview](https://aphyr.com/posts/340-reversing-the-technical-interview)" through to the fourth interview, "Rewriting the Technical Interview". I promise that it will be worth your time.*

In Kyle Kingsbury's excellent [Rewriting the Technical Interview](https://aphyr.com/posts/353-rewriting-the-technical-interview), our protagonist solves [FizzBuzz](https://en.wikipedia.org/wiki/Fizz_buzz) in Clojure by copy-pasting a solution written in C, and then building a term-rewriting system in Clojure to evaluate the C code directly.

The reason this approach was so worthy of inclusion in the "Technical Interview" series is because Clojure is manifestly unsuited to approaching the problem in this way.
Much of the piece is devoted to building a term-rewriting system, even before getting to the meaty work of constructing the appropriate macros so that Clojure accepts the input C expression in a form which Clojure can manipulate.
But an [interesting question on Hacker News](https://news.ycombinator.com/item?id=24489112) arose: could this be done easily in a language which *already* supports term rewriting?

## A very quick intro to Mathematica

[Wolfram Mathematica] is an implementation of the [Wolfram Language], a language which is rather unusually based on [M-expressions][M-expression] (as opposed to the standard [S-expressions][S-expression] of LISP).
Usefully, it has excellent term-rewriting capabilities, and idiomatic Mathematica code often makes use of the function [`Replace`](https://reference.wolfram.com/language/ref/Replace.html) and its friends to traverse the form of an expression and apply replacement rules at various points.
This machinery comes out-of-the-box and could be used to replace the first half of Rewriting the Technical Interview if the language of choice were the Wolfram Language rather than Clojure.

However, a fundamental and unusual design feature of the Wolfram Language goes much further.
In fact, functions are usually *defined* as replacement rules.
To "define a function" is (more or less) to add one or more rules to a kind of global replacement table.
Whenever Mathematica encounters an expression which has a form matching the structure of a rule in its global replacement table, it replaces that expression with the right-hand-side of that rule.
This is *precisely* the functionality required to solve FizzBuzz using the insane method of the original post.

### Brief example

We can "define the function \\(f(x) = x^2\\)" by setting up a global replacement rule as follows:
```mathematica
f[x_] := Power[x, 2]
```
Whenever Mathematica encounters the symbol `f` applied to a single argument (here bound to the name `x`), it will replace the matched expression with `Power[x, 2]`.

For example, the expression `g[f[x, 3], f[6], f[y]]` (where `g` has not yet had any replacement rules set up for it) is evaluated in several steps:

* Mathematica walks the expression to discover all the sub-expressions. Most of them clearly have no replacement rules set up for them, so are left untouched (for example, `x`, `3`, `y`).
* `f[6]` and `f[y]` match the structure of the left-hand-side of the rule `f[x_] := Power[x, 2]`, so they are evaluated, into `Power[6, 2]` and `Power[y, 2]` respectively.
* `Power[6, 2]` matches a built-in rule and is evaluated to `36`. `Power[y, 2]` matches no built-in rules (and no user-defined rules) so is left unevaluated.
* `f[x, 3]` does not match the structure of the left-hand-side of any known rule. It has head `f`, but there are two arguments (`x` and `3`), whereas the pattern `f[x_]` strictly matches only the head `f` applied to *one* argument. So `f[x, 3]` is left unevaluated.

The final result is `g[f[x, 3], 36, Power[y, 2]]`.

# Solving the problem

We want to be able to accept the following expression as valid Wolfram Language code.

```c
for (i = 1 ; i < 101 ; i++) {
    if (i % 15 == 0) {
        println ("FizzBuzz");
    } else if (i % 3 == 0) {
        println ("Fizz");
    } else if (i % 5 == 0) {
        println ("Buzz");
    } else {
        println (i);
    };
}
```

This code is very much not valid, but we wish to set up Mathematica so that it recognises it as valid code (without having to put the code into a string or anything; just a direct paste into a notebook cell).

To do this, we need to know at a high level what happens when we evaluate a cell in Mathematica's notebook interface.
Mathematica's documentation, as ever, is exemplary for this purpose, and there are a number of tutorials (starting with [Low-Level Notebook Structure](http://reference.wolfram.com/language/guide/LowLevelNotebookStructure.html)) which point the reader towards the necessary symbols.

In brief, then, Mathematica proceeds as follows.
We will expand on all the magic here very soon.

* Tokenise the input.
* Perform some magic to group terms together in what is referred to as "[boxes](http://reference.wolfram.com/language/ref/MakeBoxes.html)".
* Apply the head `MakeExpression` to the boxed terms, constructing a syntax tree ready for user-defined (and built-in) replacement rules to apply. `MakeExpression` has many built-in replacement rules in Mathematica, allowing it to parse all valid Wolfram Language code; a failure of any existing replacement rule to match indicates a syntax error. We will be solving the problem by augmenting these rules to expand the range of syntax Mathematica thinks is valid.

## A simple example

Suppose we have already entered the `f[x_] := Power[x, 2]` rule above into Mathematica, so that from now on, expressions of the form `f[x_]` will be replaced with `Power[x, 2]` during evaluation.

How, then, does Mathematica process the input `g[f[x, 3], f[6], f[y]]` in a new notebook cell?

First, it tokenises (basically [lexing]) and groups terms into "boxes".
A box is a group of tokens which are part of the same sub-expression; the construction of boxes is an intermediate stage of Mathematica's parsing pipeline.

We can observe one possible collection of boxes that represents the expression `g[f[x, 3], f[6], f[y]]` by using the function [`MakeBoxes`](http://reference.wolfram.com/language/ref/MakeBoxes.html).

```mathematica
> MakeBoxes[g[f[x, 3], f[6], f[y]]]

[Out]: RowBox[{
  "g",
  "[",
  RowBox[{RowBox[{"f", "[", RowBox[{"x", ",", "3"}], "]"}],
  ",",
  RowBox[{"f", "[", "6", "]"}],
  ",",
  RowBox[{"f", "[", "y", "]"}]}],
  "]"
}]
```

Notice how Mathematica has already grouped terms which belong together according to its internal grouping rules.
For example, the three tokens `x` `,` `3` have been put together in their own box, because Mathematica saw them together inside square brackets.
This is going to be very helpful for us, because Mathematica has already made sane decisions about what sub-expressions we need to parse; these decisions turn out to be fully compatible with those we will require for the subset of C we intend to "interpret".

### Aside if you're confused about evaluation at this point
You can, and should, ignore this section unless it occurred to you to wonder how `MakeBoxes` managed to see the expression `f[6]` rather than the evaluated `36`.

Normally, `f[6]` inside an expression will get turned into `Power[6, 2]` and then into `36` before the parent expression even gets a chance to see the presence of `f`.
However, `MakeBoxes` has a certain *attribute* placed upon it, which exempts its argument from evaluation.
This is not magic, and you can do it to any head (i.e. any function) you define yourself; the attribute is called [`HoldAllComplete`](http://reference.wolfram.com/language/ref/HoldAllComplete.html).
This means we really are seeing the result of `MakeBoxes` on the expression `g[f[x, 3], f[6], f[y]]` rather than on the evaluated `g[f[x, 3], 36, Power[y, 2]]`.
Contrast this with how almost every other head behaves: they *will* evaluate their input before their own replacement rules apply.

For example, the head `Print`:

```mathematica
> Print[g[f[x, 3], f[6], f[y]]]

g[f[x,3],36,y^2]
[Out]: Null
```
(The printed output contains the syntactic sugar `y^2` which is exactly the same as `Power[y, 2]`.)

Or the head `List`:
```mathematica
> List[g[f[x, 3], f[6], f[y]]]

[Out]: {f[x, 3], 36, Power[y, 2]}
```

### What does Mathematica do with the parsed tokens?

Recall that we entered the text `g[f[x, 3], f[6], f[y]]` into a notebook cell, whereupon Mathematica lexed and then parsed the input into a pile of nested `RowBox`es.
(We used the function `MakeBoxes` to discover one sequence of boxes that corresponds to this expression; other such sequences do exist, but it so happens that we have seen the exact same form that Mathematica itself creates when parsing the raw notebook input of this expression.)

Now that we have our input in the form of nested boxes, Mathematica applies the function [`MakeExpression`](http://reference.wolfram.com/language/ref/MakeExpression.html) to the boxes.
This is the function that parses the stream of grouped tokens, and it has many built-in rules allowing it to parse all valid Wolfram Language syntax.

For example, the built-in rules assigned to `MakeExpression` take the following:

```mathematica
RowBox[{
  "g",
  "[",
  RowBox[{RowBox[{"f", "[", RowBox[{"x", ",", "3"}], "]"}],
  ",",
  RowBox[{"f", "[", "6", "]"}],
  ",",
  RowBox[{"f", "[", "y", "]"}]}],
  "]"
}]
```

And they transform it into this:

```mathematica
g[f[x, 3], f[6], f[y]]
```

That is how Mathematica obtains its in-memory expression from the input we entered.

### What does it do with the parsed expression?

Now that Mathematica has parsed our text into an actual M-expression, it proceeds to apply evaluation rules.
We've already seen how this works, and how it comes up with the final answer `g[f[x, 3], 36, Power[y, 2]]`.

But if we want to match how Rewriting the Technical Interview worked, we need to do all our evaluation *before* this point, at parse time.
So we'll have to wind back a bit and consider how we will get computation to happen *after* we've obtained the `RowBox` expression, during `MakeExpression`.

# Reaching into the parser

The simple and beautiful insight is that `MakeExpression` is a function *exactly* like any other.
So, for example, we can supply our own replacement rules which will operate according to Mathematica's usual rule-precedence logic, which approximately boils down to "first apply the rules which match most precisely".

To see how this logic works, consider the following two replacement rules associated with the head `h`, effectively defining a function called `h`.

```mathematica
h[x_] := x ^ 2
h[3] := 0
```

(Recall the built-in infix syntactic sugar `x ^ 2` for `Power[x, 2]`.)

If the argument is a symbol `y` Mathematica doesn't recognise, it will evaluate `h[y]` into `Power[y, 2]` by matching the first rule.
But it will evaluate the verbatim expression `h[3]` into `0` rather than `9`, because the rule `h[3] := 0` is "more specific" than the other matching rule `h[x_] := x ^ 2`, so the "more specific" rule will be used preferentially wherever it matches.
There is a precise notion of what it means for one rule to be "more specific" than another, but in practice it almost always just aligns with intuition and you don't have to worry about the details.

The upshot is that if we create our own specific rules for `MakeExpression`, they will match with higher precedence than the built-in general ones, and so our own rules will be applied.
The difficult part will be discovering which rules we need to add to `MakeExpression`.

## Aside on the nature of LISP

This solution method, "reach down into the parser to adjust how it works", mirrors a beautiful aspect of many LISPs, in which very little is hidden from you and everything is modifiable.
The Wolfram Language is not strictly speaking a LISP (it's rather more like the macro system of a LISP, based around rewriting terms), but it shares many similarities in spirit.

Much of the implementation of Mathematica is hidden from the user, because it's proprietary software, but like a LISP, the language is built around the idea of [homoiconicity] - that is, "code is data which you can manipulate just like any other data".
In Kingsbury's original post (written in Clojure, a genuine LISP), much time was spent building macros which parse the C code into a Clojure data structure.
Here, though, we will cut out one step: we won't reify the C code as a data structure, but instead will skip straight to evaluating it during parse.
In adhering strictly to the principle of homoiconicity by building an explicit representation of the C code, Kingsbury's method is in some sense "pure" and it certainly allows more complex operations such as inspecting the code structure; but it's a lot less pragmatic when all you want to do is run some C, side-effects and all!

## A simple example

The Wolfram Language does not recognise the infix operator `%`, which is the modular-arithmetic operator in C.
In fact, `%` has a totally different meaning in the Wolfram Language: it refers to the output of the most recently evaluated expression (which, in Mathematica, is the most recently evaluated notebook cell).
Naturally, we have to change this if we wish to evaluate FizzBuzz in C at parse time; and this is one of the simplest places to start.

We'll need a quick overview of the "blank pattern" syntax of the Wolfram Language before we start.
A blank is simply one or more holes in an expression; when Mathematica tries to match the pattern, either it will succeed (and fill in the blank), or it will fail.
It's just like a capturing group in a regex.

* A blank whose name ends with exactly one underscore (`x_`) matches exactly one thing. `f[x_]` does not match `f[1, 2]` or `f[]`, but it does match `f[3]` or `f[y]`.
* A blank whose name ends with exactly two underscores (`x__`) matches a sequence of at least one thing. `f[x__]` does not match `f[]`, but it matches any other expression whose head is `f`. Similarly, `f[x__, 3, y__]` matches any expression whose head is `f` with some arguments, then a `3`, then some more arguments. During a successful match, the name `x` gets locally assigned with the first arguments up to the `3`, and the name `y` gets locally assigned with the last arguments after the `3`.
* A blank whose name ends with exactly three underscores (`x___`) matches any (possibly empty) sequence. `f[x___]` matches any expression whose head is `f`. `f[x___, 3, y___]` matches, for example, `f[3]`, `f[3, 5, 6]`, `f[1, 2, 3]`, and `f[1, 3, 5, 6]`. It matches `f[3, 3]` in several different ways (so you have to be quite careful when defining patterns with the more permissive blanks, to make sure you know which one you're going to get and what `x` and `y` will end up as!).

There are more ways to specify patterns and blanks in more complex forms, but this is all we will need.

Now we have the tools required to turn `%` into an infix operator:

```mathematica
MakeExpression[RowBox[{x__, "%", y__}], form_] :=
  MakeExpression[
    RowBox[{"Mod", "[", RowBox[{x, ",", y}], "]"}],
    form
  ]
```

(Ignore the `form` argument to `MakeExpression`. There are multiple different "box forms" corresponding to the different layouts of text that Mathematica will recognise, such as "traditional form" where Mathematica tries to parse ordinary mathematical text; here, for convenience, we're saying our logic will apply no matter which form is in use.)

This creates a new replacement rule for `MakeExpression`.
Whenever `MakeExpression` is called on any `RowBox` which contains some sequence of symbols (bound to the name `x`), then the single-character string `"%"`, then another sequence of symbols (bound to the name `y`), we swap out the expression it's parsing with one we know will parse into Mathematica's `Mod` function applied to the two arguments.

Note that we've basically just rewritten the stream of tokens; there's no fancy logic taking place, and no real computation occurring at parse-time.

## Printing

The C function `println` will work in a very similar way, except this time we need to take care of some brackets ourselves, because the Wolfram Language uses square brackets whereas C uses round brackets for function application.

```mathematica
MakeExpression[RowBox[{"println", RowBox[{"(", xs___, ")"}]}], form_] :=
  MakeExpression[RowBox[{"Print", "[", xs, "]"}], form]
```

## If-then-else

We can handle if-then-else in a slightly different way.

Aside: a lot of trial and error went into discovering exactly the form of the left-hand-side here!
It's not obvious by eye how a string will be lexed; I found the lex by matching on very general structures like `RowBox[{"if", rest__}]` and judiciously using `Print` statements to discover the form of `rest`.
Of course, if you get this wrong, then your code is a syntax error (because `MakeExpression`'s built-in rules don't match, because it's not valid Wolfram Language code).

```mathematica
MakeExpression[
 RowBox[
   {
     "if",
     RowBox[{"(", xs__, ")"}],
     RowBox[{"{", ys___, "}"}],
     "else",
     zs___
   }
 ],
 form_
] :=
 If[
   ReleaseHold[MakeExpression[xs, form]],
   MakeExpression[ys, form],
   MakeExpression[RowBox[{zs}], form]
 ]
```

This is somewhat different in structure to the previous examples, because now we're doing *actual computation* at parse time.

The left-hand side is much as we have seen before: we match a certain lexical structure, binding subexpressions to the names `xs`, `ys`, and `zs`.
However, the right-hand side is very different.

Instead of replacing the expression with a statically-known form, we are dynamically chosing which form to recurse into.
More concretely:

* Use `MakeExpression` to parse the expression `xs`, resulting in a Mathematica expression like `Equal[x, 3]` (if, for example, `xs` referred to the token stream for the input `x == 3`).
* Call `ReleaseHold` to cause Mathematica to *evaluate* the parsed expression. This results in a Mathematica boolean `True` or `False`.
* Depending on the Mathematica boolean, proceed to parsing either the `ys` or the `zs`.

Notice how we've performed some actual computation in Mathematica *during expression parse*, while deciding what to parse next.
This is vital when `ys` and `zs` contain side-effects (as they are bound to do, since C is an imperative language); we have to avoid parsing the code we aren't going to execute, because we'll be performing side-effects at parse-time.

## For-loop

Now that we've seen the main idea from `if`/`then`/`else`, we can do the same for `for`.

```mathematica
MakeExpression[
  RowBox[{
    "for",
    RowBox[{"(", RowBox[{init__, ";", cond__, ";", incr__}], ")"}],
    RowBox[{"{", expr__, "}"}]
  }],
  form_
] :=
  Hold[
    For[
      ReleaseHold[MakeExpression[init, form]],
      ReleaseHold[MakeExpression[cond, form]],
      ReleaseHold[MakeExpression[incr, form]],
      ReleaseHold[MakeExpression[expr, form]]
    ]
  ]
```

This is pretty much the same as in the `if` case: simply use a lot of trial and error to discover how Mathematica lexes the input stream in this particular case of the C source, then extract the desired parts of the token stream, and translate them into Mathematica's own `For` construct (which has basically the same form as C's, because the Wolfram Language's designers wanted to make it a bit easier for people to migrate to Mathematica from C).

An oddity: note here that we have wrapped the entire thing in `Hold`, to *prevent* immediate evaluation; `Hold` is one way you can do quoting of expressions in Mathematica.
Without this `Hold`, you'll find a syntax error ("more input is needed") when you evaluate the C code cell.

In all our previous examples, we've ultimately been descending into another `MakeExpression` call.
This for-loop is the first time we have not done so (though we could have done it that way with `printf` earlier).
In fact, `MakeExpression` is always assumed to return a Wolfram Language expression held unevaluated, so that the result of parsing is an *unevaluated* expression.
Since we've always been descending into `MakeExpression` calls, we've never broken that property.
If we omit the `Hold` here, then `For` is just a normal Mathematica `For`, so it returns nothing; and in particular it fails to return an unevaluated expression.
That breaks the contract `MakeExpression` implicitly has with the notebook interface, so whenever we come to use our new syntax `for (init; cond; incr) { expr }`, the parser returns nothing at all, and the notebook interface interprets this as a syntax error.

The `if` case was different, of course, because in both its branches, it always returns a `MakeExpression` output, which is already an unevaluated expression.

# The entire program

In two cells:

```mathematica
MakeExpression[RowBox[{x__, "%", y__}], form_] := MakeExpression[RowBox[{"Mod", "[", RowBox[{x, ",", y}], "]"}], form]

MakeExpression[RowBox[{"println", RowBox[{"(", xs___, ")"}]}], form_] := MakeExpression[RowBox[{"Print", "[", xs, "]"}], form]

MakeExpression[RowBox[{"if", RowBox[{"(", xs__, ")"}], RowBox[{"{", ys___, "}"}], "else", zs___}], form_] :=
 If[ReleaseHold[MakeExpression[xs, form]], MakeExpression[ys, form], MakeExpression[RowBox[{zs}], form]]

MakeExpression[RowBox[{"for", RowBox[{"(", RowBox[{init__, ";", cond__, ";", incr__}], ")"}], RowBox[{"{", expr__, "}"}]}], form_] :=
 Hold[For[ReleaseHold@MakeExpression[init, form],
  ReleaseHold@MakeExpression[cond, form],
  ReleaseHold@MakeExpression[incr, form],
  ReleaseHold@MakeExpression[expr, form]]]
```

```mathematica
for (i = 1 ; i < 101 ; i++) {
    if (i % 15 == 0) {
        println ("FizzBuzz");
    } else if (i % 3 == 0) {
        println ("Fizz");
    } else if (i % 5 == 0) {
        println ("Buzz");
    } else {
        println (i);
    };
}
```

Naturally, Mathematica's syntax highlighting and pretty-printing will go *absolutely nuts* on the second cell; but evaluating the cell will cause the appropriate FizzBuzz output to appear (and nothing else to appear!), and does not even throw a syntax error.

# Remark on the Clojure original

The original Clojure program from Kingsbury's post, by the way, cheats with its semicolons.
The semicolon used to delimit the `for` initialisation/condition/increment, and the semicolon used to denote the end of the `if`/`else` chain, are both actually the very similar-looking character Unicode U+037E "GREEK QUESTION MARK".
(The article gently calls this out, referring to the construction as "not exactly evil".)

This makes it easier for the hand-rolled Clojure term rewriter to distinguish terms which belong to different sub-expressions, but in fact it makes the Mathematica version *much* harder.
The syntax of C and its operators is sufficiently close to that of the Wolfram Language that we can simply rely on the built-in lexer to give us the right tokens and the built-in parser to group terms for us.
Mathematica parses sufficiently correctly for our FizzBuzz purposes.
(Notice, for example, that we got the `==` token for free with no further work: it is the same token, with the same infix-ness, both in C and in the Wolfram Language.)
But using a character that is not a true semicolon *really* confuses the parser, and we end up with a stream of tokens grouped wildly differently into boxes, making it very hard to untangle into a useful expression.

# Possible extensions

The evaluator I've outlined here is hyper-focused on solving one specific problem.
It's not truly parsing the input according to anything remotely resembling a C standard.
It would be possible to do it correctly, though, if we spent a lot more effort in crafting more specific and more general rules!

For example, Kingsbury (the original author) was worried about being able to distinguish between `f(a, b)` and `f((a, b))`.
The program I've outlined here makes no attempt to do this - it is not necessary if we only want to solve FizzBuzz - but it is possible, because parentheses appear in the lexed stream.
We don't lose any information in the lexing or parsing up to the point of calling `MakeExpression`, so in principle we could perform arbitrary analysis and transformation on the C code.

[lexing]: https://en.wikipedia.org/wiki/Lexical_analysis
[M-expression]: https://en.wikipedia.org/wiki/M-expression
[S-expression]: https://en.wikipedia.org/wiki/S-expression
[Wolfram Mathematica]: https://en.wikipedia.org/wiki/Wolfram_Mathematica
[Wolfram Language]: https://en.wikipedia.org/wiki/Wolfram_Language
[homoiconicity]: https://en.wikipedia.org/wiki/Homoiconicity
