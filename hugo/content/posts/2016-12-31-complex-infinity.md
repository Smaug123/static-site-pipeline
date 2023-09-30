---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- stack-exchange
comments: true
date: "2016-12-31T00:00:00Z"
title: What does Mathematica mean by ComplexInfinity?
summary: Answering the question, "Why does WolframAlpha say that a quantity is ComplexInfinity?".
---

*This is my answer to the same [question posed on the Mathematics Stack Exchange](https://math.stackexchange.com/q/2078754/259262). It is therefore licenced under [CC-BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/).*

# Question

When entered into [Wolfram|Alpha](https://www.wolframalpha.com/), \\(\infty^{\infty}\\) results in "complex infinity".
Why?

# Answer

WA's `ComplexInfinity` is the same as Mathematica's: it represents a complex "number" which has infinite magnitude but unknown or nonexistent phase.
One can use `DirectedInfinity` to specify the phase of an infinite quantity, if it approaches infinity in a certain direction.
The standard `Infinity` is the special case of phase `0`.
Note that `Infinity` is different from `Indeterminate` (which would be the output of e.g. `0/0`).

Some elucidating examples:

* `0/0` returns `Indeterminate`, since (for instance) the limit may be approached as \\(\frac{1/n}{1/n}\\) or \\(\frac{2/n}{2/n}\\), resulting in two different real numbers.
* `1/0` returns `ComplexInfinity`, since (for instance) the limit may be approached as \\(\frac{1}{-1/n}\\) or as \\(\frac{1}{1/n}\\), but every possible way of approaching the limit gives an infinite answer.
* `Abs[1/0]` returns `Infinity`, since the limit is guaranteed to be infinite and approached along the real line in the positive direction.

In your particular example, you get `ComplexInfinity` because the infinite limit may be approached as (e.g.) \\(n^n\\) or as \\(n^{n+i}\\).
