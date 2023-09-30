---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- programming
comments: true
date: "2014-01-24T00:00:00Z"
math: true
aliases:
- /uncategorized/introduction-to-functional-programming-syntax-of-mathematica/
- /introduction-to-functional-programming-syntax-of-mathematica/
title: Introduction to functional programming syntax of Mathematica
---
Recently, I was browsing the [Wolfram Community][1] forum, and I came across the following question:

> What are the symbols @, #, / in Mathematica?

I remember that grasping the basics of functional programming took me quite a lot of mental effort (well worth it, I think!) so here is my attempt at a guide to the process.

In Mathematica, there are only two things you can work with: the Symbol and the Atom. There is only one way to combine these things: you can provide them as arguments to each other. We denote "\\(x\\) with arguments \\(y\\) and \\(z\\)" by "`x[y,z]`".

What is an Atom? As the name suggests, it is something indivisible, like the number 2 or the string "Hello!". So that the language isn't too complicated to implement, we mean "indivisible without any further work" - so the number 15 is "divisible" (in the sense that it's 3x5), but not in our sense: it takes work to find the divisors of a number. Similarly, the string "Hello!" is "divisible" into characters, but that again takes work.

A Symbol is something which we, as a programmer, tell Mathematica to give meaning to. We also tell it under what circumstances that Symbol has meaning. For instance, I might say to Mathematica, "In future, when I ask you the Symbol $MachinePrecision, you will pretend I said instead the Atom 15.9546." Something else I might say to Mathematica is, "In future, when I ask you for the Symbol Plus, combined with the arguments 1 and 2, you will pretend I said instead the Atom 3."

In Mathematica's syntax, we write the above as:

    $MachinePrecision = 15.9546;
    Plus[1, 2] = 3;

(The semicolons prevent Mathematica from printing the value we gave. Without the semicolons, it would print out 15.9546 and 3. In fact, the semicolons are a shorthand for the Symbol CompoundExpression, but that's not important.)

Furthermore, we can ask Mathematica, "In future, when I ask you for Plus combined with zero and any other argument x, return that argument x". In Mathematica's syntax, that is:

`Plus[0, Pattern[x, Blank[]] ] := x`

More compactly:

`Plus[0, x_] := x`

Now, we have had to be careful. Mathematica needs a way of distinguishing the Symbol `x` from the "free argument" `x`. We want the "free argument" - that is, we want to be able to supply any argument we like, and just temporarily call it x. We do that using the Pattern symbol, better recognised as `x_` . I won't go into how Pattern works in terms of the Symbol/Atom idea, but just recognise that `x_` *matches* things, rather than *being* a thing.

Now, we'll assume that there is already a "plus one" method - that Mathematica already knows how to do `Plus[1, x_]`. Let's also assume that it knows what `Plus[-1, x_]` is (not hard to do, in principle, once we know `Plus[1, x_]`). Then we can define Plus over the positive integers:

`Plus[x_, y_] := Plus[Plus[-1, x], Plus[1, y]]`

And so forth. This is how we build up functions out of Symbols and Atoms.

Now, there is a shorthand for `f[x]`. We can instead write `f@x`. This means exactly the same thing.

A really important Symbol is `List`. `List[x, y, z]` (or, in shorthand, `{x, y, z}`) represents a collection of things. There's nothing "special" about `List` - it's interpreted in exactly the same way as everything else - but it's a convenient, conventional way to lump several things together. (It would all have worked in exactly the same way if the creators of the language had decided that Yerpik would be the symbol that represented a generic collection; even `Plus` could be used this way, if we made sure to tell Mathematica that "Plus" should not be evaluated in the usual way. You could even use the number 2 as the list-indicating symbol, or even use it as `Plus` usually is used, leading to expressions like `2[5,6] == 11`.) We can define functions like `Length[list_]`, so `Length[{1, 2, 3}]` is just 3.

Since everything is essentially function application ("apply a symbol to an expression"), we might explore ways to apply several functions at once, or to apply a function to several different parts of an expression. It turns out that a really useful thing to do is to be able to apply a function to all the inside bits of a List. We call this "mapping":

`Map[f, {a, b, c}] == {f[a], f[b], f[c]}`

More generally, `Map[f, s[a1, a2, … ]] == s[f[a1], f[a2], …]`, but we use `List` instead of `s` for convenience. There is a shorthand, reminiscent of the `f@x` notation: we use `f /@ {a, b, c}` to denote "mapping".

It's all very well to want to map a function across the arguments to a symbol (let's call that symbol, which has those arguments, the Head of an expression, so `Head[f[x,y]]` is just `f`), but what about if we want to apply the function *to the Head symbol*? Actually, this turns out to be quite rare (the function is `Operate[p, f[x,y]]` to give `(p[f])[x,y]` ), but it's much more common to want to replace the Head completely. For instance, we might want to supply a List as arguments to a function, as follows:

`f[x_, y_] := x + y^2`

How would we get `f` to act on the List `{5, 6}`? We can't just say `f[{5, 6}]` because f requires two inputs, not the one that is `List[5, 6]`. Mathematica's syntax is that instead of `f@{5,6}`, we use `f@@{5, 6}`. This is shorthand for `Apply[f, {5,6}]`, and it returns `f[5, 6]`, which is 41.

More generally, `f@@g[x, y] == f[x, y]`. (Note, however, that Mathematica evaluates things as much as possible before doing these transformations, so `f@@Plus[5,6]` doesn't give you `f[5,6]` but `f@@11`, an expression which makes no sense. Mathematica's convention is that Atoms don't really have a Head, so replacing the Head with `f` does nothing; hence `f@@11` will return 11.)

Particularly in conjunction with `Map`, it can be useful to Apply a function not to an expression, but to the arguments of the expression. That is, given a List `{{1, 2}, {3, 4}}`, which is `{List[1, 2], List[3, 4]}`, we might want to output `{f[1, 2], f[3, 4]}`. We do this with the shorthand `f@@@{{1, 2}, {3, 4}}`, which is really `Apply[f, {{1, 2}, {3, 4}}, 2]`. This situation might arise if we wanted to "transpose" two strings "ab" and "cd" to return "ac" and "bd" (imagine writing the strings out in a table, and reading the answer down the columns instead of across the rows). We could use `StringJoin@@@Transpose@Map[Characters, {"ab", "cd"}]`. Indeed, what does this expression do? The first thing that will actually change when it is evaluated is `Map[Characters, {"ab", "cd"}]`. This will return `{{"a", "b"}, {"c", "d"}}`. Then Transpose sees that new list, and flips things round to `{{"a", "c"}, {"b", "d"}}`, which is `{List["a", "c"], List["b", "d"]}`. Then `StringJoin` is asked not to hit the outer `List`, or even to hit the inner Lists, but to *replace* the List head on the inner Lists: the expression becomes `{StringJoin["a", "c"], StringJoin["b", "d"]}`, or `{"ac", "bd"}`.

Now, it's all very well to have functions that work like this. But what if we wanted to take the second character of a string? There's a function for that - `StringTake` - but it needs arguments. We could define a new function `takeSecondChars[str_] := StringTake[str, {2}]`, but that's unwieldy if we only want this function once - and what about if we wanted the third character instead, the next time?

There is a really useful way to define functions without names. Unsurprisingly, they look like:

`Function[{x, y, …}, …]`

So in the above example, we'd have `Function[{str}, StringTake[str, {2}]]`. And then to map it across a list would look like:

`Function[{str}, StringTake[str, {2}]] /@ {"str1", "str2", "str3"}`

We can also apply it to a string: `Function[{str}, StringTake[str, {2}]]["string"]`, or `Function[{str}, StringTake[str, {2}]]@"string"`.

There's a really compact shorthand. Instead of `Function[{args}, body]` we use `(body)&`. We don't even bother naming the arguments; we use the `Slot[i]` function to get the `i`th argument. `Slot[i]` is more neatly written as `#i`, while just the `#` symbol is interpreted as `#1`.

Hence our function becomes `StringTake[#, {2}]&`, and its mapping looks like:

`StringTake[#, {2}]& /@ {"str1", "str2", "str3"}`

It takes some getting used to, but after a while it becomes extremely natural. In my most recent coursework project, there are almost no programs I wrote which don't use this syntax, even though the coursework is aimed at the language Matlab which is almost the antithesis of this idea of "symbols with arguments". Once you become able to see problems in this way - mapping small functions over expressions, and so forth - you start seeing it everywhere. The idea is about sixty years old - it's the principle of Lisp - and it's ridiculously powerful. Since functions are just expressions, you can use them to alter themselves. For instance, memoisation is trivial:

    fibonacci[n_] := (fibonacci[n] = fibonacci[n-1] + fibonacci[n-2])
    fibonacci[1] = 1;

That is, "Whenever I ask you for fibonacci[n], you will set the value of fibonacci[n] to be the sum of the two previous values." Note that this is "set the value of fibonacci[n] to be", not "return" - this is a permanent change (well, as permanent as the Mathematica session), and it means that the value of fibonacci[36] is instantly available forever after once you've calculated it once.

You can also get some crazy things with Slot notation, because `#0` (which is `Slot[0]`) represents *the function itself*. Off the top of my head, an example is:

    (Boole[# < 10] #0[# + 1] + #) &[1]

This generates the tenth triangle number. (The function `Boole[arg]` returns 1 if arg is `True`, and 0 otherwise.) This is because the function evaluates to exactly its input unless that input is less than 10; in that case, the function evaluates to (its input, plus "this function evaluated at input+1"). Recursively expanded, it is `f[x_] := If[x < 10, f[x+1]+x, x]`, evaluated at the input 1. It gets quite mind-bending quite quickly, and I don't think I have ever used `#0` in earnest. Another example I came up with quickly was:

    If[Cos[#] == #, #, #0[Cos[#]]] &[1.]

This finds a fixed point of the function Cos, starting at the initial input 1. (It has to be a numerical input, otherwise Mathematica will just keep going forever with better and better symbolic expressions for this fixed point, like `Cos[Cos[Cos[1]]]`. It rightly recognises that, for instance, `Cos[Cos[Cos[1]]]` is not equal to `Cos[Cos[Cos[Cos[1]]]]`, so it never stops.)

The last really useful piece of shorthand I can think of at the moment is // which is another way to apply functions.  
Instead of `f@x`, we can use `x//f` . This has the benefit of making it a bit clearer what is actually contentful, and what is just afterthoughts, because the functions which are evaluated last actually appear at the end:

`CharacterRange["a","z"] // StringJoin`

Of course, the usual function notation can be used:

`1 // (Boole[# < 10] #0[#+1] + # &)`

Phew, that was a whistlestop tour in rather more words than I had hoped - turns out there are far more Mathematica concepts that I've internalised than I had thought, all of which are really quite fundamental and indispensable. I understand much better why people say Mathematica has a steep learning curve, and why it is derided as a "write-only language" - that final example is ridiculous!

 [1]: http://community.wolfram.com
