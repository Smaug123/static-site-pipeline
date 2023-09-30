---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- programming
- mathematics
comments: true
date: "2018-07-21T00:00:00Z"
aliases:
- /dependent-types-overview/
title: Dependent types overview
summary: "A quick overview of dependent types."
---

# Proving things in Agda, part 1: what is dependent typing?

[Agda] is a [dependently-typed] programming language which I've been investigating over the last couple of months, inspired by Conor McBride's [CS410] lecture series.
Being dependently-typed, its type system is powerful enough to encode mathematical truth, and you can use the type system to verify proofs of mathematical statements, as well as to almost completely obviate the need for tests by having the compiler verify almost any property of your program.
This post is an overview of what that means.

Before you read any of the Agda code that lives in [my Agda repository][GitHub], please keep in mind that I'm an Agda novice who is exploring.
I make no claims that any of this code is any good; only that it is correct.
I'm also not interested in performance, since I'm using it as a proof environment rather than as a source of runnable programs; while all of the code is runnable, I have not optimised it at all.
We shall see that the mere existence of these programs is enough to constitute mathematical proof.

## What is a type system?

I think of a type system as one or both of two things.

* A way of informing the compiler that certain objects are supposed to match up in certain ways, such that this information may vanish at runtime but allows the compiler to help you when you're writing the program.
* A way of ensuring at runtime that you don't perform nonsensical operations on objects that don't support those operations.

For example, the language Python has a type system which is "dynamic": you don't specify the type of an object while you're writing the program, so the compiler can't really use type information to help you.
The language F# has a "static" type system: you specify the type of every object up front, while you're writing the program, so the compiler has more opportunities to tell whether you've told your program to do something inconsistent.

From now on, I'll focus on the first kind of type system (i.e. on type systems where you specify types while you're writing the program, so the compiler can help you).

## What can a type system do for you?

Any Python programmer has probably encountered a certain extremely common bug: since strings are iterable, it's all too easy to iterate accidentally over a single string when you intended to iterate over a list of strings.
A baby example, in which the bug is very obvious, is as follows:

{{< highlight python >}}
stringsList = ["hello", "world"]
for ch in stringsList[0]: # Oops - stringsList[0], not stringsList
    print(ch)
# Expected: "hello" and then "world"
# Actual: "h", then "e", then "l", then "l", then "o"
{{< / highlight >}}

Python's dynamic typing means that you often can't find out that you've iterated over the wrong thing until you come to run the program and discover that it blows up.
(It doesn't help that there's no such thing as a character in Python; only a string of length 1.)

In F#, this is a class of bug that never makes it to runtime, because you know the type of every variable up front.

{{< highlight fsharp >}}
let stringsList = [ "hello" ; "world" ]
stringsList.[0]
|> List.map (printfn "%s") // doesn't compile!
{{< / highlight >}}

`List.map` can't take a string as an argument.
Even if it could, `printfn "%s"` can't take a character as an argument.

The type system has protected you from this particular bug.
So far, so familiar.

## Dependent types?

In most common type systems, you're restricted to declaring that any particular object inhabits one of some fixed collection of types, or inhabits a type that is built out of those.
(For example, `string` or `int` or `List<Map<int, Set<char>>>`).
This deprives you of some power: there may be things you know about your program, which you proved to your own satisfaction when you wrote it, but which you have been unable to tell the compiler because the language's type system was not expressive enough.

For example, the following (very inefficient) program computes highest common factors of integers:

{{< highlight fsharp >}}
let rec euclid a b =
    if a < b then euclid b a
    elif a = b then a
    else euclid (a - b) b
{{< / highlight >}}

The F# compiler can tell me that I haven't made any of a collection of stupid errors - it will stop me from trying to compute the highest common factor of `"hello"` and `[1 ; 2]`, for example, and it tells me that I've given `euclid` the right number of arguments in the recursive call.
However, in order to know that my function really does compute highest common factors, you need to execute tests.
(Did you spot the bug in the program? The compiler certainly didn't, because F# doesn't let me inform the compiler that the program is meant to be computing highest common factors, so the compiler doesn't know what to check for.)

But a *dependently-typed* language has the expressive power to lift values themselves, and therefore much more general statements about values, into the type system.
A dependently-typed language can define a function whose type signature contains terms which depend on other arguments to the function, and can thereby express restrictions on the possible arguments that the function can take *which are enforced at compile-time*.
Much like F# can prevent you from applying `euclid` to a string, so a dependently-typed language can prevent you from applying `euclid` to a nonpositive number, and can thereby protect you from one bug which is present in the `euclid` above (namely, that the function does not terminate under some conditions, e.g. when `b = 0`).
Several examples of this will appear later.

Moreover, while any particular non-dependently typed language could in theory have been designed to contain a type for the strictly positive integers (and thereby protect you from that bug, converting it into a compile error), only a dependently-typed language will allow you to construct arbitrary restrictions which the language inventors didn't think of in advance.

In theory, you can use a dependent type system to encode *any* information about the output of your program, in such a way that the compiler knows so much that it will refuse to compile any program that fails to adhere to the specification you gave.
You can rule out *any* output-based bug if you take enough time over the program specification.
(Strictly, you need to assume that the compiler is bug-free, and that the implementation of the computer you're running the program on is bug-free, and so forth. No compiler will protect you in full generality from cosmic rays flipping bits in memory while your program is executing.)

## Propositions as types

Health warning: this concept is one that takes a while to grok, so I will not devote much time to it.
For me, it took several hours of example sheets followed by a very clear explanation from my Logic and Sets supervisor.

The trick for using a dependently-typed language to encode properties of your program is to use this magical ability to raise values up into the type level.
The most fundamental expression of this concept is the "equality type": for every value `a`, there is a type `=a= : T -> T` (where `T` is the universe of all possible values and types).
A member of `=a= b` is an object that somehow expresses the notion that `a = b`.
(Much in the same way as how a member of `int` somehow captures an object that is an integer, so a member of `=a= b` somehow captures a proof that `a = b`.)

There are several possible ways one could implement this type.
For example, one could define `=a= b` to be the type of all proofs that `a = b` in a mathematical sense; then there are a couple of ways to generate members of `=a= b` (for example, "prepend a proof that `a = c` to a proof that `c = b`"), and there might be many different proofs that `a = b`.
But in any sane world, no matter what the other ways are to create a proof that `a = b`, there is certainly a canonical thing that `a` is equal to: namely, `a` itself!
So `=a= a` is a type that should definitely have an inhabitant no matter what system we're working in: namely, the inhabitant that expresses the fact that `a = a` canonically.

In fact, Agda goes further than this and asserts that this is the *only* inhabitant of that type, and moreover that there is no other way to create a member of `=a= b` than to identify `b` with `a` and to use the canonical `a = a`.
In Agda, if you've proved that two things are equal, then they are literally identical; if you want anything looser, like the notion of "isomorphic", or if you want to capture the idea that you might be able to prove equality in more than one way, then you'll have to define primitives for that yourself.

## A real example

The upshot of the above is that you may insist, in the functions that you define, that something is equal to something else.
This opens the door to expressing in the type system, for example, that an integer can be decomposed into a modulus and a remainder in a certain way.
In Agda (here, this is in my [EuclideanAlgorithm.agda]):

```agda
record divisionAlgResult (a : ℕ) (b : ℕ) : Set where
    field
    quot : ℕ
    rem : ℕ
    pr : a *N quot +N rem ≡ b
    remIsSmall : (rem <N a) || (a ≡ 0)
```

(Here, `*N` is the operation of multiplication on the natural numbers, `<N` is the type of proofs that the left-hand is less than the right-hand as natural numbers, and `+N` is the addition of naturals.
Also `||` is the "or" type which expresses that a particular one of the left-hand or the right-hand operand is inhabited.)

This is a declaration of a record type with four fields: a quotient and a remainder (which are naturals), together with a proof object witnessing that `a * quot + rem = b`, and a proof object witnessing that the remainder is smaller than `a` (and hence that `rem` really is the value of `b` modulo `a`).

An inhabitant of this record type is simply a proof that `b` can be decomposed into a quotient and a remainder on division by `a`.

Observe that this doesn't actually construct the record for you; it's a declaration of a type, not a construction of an object of that type.
It still remains for the programmer to provide a function `(a : ℕ) -> (b : ℕ) -> divisionAlgResult a b` and thereby show that the decomposition is always possible.
Note also that the function signature I just specified is itself an example of lifting values into the type system: the return type `divisionAlgResult a b` depends on the input values `a` and `b`.
This reflects the fact that one may construct proofs *about specific objects*: a `divisionAlgResult a b` is a proof of a certain property of specific integers `a` and `b` (namely "we can find `b % a` and `b / a`").

Crucially, if I can ever get my hands on a `divisionAlgResult a b`, then I know incontrovertibly (in a way that is guaranteed at compile-time) that the `rem` field and the `quot` field together satisfy `a * quot + rem = b`.
There is no way to make one of these objects without supplying a proof that the quotient and the remainder behave in this way.
That means, for example, that there is no possible off-by-one error: I cannot somehow accidentally use the fact `a * quot + rem = b + 1` in a context where I intended to use `a * quot + rem = b`, because the compiler will notice that the thing I am trying to use has type `pr : a *N quot +N rem ≡ b +N 1` instead of `pr : a *N quot +N rem ≡ b`.
The potential off-by-one error has become a type error, caught at compile time, rather than a runtime error that could only be caught by tests.

## Example: the Hello World of dependently typed languages

The canonical intro to a dependently-typed language is a program `rev` which reverses lists, together with a proof that applying `rev` twice is just the same as the identity function.

In [my own Agda library][GitHub], this is the function `rev` in [Lists/Reversal/Reversal.agda], and the proof is named `revRevIsId`.
I shall remove some of the arguments which are only there for technical reasons related to preventing Russell's paradox, and give its signature:
`revRevIsId : {A : Set} → (l : List A) → (rev (rev l) ≡ l)`.
That is, whenever we have a type (or, in Agda's language, `Set`) called `A`, we can take a list `l` of things of type `A`, and produce a proof that reversing `l` twice yields a list which is identical to `l`.

If I had made any mistakes in the definition of `rev`, then the compiler would have caught them insofar as those mistakes prevented `rev (rev l)` from being identical to `l` for all `l`.
There is no need to test the `rev` function for this property: I have proved that it holds, and the compiler has verified my proof.
If it were ever false, there would be an error in my proof, and the compiler would have been unable to compile the function `revRevIsId` that embodies that proof.

One could, if desired, run my function `revRevIsId` explicitly on some list.
Then one would obtain at runtime a proof that `rev (rev l)` is equal to `l`.
But I certainly don't expect anyone to run this function; merely the fact that one *could* run it, and if one did then it would always produce an equality, is enough to guarantee the correctness of `rev` in this aspect.

Ultimately my proof uses a few intermediate facts, which I had to prove first:

* Concatenating the empty list to the end of `l` yields `l`;
* Concatenation of lists is associative;
* We can pull the head off a concatenated list in the obvious way (this is hard to say in any kind of slick way, but I named the theorem `canMovePrepend` in [Lists.agda]);
* `rev (l ++ m)` is equal to `(rev m) ++ (rev l)`.

I proved each of these facts, then converted my proof into a program that could be used in theory on any given list to produce objects that witnessed the truth of each fact when specialised to that list.

# Next steps: mathematics

This post has been a whistlestop tour of why one might be interested in dependent types, and how in principle they can be used to write proofs of correctness instead of having to rely on tests.
The next post will look in more depth at how Agda's type system can be used to check mathematical proofs, and will go into some detail about how "(constructive) proof" and "program" are really the same thing.
Ultimately we will produce a program/proof that is on the one hand a proof of the Fundamental Theorem of Arithmetic (roughly, "every natural decomposes uniquely into prime factors"), and is on the other hand a fully-verified program that factorises naturals with no tests required.

[Agda]: https://en.wikipedia.org/wiki/Agda_(programming_language)
[dependently-typed]: https://en.wikipedia.org/wiki/Dependent_type
[CS410]: https://www.youtube.com/watch?v=O4oczQry9Jw
[Lists/Reversal/Reversal.agda]: https://github.com/Smaug123/agdaproofs/blob/master/Lists/Reversal/Reversal.agda
[GitHub]: https://github.com/Smaug123/agdaproofs
[EuclideanAlgorithm.agda]: https://github.com/Smaug123/agdaproofs/blob/cab004f6d84dfd13a12ca1e73a68aed23d42a348/Numbers/Naturals/EuclideanAlgorithm.agda
