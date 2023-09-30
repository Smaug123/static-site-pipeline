---
lastmod: "2021-10-25T23:24:01.0000000+01:00"
author: patrick
categories:
- stack-exchange
comments: true
math: true
date: "2016-03-03T00:00:00Z"
title: Why do we get complex numbers in a certain expression?
summary: Answering the question, "Why does a continued fraction containing only 1, subtraction, and division result in one of two complex numbers?".
---

*This is my answer to the same [question posed on the Mathematics Stack Exchange](https://math.stackexchange.com/q/1681993/259262). It is therefore licenced under [CC-BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/).*

# Question

So we all know that the continued fraction containing all 1s...

$$
x = 1 + \frac{1}{1 + \frac{1}{1 + \ldots}}
$$

yields the golden ratio \\(x = \phi\\), which can easily be proven by rewriting it as \\(x = 1 + \dfrac{1}{x}\\), solving the resulting quadratic equation and assuming that a continued fraction that only contains additions will give a positive number.

Now, a friend asked me what would happen if we replaced all additions with subtractions:

$$
x = 1 - \frac{1}{1 - \frac{1}{1 - \ldots}}
$$

I thought "oh cool, I know how to solve this...":

$$
x = 1 - \frac{1}{x}
$$

$$
x^2 - x + 1 = 0
$$

And voila, I get...

$$ x \in \{e^{i\pi/3}, e^{-i\pi/3} \} $$

Ummm... why does a continued fraction containing only 1s, subtraction and division result in one of two complex (as opposed to real) numbers?

(I have a feeling this is something like the \\(\sum_i (-1)^i\\) thing, that the infinite continued fraction isn't well-defined unless we can express it as the limit of a converging series, because the truncated fractions \\(1 - \frac{1}{1-1}\\) etc. aren't well-defined, but I thought I'd ask for a well-founded answer. Even if this is the case, do the two complex numbers have any "meaning"?)

# Answer

You're attempting to take a limit.

$$
x_{n+1} = 1-\frac{1}{x_n}
$$

This recurrence actually never converges, from any real starting point.
Indeed, \\(x_2 = 1-\frac{1}{x_1}; \\ x_3 = 1-\frac{1}{1-1/x_1} = 1-\frac{x_1}{x_1-1} = \frac{1}{1-x_1}; \\ x_4 = x_1\\)

So the sequence is periodic with period 3.
Therefore it converges if and only if it is constant; but the only way it could be constant is, as you say, if \\(x_1\\) is one of the two complex numbers you found.

Therefore, what you have is actually basically a proof by contradiction that the sequence doesn't converge when you consider it over the reals.

However, you have found exactly the two values for which the iteration does converge; that is their significance.

Alternatively viewed, the map \\(z \mapsto 1-\frac{1}{z}\\) is a certain transformation of the complex plane, which has precisely two fixed points. You might find it an interesting exercise to work out what that map does to the complex plane, and examine in particular what it does to points on the real line.
