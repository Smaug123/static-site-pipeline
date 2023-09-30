---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- stack-exchange
comments: true
date: "2017-11-05T00:00:00Z"
title: Abuse of notation in function application
summary: Answering the question, "Are these examples of abuses of notation?".
---

*This is my answer to the same [question posed on the Mathematics Stack Exchange](https://math.stackexchange.com/q/2505777/259262). It is therefore licenced under [CC-BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/).*

# Question

I have often seen notation like this:

> Let \\(f : \mathbb{R}^2 \to \mathbb{R}\\) be defined by \\(f(x, y) = x^2 + 83xy + y^7\\).

How does this make any sense?
If the domain is \\(\mathbb{R}^2\\) then \\(f\\) should be mapping individual tuples.

Also when speaking of algebraic structures why do people constantly interchange the carrier set with the algebraic structure itself?
For example you might see someone write this:

> Given any field \\(\mathbb{F}\\) take those elements in our field \\(a \in \mathbb{F}\\) that satisfy the equation \\(a^8 = a\\).

How does this make any sense?
If \\(\mathbb{F}\\) is a field then it is a tuple equipped with two binary operations and corresponding identity elements all of which satisfy a variety of axioms.

# Answer

The example you've given of a function is not an abuse. \\(x\\) is instead shorthand for \\(\pi_1(t)\\) and \\(y\\) is shorthand for \\(\pi_2(t)\\) and \\((x, y)\\) is shorthand for \\(t\\).

\\(g \in G\\) is a very minor abuse, yes.
"A group \\(G\\) is a set \\(G\\) endowed with some operations" is a slight abuse, but one which will never be misinterpreted.
It is done this way to avoid the proliferation of unnecessary and confusing symbols.
For the same reason, we use the symbol \\(+\\) to refer to the three different operations of addition of integers, rationals, and reals.
