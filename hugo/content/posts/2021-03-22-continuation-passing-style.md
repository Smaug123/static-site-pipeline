---
lastmod: "2021-03-22T18:21:49.0000000+00:00"
author: patrick
categories:
- programming
- g-research
comments: true
date: "2021-03-22T00:00:00Z"
title: Continuation-passing style
summary: "Motivating the technique of continuation-passing style, by looking at recursive functions."
---

*Cross-posted at the [G-Research official blog](https://www.gresearch.co.uk/article/continuation-passing-style/).*

In a previous post, [Chris Arnott examined a few different techniques to do recursion][Chris] in F#.
Here, we will expand on a particular one of those techniques (continuation-passing style, or "CPS") from a slightly different angle.
CPS is one of those topics which you can only really learn by soaking in various different explanations and by giving it a go until it clicks.

In brief, we'll motivate continuation-passing style by thinking about how to deal with stack overflows in recursive functions.

# A quick tail-recursion refresher

I've previously [discussed] how to write loops using immutable state.
Here is a pair of equivalent functions, presented without comment to jog your memory.

```fsharp
let tryFindMax (xs : 'a list) : 'a option =
    let rec go (biggest : 'a) (xs : 'a list) : 'a =
        match xs with
        | [] -> biggest
        | x :: xs -> go (max biggest x) xs

    match xs with
    | [] -> None
    | x :: xs -> Some (go x xs)
```

```fsharp
let tryFindMax' (xs : 'a list) : 'a option =
    match xs with
    | [] -> None
    | x :: xs ->
        let mutable biggest = x
        let mutable xs = xs
        while not (List.isEmpty xs) do
            biggest <- max biggest (List.head xs)
            xs <- List.tail xs
        Some biggest
```

We won't discuss this further, except to note three things:

* we've avoided using `List.fold`, purely for pedagogical reasons (because `fold` sidesteps all the issues we'll discuss in this post, being essentially equivalent to the "accumulator" recursion technique Chris discusses);
* a sufficiently smart compiler can mechanically transform the former into the latter;
* the latter phrasing obviously does not grow the stack, and so a sufficiently smart compiler can transparently rewrite so that the former does not grow the stack either.

(The F# compiler is indeed sufficiently smart, although in some cases you have to compile explicitly with optimisations enabled before it will perform this transformation.)

# The motivation for continuation-passing style

We start with a recursive function, expressed in F#.
Here, we'll generate all the permutations of a list.
For example, there are six permutations of `[1;2;3]`; two such permutations are `[1;2;3]` and `[2;1;3]`.

The algorithm will be a very naive recursion: the permutations of `[1;2;3]` are precisely the permutations of `[2;3]` but where we have inserted the number `1` into every possible position.
Concretely:

* `[2;3]` yields `[1;2;3]`, `[2;1;3]`, `[2;3;1]` by inserting `1` into each possible slot;
* `[3;2]` yields `[1;3;2]`, `[3;1;2]`, `[3;2;1]` similarly.

This gives us the required six permutations.

Firstly we'll consider the "insert `1` into every possible position" helper function.

```fsharp
let rec insertions (y : 'a) (xs : 'a list) : 'a list list =
    match xs with
    | [] ->
        // There is only one place to insert `y` into the empty list.
        List.singleton [ y ]
    | x :: xs ->
        // Either we insert `y` at the beginning, or we don't.
        (y :: x :: xs)
        ::
        (insertions y xs |> List.map (fun subResult -> x :: subResult))
```

This is all very well, but it will stack overflow if `xs` is too big.
Make sure you understand why: it's because the program needs to remember the entire context in which it's constructing the answer, for the entire time in which it's constructing the answer.

This is ultimately because the function is not tail-recursive, so the compiler is unable to optimise it into a simple loop.

You may want to meditate on how we might solve the problem in principle.
The stack is running out of space; how can we fix this?

Some answers are as follows.

## Make the stack bigger?

This works, but does not scale indefinitely; you need to know up front what your recursion limit is going to be.
We won't consider this solution further.

## Use less space?

The following phrasing, where we use a seq instead of a list, could allow a sufficiently smart compiler to throw away almost all the context at every stage.
But in fact the F# compiler is not sufficiently smart, even in Release mode with optimisations turned on (and I'm not aware of a language with a compiler that will do this in general).
This still overflows the stack.

```fsharp
let rec insertions (y : 'a) (xs : 'a list) : 'a list seq =
    match xs with
    | [] ->
        // There is only one place to insert `y` into the empty list
        Seq.singleton [y]
    | x :: xs ->
        // Either we insert `y` at the beginning, or we don't.
        seq {
            yield y :: x :: xs
            yield! (insertions y xs |> Seq.map (fun subResult -> x :: subResult))
        }
```

## Use the same amount of space, but put it on the heap

*This* is the magic thought that leads us to a way of doing arbitrary recursion without stack overflow.

One possibility would be to construct our own stack object on the heap, and manipulate it as if we were an interpreter.
This technique works, but we won't pursue it further.
It implies a lot of manual bookkeeping, and (all else being equal) it would be nice to make use of the existing F# compiler to do the heavy lifting for us.

Instead, after sitting with a cup of hot chocolate by the fire for a couple of hours and thinking very hard, we could use the fact that F# is a language with good functional support to capture the intent of what we're trying to do.
The stack holds information about what to do after a recursive call has terminated; but in a functional language, how do we usually express the notion of "what to do now"?
Answer: that's simply a function call.

So how can we express "what to do after the recursion has finished" as a function call, using the heap instead of the stack?
The answer is to *pass in the entirety of the rest of the program as a function*, so that we can call it after our recursive computation has finished.
In more technical terms, we *pass in a continuation*, and we have written a function *in continuation-passing style*.

```fsharp
let insertions
    (y : 'a) (xs : 'a list)
    (andThen : 'a list list -> 'ret)
    : 'ret
    =
    failwith "implement me!"
```

An example call site is:

```fsharp
// Old world, without continuation-passing style
let y = insertions 4 [ 1 ; 2 ; 3 ]
printfn "%+A" y

// Rephrased in the new world
insertions 4 [ 1 ; 2 ; 3 ] (fun y -> printfn "%+A" y)
// or, succinctly:
insertions 4 [ 1 ; 2 ; 3 ] (printfn "%+A")
```

By the way, in real life, it's rather inconvenient to use this phrasing, so we'll often define a little helper function that moves us back into "normal" style:

```fsharp
let insertions' i xs = insertions i xs (fun ret -> ret) // or just `id`

let y = insertions' 4 [1 ; 2 ; 3]
printfn "%+A" y
```

You can think of this helper function as saying "rather than pushing the rest of the program into `insertions`, I will define a little sub-program that simply returns the computed answer, and use the result of that instead".

Now all we have to do is implement the function `insertions` so that it doesn't use any further stack space!

# Implementing the continuation-passing recursion

The easiest way to avoid using any stack space is to make sure that all our recursions are tail-recursions.
Let's start coding, and see what goes wrong and where we need to fix it.

```fsharp
let rec insertions
    (y : 'a) (xs : 'a list)
    (andThen : 'a list list -> 'ret)
    : 'ret
    =
    match xs with
    | [] ->
        // This one's easy; we already know how to compute the value
        // with no recursion at all, so just call `andThen` (i.e.
        // continue with the rest of the program).
        andThen (List.singleton [ y ])
    | x :: xs ->
        // This one's not so clear.
        failwith "implement me!"
```

There's no way we can possibly create a value of type `'ret` except by calling `andThen` or `insertions`.
But to help us decide which to use, remember that the whole point of this method is to use only tail recursion.
We're building up the knowledge of where to go not on the stack, but as explicit closures (which will each be named `andThen` at some point during our repeated recursive calls to `insertions`).

Just to show what goes wrong if we decide not to make our recursive call straight away, let's try making a call to `andThen` here.

```fsharp
let rec insertions
    (y : 'a) (xs : 'a list)
    (andThen : 'a list list -> 'ret)
    : 'ret
    =
    match xs with
    | [] ->
        andThen (List.singleton [ y ])
    | x :: xs ->
        failwith<'a list list> "what goes here?"
        |> andThen
```

We need to make an `'a list list`.
But there's no way to get hold of one that has a hope of containing what we want!
All we have access to is an `'a` and an `'a list`, as well as a way of making `'ret`s (by recursive calls to `insertions`).

Because we started out by making a call to `andThen`, we immediately cut off all our avenues for meaningfully recursing.

So instead of calling `andThen`, we have to backtrack: we call `insertions` instead.
Note that this is a tail call, so the compiler will optimise it away into a loop, using no additional stack space.
Using the types to guide us, we obtain the following:

```fsharp
let rec insertions
    (y : 'a) (xs : 'a list)
    (andThen : 'a list list -> 'ret)
    : 'ret
    =
    match xs with
    | [] ->
        andThen (List.singleton [ y ])
    | x :: xs ->
        fun (result : 'a list list) ->
            failwith<'ret> "TODO"
        |> insertions (failwith<'a> "TODO") (failwith<'a list> "TODO")
```

Now, we can dispense with a couple of these TODOs straight away.
The recursive call to `insertions` is to insert `y` into the remaining `xs`; there's only one possible way the last line could look if we want to preserve the intent of the recursive call.

```fsharp
let rec insertions
    (y : 'a) (xs : 'a list)
    (andThen : 'a list list -> 'ret)
    : 'ret
    =
    match xs with
    | [] ->
        andThen (List.singleton [ y ])
    | x :: xs ->
        fun (result : 'a list list) ->
            failwith<'ret> "TODO"
        |> insertions y xs
```

So there's just one `failwith` left to fill, where we need to come up with a `'ret`.
In hand, we have `result`, the result of the recursive call.
(Remember, we're constructing a lambda which answers the question "what will we do after the recursive call has terminated?".)

We probably don't want to make any *further* recursive calls after we've made one recursive call - certainly in the original naive phrasing we started with, we didn't have to recurse twice - so there's only one possible way left that we could get a `'ret`.

```fsharp
let rec insertions
    (y : 'a) (xs : 'a list)
    (andThen : 'a list list -> 'ret)
    : 'ret
    =
    match xs with
    | [] ->
        andThen (List.singleton [ y ])
    | x :: xs ->
        fun (result : 'a list list) ->
            failwith<'a list list> "TODO"
            |> andThen
        |> insertions y xs
```

Now the body of our lambda says "when you've got a result from your recursive call, do some processing which I've `failwith`ed out, and then go on to do the rest of the program with it".
Going back to our naive phrasing from the very beginning, we used the following to construct a final answer:

```fsharp
(y :: x :: xs)
::
(insertions y xs |> List.map (fun subResult -> x :: subResult))
```

But now we've already *got* the result of the recursive call, because we're in a context where we're continuing with that answer (we're constructing a closure which tells us how to continue).
In the context of this closure, that result is labelled with the name `result`.
So the following snippet is what we want:

```fsharp
(y :: x :: xs)
::
(result |> List.map (fun subResult -> x :: subResult))
```

That is, the final version of the function is as follows:

```fsharp
let rec insertions
    (y : 'a) (xs : 'a list)
    (andThen : 'a list list -> 'ret)
    : 'ret
    =
    match xs with
    | [] ->
        andThen (List.singleton [ y ])
    | x :: xs ->
        fun (result : 'a list list) ->
            (
                (y :: x :: xs)
                ::
                (result |> List.map (fun subResult -> x :: subResult))
            )
            |> andThen
        |> insertions y xs
```

Sure, it might use a lot of heap space, and it's miles slower than a version written with an explicit accumulator or with mutable state - but it won't overflow the stack, and the method we used to generate this function was actually very mechanical!

As a final note, you can recover a non-stack-overflowing function with the original type signature as follows:

```fsharp
let insertions' (y : 'a) (xs : 'a list) : 'a list list =
    insertions y xs id
```

Recall that this is essentially "enter a little sub-program which will do nothing more than return the computed value", so that instead of having to express the rest of our program in the `andThen` argument to `insertions`, we can just assign a variable and proceed as in any other F# program:

```fsharp
// Slightly confusing and rather strange to read
insertions 4 [1 ; 2 ; 3] (fun inserted ->
    // proceed with more stuff here
)

// Much more natural F#
let inserted : int list list = insertions' 4 [ 1 ; 2 ; 3 ]
// proceed with more stuff here
```

# But what about recursing multiple times?

The previous example worked because we were able to tail-call our single recursion, so we didn't need any stack space.
But what about when we write the function `permutations`, which constructs all the permutations of an input?

```fsharp
let insertions (x : 'a) (xs : 'a list) : 'a list list =
    failwith "We did this earlier"

let rec permutations (xs : 'a list) : 'a list list =
    match xs with
    | [] -> [[]]
    | x1 :: xs ->
        permutations xs |> List.collect (insertions x1)
```

This is all fine, and we could use our previous methods to protect us from stack overflow in the recursive call to `permutations`.
But to do so, we would throw away our previous hard work; we'd treat `insertions` purely as an ordinary function `'a -> 'a list -> 'a list list`, without using any of the hard-won CPS machinery with which we implemented `insertions'`.
Then we'd go and implement *yet more* machinery in defining a continuation-passing version of `permutations`.
This is a little warning sign.

In fact, if you have to recurse *twice* rather than merely once, and you can't work out how to express the problem using an explicit accumulator or mutable state, then you really do need something more.
(That's not the case for this problem, but the example is still complex enough that we will see how to develop the machinery to solve it.)
If there are many recursive calls, there's no possible way that *two* recursive calls could both be the last thing the function does, so there's no way the simple tail-call optimisation could take place!
Given a collection of recursive calls, we need to sequence them to be made one at a time.

The machinery we develop to do this will allow us to express `permutations` in terms of the continuation-passing-style `insertions`.
This particular example doesn't need the machinery, and we are not developing it to solve the general "multiple recursive calls" problem here - there is only one recursive call, after all - but in fact the machinery generalises instantly to that problem too.

We will sequence the many continuation-passing calls to `insertions` in such a way that `permutations` can be expressed neatly in continuation-passing style.

Remember, a recursive call in continuation-passing style essentially results in a `('result -> 'ret) -> 'ret` function.
(Imagine partially applying the `insertions` function above. Alternatively, look at the continuation we constructed before passing it into a recursive call to `insertions`.)
So our putative "sequencing" function will take a list of `('result -> 'ret) -> 'ret`, and return a CPS-style `'result list` (i.e. `('result list -> 'ret) -> 'ret`).
That is, we seek a function of the following type signature:

```fsharp
let rec sequence
    (results : (('result -> 'ret) -> 'ret) list)
    (andThen : 'result list -> 'ret)
    : 'ret
    =
    failwith "implement me!"
```

Parenthetical aside: sometimes we might use the following type alias to neaten up the signatures, where a `Continuation<'a, 'ret>` is simply "an `'a`, but in continuation-passing style".

```fsharp
type Continuation<'a, 'ret> = ('a -> 'ret) -> 'ret
```

Anyway, once we've written out the type signature of `sequence`, there are basically only two possible ways to make the types line up while still making all the recursive calls we will need to make.
It's an excellent exercise to try and do this yourself; the experience may well feel like flailing around trying to slot differently-shaped bits of a jigsaw together.
[Chris] presented one of the ways; I'll present the other here, because it fits better with the method used above.

```fsharp
let rec sequence
    (results : (('result -> 'ret) -> 'ret) list)
    (andThen : 'result list -> 'ret)
    : 'ret
    =
    match results with
    | [] -> andThen []
    | andThenInner :: andThenInners ->
        fun (results : 'result list) ->
            fun (result : 'result) ->
                result :: results
                |> andThen
            |> andThenInner
        |> sequence andThenInners
```

## What does `Continuation.sequence` do?

It's all very well to have written out a function with the right type signature, but what does it actually do?

Just like in the other examples of a tail-recursive CPS function, the call to `sequence` essentially iterates over the input list constructing an ever larger closure on the heap.
The actual contents of this closure don't matter until the input list runs out; we're simply spinning round in a loop, building a bigger and bigger closure while truncating the input list one at a time.
No meaningful computation is taking place at all: we're just building the instructions in memory that we are *going* to carry out, in the form of an enormous closure.

But when the input list *does* run out, we evaluate this enormous closure on the input `[]`.
That is, we evaluate `andThenInner (fun result -> andThen (result :: []))`, where `andThenInner` is the most-recently-seen (i.e. the last) element of the original list `results` of continuation-passing-style inputs, and `andThen` is the enormous closure but with one layer unpeeled (because we applied it to `[]` in the previous step).

That is, we evaluate the last element of the list, and then inject it into the enormous closure, effectively leaving us with the enormous closure applied to `results.Last :: []` (where we have used an imaginary `list.Last` notation that doesn't actually exist in F#).

The computation unspools in exactly the same way through the input list, at each stage unwrapping one layer of the enormous closure and injecting the value represented by the previous element of the input list of continuations.

At the very end, the enormous closure has been unwrapped all the way down to the original `andThen` that was passed in at the very start; no longer does the binding `andThen` correspond to a closure that we created during the course of our recursion.
This is the final escape hatch: the evaluation is complete, and `andThen` tells us to continue execution in user code.

By the way, this demonstrates that the *last* element of the input list is the one which executes *earliest*.
While the order of elements as presented to the user's continuation is the same as the order in which they appear in the input list of continuations, the order in which the result list is *generated* is from the end backwards.
If all functions are side-effect-free, this doesn't matter at all, but if your continuations are side-effectful then you should keep this at the back of your mind.
The clue in the name ("sequence") indicates that the continuations are being, well, put into sequence; but you should know what order the sequence is being computed in.

# Apply `Continuation.sequence` to compute permutations

Recall our definition of `permutations` from earlier:

```fsharp
let rec permutations (xs : 'a list) : 'a list list =
    match xs with
    | [] -> [[]]
    | x1 :: xs ->
        permutations xs
        |> List.collect (insertions x1)
```

To translate this into continuation-passing style, it needs the following type signature:

```fsharp
let rec permutations (xs : 'a list) (andThen : 'a list list -> 'ret) : 'ret =
    failwith "implement me!"
```

Now, we certainly *could* do this without `Continuation.sequence`.
We already have an implementation of `insertions` which uses continuation-passing style to make itself tail-recursive, after all.

```fsharp
let rec permutations' (xs : 'a list) (andThen : 'a list list -> 'ret) : 'ret =
    match xs with
    | [] -> andThen [[]]
    | x :: xs ->
        fun (remainder : 'a list list) ->
            remainder
            |> List.collect (fun i -> insertions x i id)
            |> andThen
        |> permutations' xs
```

However, it's a bit weird to jump in and out of CPS like this.
There's nothing wrong with it, but for the exercise, could we use `insertions x i` in continuation-passing style rather than by forcing its execution with `id`?

This is why we need `Continuation.sequence`.

Start in the only possible way we can absolutely guarantee tail recursion: by writing down the recursive call to `permutations'`.

```fsharp
let rec permutations' (xs : 'a list) (andThen : 'a list list -> 'ret) : 'ret =
    match xs with
    | [] -> andThen [[]]
    | x :: xs ->
        fun (recurseResult : 'a list list) ->
            failwith<'ret> "now implement me"
        |> permutations' xs
```

What do we have in scope to fill the `failwith`?
It has to be either `andThen`, or a call to `Continuation.sequence`, since we probably don't want to do *another* call to `permutations'`.

If we consider for a moment what would happen if we tried `andThen`:
```fsharp
let rec permutations' (xs : 'a list) (andThen : 'a list list -> 'ret) : 'ret =
    match xs with
    | [] -> andThen [[]]
    | x :: xs ->
        fun (recurseResult : 'a list list) ->
            failwith<'a list list> "implement this?"
            |> andThen
        |> permutations' xs
```
This is how we recover the solution further above, which I described as "a bit weird": we're going to have to jump out of CPS to get an `'a list list` from `insertions`.

So we'll go with `Continuation.sequence` instead, so that we can collect results from multiple CPS calls to `insertions` - but note that this introduces a free type parameter, expressed with `_`:

```fsharp
let rec permutations' (xs : 'a list) (andThen : 'a list list -> 'ret) : 'ret =
    match xs with
    | [] -> andThen [[]]
    | x :: xs ->
        fun (recurseResult : 'a list list) ->
            sequence
                (failwith<((_ -> 'ret) -> 'ret) list> "implement")
                (failwith<_ list -> 'ret> "implement")
        |> permutations' xs
```

And since it's multiple calls to `insertions` we wish to collect together, the type of those holes is decided:

```fsharp
let rec permutations' (xs : 'a list) (andThen : 'a list list -> 'ret) : 'ret =
    match xs with
    | [] -> andThen [[]]
    | x :: xs ->
        fun (recurseResult : 'a list list) ->
            let conts : (('a list list -> 'ret) -> 'ret) list =
                List.map (insertions x) recurseResult
            sequence
                conts
                (failwith<('a list list) list -> 'ret> "implement")
        |> permutations' xs
```

Notice how the original `List.collect` was forced to become a `List.map` here: we were unable to immediately concatenate the results of the various calls to `insertions`.
In the original non-CPS style, our `'a list list list` could become `'a list list` by implicitly squashing together the outermost pair of `list` with a call to `List.collect`; but now there is a CPS `(_ -> 'ret) -> 'ret` in the way.
So we'll have to `List.concat` explicitly after sequencing these recursive calls together.

```fsharp
let rec permutations' (xs : 'a list) (andThen : 'a list list -> 'ret) : 'ret =
    match xs with
    | [] -> andThen [[]]
    | x :: xs ->
        fun (recurseResult : 'a list list) ->
            let conts = List.map (insertions x) recurseResult
            sequence conts (List.concat >> andThen)
        |> permutations' xs
```

Voilà!

# Exercises

* Easy: define the type `Cont<'a, 'ret> = ('a -> 'ret) -> 'ret`, and implement `Continuation.bind : ('a -> Cont<'b, 'ret>) -> Cont<'a, 'ret> -> Cont<'b, 'ret>`. You've essentially defined the Continuation monad. Note that `Continuation.sequence` is the standard notion of `sequence` for a traversable, applied to the functor `List`.
* Moderately difficult: Make sure you understand, in the definition of `permutations'`, when each part executes relative to each other part. To really test your bookkeeping: in what order are the permutations created, and in what order are they output?
* Difficult: Check Chris's definition of `Continuation.sequence`, which is different from the one presented here. How are the two definitions different? In what order do they evaluate, and in what order do they return?
Hint: Try it out using the following!

```fsharp
let mutable j = 0
sequence [for _ in 1..100 do yield (fun andThen -> andThen (j <- j + 1 ; j))] (printfn "%+A")
```

* Moderately difficult: construct a "seq-safe" version of `Continuation.sequence`, with type signature `(inputs : (('result -> 'ret) -> 'ret) seq) -> (andThen : 'result list -> 'ret) -> 'ret`, where we have replaced the inputs with a `seq` rather than a `list`. This version must enumerate the input sequence only once; if you ever call `Seq.head`, for example, you've already enumerated the input sequence up to the first element, and you've run out of enumeration budget! This would matter a lot if, for example, the sequence opens a database connection or mutates a stream.
* Very difficult: is it possible to construct a lazy version of `Continuation.sequence`, with type signature `(inputs : (('result -> 'ret) -> 'ret) seq) -> (andThen : 'result seq -> 'ret) -> 'ret`, where we have replaced the `list`s with `seq`s, which only enumerates as much of the input sequence `inputs` as `andThen` asks for?


[Chris]: https://www.gresearch.co.uk/article/advanced-recursion-techniques-in-f/
[discussed]: {{< ref "2020-07-22-tailrecursion" >}}
