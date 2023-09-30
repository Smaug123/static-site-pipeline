---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- programming
- g-research
comments: true
date: "2020-07-22T00:00:00Z"
aliases:
- /tail-recursion-for-loops/
title: In favour of recursive functions, not imperative constructs, to make loops
summary: "How to write loops immutably and safely."
---

*Cross-posted at the [G-Research official blog](https://www.gresearch.co.uk/article/in-favour-of-recursive-functions-not-imperative-constructs-to-make-loops/)*

## Setting the scene

It's a fresh new day at work, and you want to find the dot product of two arrays (that is, the sum of the product of the pairs of elements).
You're using your favourite language, [F#](https://en.wikipedia.org/wiki/F_Sharp_(programming_language)).
You're allergic to `Seq.zip` (maybe you're terrified of virtual calls or something), and `Array.zip` just allocates too much memory.
Also, you want to make sure you can bail out of the iteration early; what if someone tells you at the last minute that you have to stop if you see the number `100`?

Cracking your knuckles, the following pours from your fingertips:

```fsharp
type Index = int

let truncatedDotProduct
    (shouldContinue : Index -> int -> int -> bool)
    (xs : int array)
    (ys : int array)
    : int
    =
    let mutable ans = 0
    let mutable (i : Index) = 0
    while (shouldContinue i xs.[i] ys.[i]) do
        ans <- ans + (xs.[i] * ys.[i])
    ans
```

Easy, of course!
And then you write the unit tests and discover how truly exquisite is the infinite loop you have made.

With a gentle sigh of one who has arisen bright and refreshed only to discover the computer in a sullen and recalcitrant mood, you insert the line that makes everything work.

```fsharp
type Index = int

let truncatedDotProduct
    (shouldContinue : Index -> int -> int -> bool)
    (xs : int array)
    (ys : int array)
    : int
    =
    let mutable ans = 0
    let mutable (i : Index) = 0
    while (shouldContinue i xs.[i] ys.[i]) do
        ans <- ans + (xs.[i] * ys.[i])
        // How weary, stale, flat, and unprofitable
        // seem to me all the uses of this world
        i <- i + 1
    ans
```

Now the tests pass, and you can stride forward into a glorious day of productivity.

But wouldn't it have been lovely if this mistake hadn't happened?

## Going loopy

The mistake was that we introduced a piece of state, but never changed it.
A sufficiently advanced compiler can warn us about a variable that is set but never used - but the problem still remains in general.
(What if we had printed the iteration variable, and therefore used it? Or what if we had a slightly more complicated computation for which we legitimately performed some mutation to the state in our loop body, but still forgot to do the final increment?)

With a small change to the shape of this function, we can make the bug so obvious that we would never dream of making it.

```fsharp
type Index = int

let truncatedDotProduct
    (shouldContinue : Index -> int -> int -> bool)
    (xs : int array)
    (ys : int array)
    : int
    =
    let rec go (ans : int) (i : Index) =
        if shouldContinue i xs.[i] ys.[i] then
            go (ans + (xs.[i] * ys.[i])) (i + 1)
        else
            ans

    go 0 0
```

Now we are forced to declare explicitly that the index in the next iteration will be `i + 1`.
Merely omitting this decision is not an option any more, because the compiler will force us to give a second argument to `go` whenever we invoke it.

As an added bonus, the termination condition of the loop has been tidied up; I would argue that it's now easier to see that if `shouldContinue` fails, we return the value we'd got up to *before* the current index.
(Admittedly, that one is more of a matter of taste; maybe you personally find it easier to understand the termination condition of the explicit `while` loop.)

And in a language like F#, we don't even lose any performance using this approach.
A language with [tail-call optimisation](https://en.wikipedia.org/wiki/Tail_call) will optimise away the recursive call into an imperative loop behind the scenes; in fact, the recursive and the imperative code may well boil down to exactly the same machine code.
(By contrast, some languages like Python lack tail-call optimisation, so in Python this approach is liable to end in a stack overflow.)

## Backing off

For another prime example, consider a famous saying:

> If at first you don't succeed, try, try again.

What is less often noted is that one should wait some period of time in between each retry.

Of course, there are libraries which do this for you ([Polly], for example).
But for the sake of argument, let's say we want to write a simple exponential backoff ourselves.
(We'll mock out the `sleep` function, to allow us to test the logic more easily; it'll probably be given as `System.Threading.Thread.Sleep` at the call site, but nobody wants to be calling `Thread.Sleep` in a unit test.)

```fsharp
open System

let doThingRetryingWithBackoff<'err>
    (sleep : TimeSpan -> unit)
    (maxRetries : int)
    (backoff : TimeSpan)
    (doThing : unit -> Result<unit, 'err>)
    : Result<unit, 'err>
    =
    let mutable retries = 0
    let mutable lastError = None
    let mutable isDone = false
    while (not isDone) && retries < maxRetries do
        match doThing () with
        | Ok () -> isDone <- true
        | Error e ->
            lastError <- Some e
            retries <- retries + 1
            if retries < maxRetries then
                sleep (backoff * (2. ** float retries))

    if (not isDone) && retries = maxRetries then
        Error (Option.get lastError)
    else Ok ()
```

Easy enough, but let's give it the recursive treatment:

```fsharp
open System

let doThingRetryingWithBackoff<'err>
    (sleep : TimeSpan -> unit)
    (maxRetries : int)
    (backoff : TimeSpan)
    (doThing : unit -> Result<unit, 'err>)
    : Result<unit, 'err>
    =
    let rec go (retriesPerformed : int) =
        match doThing () with
        | Ok () -> Ok ()
        | Error e ->
            let newRetries = retriesPerformed + 1
            if newRetries >= maxRetries then
                Error e
            else
                sleep (backoff * (2. ** float newRetries))
                go newRetries

    go 0
```

No need for the sad `isDone` sentinel here!
Since looping was an active choice (an explicit call to `go`), we were free simply to choose not to loop at any point, and specifically at the point where `doThing` had returned successfully.

## The barest essentials

Sometimes we don't even need any state at all!

```fsharp
open System

let pollInfinitely<'a>
    (sleep : TimeSpan -> unit)
    (poll : unit -> 'a)
    (doThings : 'a -> unit)
    : unit
    =
    while true do
        let values = poll ()
        doThings values
        sleep (TimeSpan.FromSeconds 5.)
```

Or, in the shiny new world which is free of `while`:

```fsharp
open System

let pollInfinitely<'a>
    (sleep : TimeSpan -> unit)
    (poll : unit -> 'a)
    (doThings : 'a -> unit)
    : unit
    =
    let rec go () =
        let values = poll ()
        doThings values
        sleep (TimeSpan.FromSeconds 5.)
        go ()

    go ()
```

This example looks too simple to be of any use, and maybe indeed it is; and of course in real life there is `System.Timers.Timer` which solves this problem better.
(This is only a toy example.)

But I would argue that once you're familiar with the general pattern, this is a natural way to express the loop.
Moreover, it is extremely extensible: if we decide we don't actually want to loop forever, it's trivial to add extra state by inserting it as parameters to `go`, and the compiler will try its best to help us use it correctly.
(By contrast, with the `while` loop and mutable state, we are on our own: the compiler can't know what we had in mind for the state.
It will freely let us either modify the state when we didn't want to, or fail to modify it when we did want to.)

## Winding up

Though it may look very odd at first sight, it soon becomes quite natural to think about loops in this recursive way.
It allows you to express more of the problem in the type system, helping the compiler to point out when you've done things like "adding a new piece of state but forgetting to use it everywhere you wanted it".
It also makes the act of looping into a conscious choice at each stage; if you've ever longed for the good old days of `goto` to break out of loops, this actually gives you back something of that flavour, but much more safe!

Making the loop state immutable makes it easier to reason about the invariants and behaviour of the loop, and helps you write safer programs fast.

[Polly]: https://github.com/App-vNext/Polly
