---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
comments: true
date: "2015-08-21T00:00:00Z"
math: true
aliases:
- /mathematical_summary/proof-by-contradiction/
- /proof-by-contradiction/
title: Proof by contradiction
summary: Here I explain proof by contradiction so that anyone who has ever done a sudoku and seen algebra may understand it.
---

Here I explain proof by contradiction so that anyone who has ever done a [sudoku] and seen algebra may understand it.

Imagine you are doing a sudoku, and you have narrowed a particular cell down to being either a 1 or a 3. You're not sure which it is, so you do the "guess and see" approach: you guess it's a 1. That forces this other cell to be an 8, this one to be a 5, and then - oh no! That one over there has to be a 7, but there's already a 7 in its row! That means we have to backtrack: our first guess of 1 was wrong, so it has to be a 3 after all.

That was a proof by contradiction that the cell was a 3.

Now I present the standard proof that \\(\sqrt{2}\\) is not [expressible as a fraction][rational] \\(\frac{p}{q}\\) where \\(p, q\\) are whole numbers.

Analogy: "the cell was a 1" corresponds to "\\(\sqrt{2}\\) is fraction-expressible". "The cell was a 3" corresponds to "\\(\sqrt{2}\\) is not fraction-expressible".

Suppose \\(\sqrt{2}\\) were fraction-expressible. Then we could write it explicitly as \\(\sqrt{2} = \frac{p}{q}\\), and we can insist that \\(q > 0\\): if it's negative, we can move the negative up to the \\(p\\). If we clear denominators, we get \\(q \sqrt{2} = p\\); then square both sides, to get \\(2 q^2 = p^2\\).

But now think about how many times 2 divides the left-hand side and the right-hand side. 2 divides a square an even number of times, if it divides it at all (because any square which is divisible by 2 is also divisible by 4, so we can pair off the 2-factors). So 2 must divide \\(q^2\\) an even number of times, and hence the left-hand side an odd number of times (because that's \\(2 \times q^2\\)). It divides the right-hand side an even number of times. So the number of times 2 divides \\(p^2\\) is both odd and even. No number is both odd and even!

We've done the equivalent of finding a 7 appearing twice in a single row. We have to backtrack and conclude that the starting cell was a 3 after all: \\(\sqrt{2}\\) is not fraction-expressible.

[sudoku]: https://en.wikipedia.org/wiki/Sudoku
[rational]: https://en.wikipedia.org/wiki/Rational_number
