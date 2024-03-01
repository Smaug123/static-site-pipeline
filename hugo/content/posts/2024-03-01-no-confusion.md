---
lastmod: "2024-03-01T13:51:00.0000000+00:00"
author: patrick
categories:
- programming
date: "2024-03-01T13:51:00.0000000+00:00"
title: Why does no-confusion use equality rather than a recursive call?
summary: "A question about the definition of a no-confusion type."
---

## Question

Conor McBride defined the no-confusion property of `Nat` on page 11 of [A Polynomial Testing Principle](https://personal.cis.strath.ac.uk/conor.mcbride/PolyTest.pdf) as:

```agda
NoConf : Nat → Nat → Set
NoConf ze ze = 1
NoConf ze (su y) = 0
NoConf (su x ) ze = 0
NoConf (su x ) (su y) = x ≡ y
```

Why was this defined that way, rather than the following way which works without dependencies?

```agda
NoConf : Nat → Nat → Set
NoConf ze ze = 1
NoConf ze (su y) = 0
NoConf (su x) ze = 0
NoConf (su x) (su y) = NoConf x y
```

## Context

I still had this question quite near the end of my working through A Polynomial Testing Principle, and it didn't seem to have been answered: I managed to get through most of the paper without serious problems arising from my different definition.

## Answer

Conor immediately follows the definition of `NoConf` by defining a canonical way to construct a `NoConf`:

```agda
noConf : {x y : Nat} -> x ≡ y → NoConf x y
noConf {zero} refl = record {}
noConf {suc n} {.(suc n)} refl = refl
```

If you do it my way instead, you end up unable to use this canonical construction to do proofs by no-confusion.
You probably find yourself proving that `succ` is injective manually, and then using that directly instead of via the `NoConf`; which defeats the entire purpose of packaging up the no-confusion property into a type.

For example:

```agda
+cancel : (a b : Nat) {c d : Nat} -> a ≡ b -> (a + c) ≡ (b + d) -> c ≡ d
+cancel zero .zero refl sums_equal = sums_equal
+cancel (succ a) (succ .a) refl sums_equal = +cancel a a refl {!!}
```

What should go here?
We need something of type `a + c ≡ a + d`, but all we have in scope is the input `succ (a + c) ≡ succ (a + d)`.
That is, we need the no-confusion property for `succ`; which suggests that `NoConf` should somehow contain an equality type, so that we can use it!

## Commentary

I think I only had this question because `Nat` is such a simple type.
If there were more constructors and more cases in each pattern-match, it would have been obvious straight away that I had deleted the entire point of the `NoConf` construction.