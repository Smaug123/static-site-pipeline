---
lastmod: "2021-06-01T19:45:48.0000000+01:00"
author: patrick
categories:
- programming
- g-research
comments: true
date: "2021-05-27T00:00:00Z"
title: Metatesting your property-based tests
summary: "A rather little-known but very easy and high-reward way to sanity-check your property-based tests."
math: true
---

*Cross-posted at the [G-Research official blog](https://www.gresearch.co.uk/article/metatesting-your-property-based-tests/)*.

Property-based testing is a great technique for getting the computer to do much of the drudgery when you're writing tests.
But it's pretty easy to accidentally test much less than you thought.
Here, we'll go over an extremely easy technique you can use to automatically test your own test coverage.

This post is written in [F#], an impure functional-first language.
F#'s impurity is actually what makes this technique so easy; in a pure language like Haskell, the same goal has to be achieved using more machinery.

# What is property-based testing?

"Property-based testing" refers to any method of testing which focuses around defining *properties that your programs obey* rather than *specific test cases your programs satisfy*.
That is, the programmer writes down some kind of general desired fact about the program, and the computer creates test cases to try and disprove that fact.

The first and most popular implementation of a property-based testing library is Haskell's [QuickCheck].
QuickCheck has many ports into other languages, and the one we'll be using is [FsCheck] for F#.

## Example

Here's a little bare-bones implementation of an "interval set": a set of integers, but stored in a space-efficient way if there are many consecutive runs of integers in the set.

The defining example is as follows.

```fsharp
type IntervalSet = private | IntervalSet of (int * int) list

IntervalSet [ (1, 4) ; (8, 10) ]
|> IntervalSet.toSet
|> shouldEqual (Set.ofList [ 1 ; 2 ; 3 ; 4 ; 8 ; 9 ; 10 ])
```

(I've used a `list` here rather than a `Set` as the underlying data structure, just to make the code a bit shorter.)

Let's say we want to test a small public API.

```fsharp
module IntervalSet =
    val empty : IntervalSet
    val add : int -> IntervalSet -> IntervalSet
    val contains : int -> IntervalSet -> bool
    val ofList : int list -> IntervalSet
```

Here's a small, trivial implementation - which does have a correctness bug, since this is a post about testing!
To make the code smaller, it also has efficiency bugs: for example, it doesn't even try to join intervals together if they grow to overlap each other, and it's also possible for the same integer to appear twice in the interval-set.

```fsharp
type IntervalSet = private | IntervalSet of (int * int) list
module IntervalSet =
    let empty = IntervalSet []
    let contains (a : int) (IntervalSet intervals) =
        intervals
        |> List.exists (fun (min, max) -> min <= a && a <= max)

    let rec private add' (a : int) (intervals : (int * int) list) =
        match intervals with
        | [] -> [ (a, a) ]
        | (min, max) :: rest ->
            if min <= a && a <= max then
                // No need to add, because it's already there
                intervals
            elif min - 1 = a then
                // Augment this interval to contain the new number
                (a, max) :: rest
            elif max + 1 = a then
                // Augment this interval to contain the new number
                (min, a) :: rest
            else
                // Can't add it to this interval; recurse.
                add' a rest

    let add (a : int) (IntervalSet intervals) =
        add' a intervals
        |> IntervalSet

    let ofList (numbers : int list) : IntervalSet =
        numbers
        |> List.fold
            (fun set i -> add i set)
            empty
```

Here are some tests, which all pass, so we commit the code and move on with our lives.

```fsharp
IntervalSet.ofList [ 3 ; 4 ]
|> IntervalSet.contains 5
|> shouldEqual false

IntervalSet.ofList [ 3 ; 5 ]
|> IntervalSet.contains 5
|> shouldEqual true

IntervalSet.ofList [ 3 ; 4 ; 5 ]
|> IntervalSet.contains 5
|> shouldEqual true
```

Then eventually someone comes along and points out that the following test fails!
```fsharp
IntervalSet.ofList [ 0 ; 2 ]
|> IntervalSet.contains 0
|> shouldEqual true
```

Property-based testing is an answer to this problem of incomplete test coverage.
It allows us to write more comprehensive tests with less drudgery: we specify directly the properties we wish to hold, rather than listing specific examples of those properties.

The obvious property we want here is that checking a list of integers for containment should be the same as testing the interval set for containment.

```fsharp
let property (ints : int list) (toCheck : int) : bool =
    IntervalSet.ofList ints
    |> IntervalSet.contains toCheck
    |> (=) (List.contains toCheck ints)
```

And FsCheck can check this for us:

```fsharp
open FsCheck

[<Test>]
let ``Test by comparing to a list`` () =
    Check.QuickThrowOnFailure property
```

After one run, I get this output:

```
Falsifiable, after 8 tests (4 shrinks) (StdGen (476991543,296861283)):
Original:
[-3; -1; 0; 0; 0; 0]
-3
Shrunk:
[-3; 0]
-3
```

FsCheck has found a failing case and has even found another one which is nice and small for us.

## The bug

By the way, the bug was in the recursion for `add'`:

```fsharp
let rec private add' (a : int) (intervals : (int * int) list) =
    match intervals with
    | [] -> [ (a, a) ]
    | (min, max) :: rest ->
        if min <= a && a <= max then
            // No need to add, because it's already there
            intervals
        elif min - 1 = a then
            // Augment this interval to contain the new number
            (a, max) :: rest
        elif max + 1 = a then
            // Augment this interval to contain the new number
            (min, a) :: rest
        else
            // Can't add it to this interval; recurse.
            // *** This line has changed! ***
            (min, max) :: add' a rest
```

# The silent difficulty with property-based testing

How do we know we ever hit any interesting behaviour?
In the example above, our property is of the form "do something, then check whether the result is equal to a `List.contains` call".
But what if that `List.contains` never outputs `true`?
Then we're just generating lots of uninteresting tests which all look like "is `59` in the set `{1, 2, 3}`?", and we're never actually testing the important cases!

Happily, though, F# is impure, so we can actually *assert* whether this is happening extremely easily.

```fsharp
let property
    (positiveCount : int ref) (negativeCount : int ref)
    (ints : int list)
    (toCheck : int)
    : bool
    =
    let contains = List.contains toCheck ints
    if contains then incr positives else incr negatives
    IntervalSet.ofList ints
    |> IntervalSet.contains toCheck
    |> (=) contains
```

Now, the call site looks like this:

```fsharp
[<Test>]
let ``Test with instrumentation`` () =
    let pos = ref 0
    let neg = ref 0
    Check.QuickThrowOnFailure (property pos neg)

    pos.Value |> shouldBeGreaterThan 0
    neg.Value |> shouldBeGreaterThan 0

    // And test the balance of cases, for good measure
    (float pos.Value) / (float pos.Value + float neg.Value)
    |> shouldBeGreaterThan 0.1
```

We're now *asserting at test time* that at least 10% of our cases are indeed the "list does contain" case.

And in fact this test now becomes flaky!

```
Expected: 0.1
Actual: 0.08

at FsUnitTyped.TopLevelOperators.shouldBeGreaterThan
```

We have successfully turned our own uncertainty into a flaky test.

# What to do about it

We need to fix the flaky test.

One way to do this is to manipulate the generators FsCheck is using to construct test cases.
We can make a generator of `int list * int`, where the list contains the `int` about 50% of the time.
(I won't go into how to do this now; the [FsCheck documentation on Test Data](https://fscheck.github.io/FsCheck/TestData.html) is pretty comprehensive.)
Then when we use this new generator, we’re extremely likely to pass the “more than 10% of our generated test cases are of the positive case” check.
Indeed, we’re taking many independently-sampled cases (by default, FsCheck generates 100 of them), and we’ve tweaked the distribution so that these samples are of the positive case with 50% probability, and to pass the check we only need 10% of them to be testing the positive case; so the probability of this test failing after the generator is set up correctly is actually around \\(1.5 \times 10^{-17}\\) (being \\(\mathbb{P}(X \le 10)\\) when \\(X\\) follows the binomial distribution on 100 trials with probability \\(\frac{1}{2}\\) of success).

Depending on how many property-based tests you have, and how frequently they are run, you may want to make spurious failure less likely even than this; you can do so by skewing the generator even further towards positive cases, or by increasing the number of trials FsCheck runs.

# How would you approach this in Haskell?

Haskell is a pure language, so you can't just do the cheap answer we did here of mutating some external state from within the property.
Instead, QuickCheck comes with the function [`checkCoverage`](https://hackage.haskell.org/package/QuickCheck-2.14.2/docs/Test-QuickCheck.html#v:checkCoverage), which you can set up with conditions you want to assert about test distributions.
Note that `checkCoverage` is smarter than our cheap solution, though, because it does statistical tests to try and minimise the chance of spurious failures; above, I just did the calculation to discover the probability of spurious failure, but it's certainly not always so easy.

# FsCheck's in-built support

FsCheck does have some methods (documented as [FsCheck: Observing Test Case Distribution](https://fscheck.github.io/FsCheck/Properties.html#Observing-Test-Case-Distribution)) which let you find things out about test distributions.
For example, `Prop.trivial` allows you to mark an outcome as being "trivial" or as falling into one or more categories, and you can then get FsCheck to tell you the distribution of test cases across the various categories.
However, I honestly think it's easier and more readable to do it yourself using the cheap method from this post.

# Conclusion

When I implemented automated coverage checks this way in one of our internal projects, I discovered several parts of our API surface that just weren't tested at all by property-based tests.
It was trivial to fix up the test generator so that those parts were hit, but if we hadn't put in this automated instrumentation, we would probably never have found out until our users started submitting bug reports about those under-tested parts of our API.

If you're using property-based testing (which you should be!), you should pay attention to the distribution of test cases you're getting from the generator library.
Check that the tests are actually as comprehensive as you hoped.
It's extremely easy to do this in F#, and it takes no knowledge of the FsCheck library to do it; anyone who speaks only a little F# can come in and add this metatesting to an existing property-based test suite, even if they know nothing about how FsCheck works.

[F#]: https://en.wikipedia.org/wiki/F_Sharp_(programming_language)
[QuickCheck]: https://en.wikipedia.org/wiki/QuickCheck
[FsCheck]: https://github.com/fscheck/FsCheck
