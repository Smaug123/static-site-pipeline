---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
comments: true
date: "2014-09-09T00:00:00Z"
math: true
aliases:
- /mathematical_summary/sum-of-two-squares-theorem/
- /sum-of-two-squares-theorem/
title: Sum-of-two-squares theorem
---

*Wherein I detail the most beautiful proof of a theorem I've ever seen, in a bite-size form suitable for an Anki deck. I attach the [Anki deck], which contains the bulleted lines of this post as flashcards.*

# Statement
There's no particularly nice way to motivate this in this context, I'm afraid, so we'll just dive in. I have found this method extremely hard to motivate - a few of the steps are a glorious magic.

* \\(n\\) is a sum of two squares iff in the prime factorisation of \\(n\\), primes 3 mod 4 appear only to even powers.

# Proof
We're going to need a few background results.

## Background
* \\(\mathbb{Z}[i]\\), the ring of [Gaussian integers], is a UFD.
* In a UFD, [irreducible]s are [prime].
* \\(-1\\) is square mod \\(p\\) iff \\(p\\) is not 3 mod 4.

Additionally, we'll call a number which is the sum of two squares a **nice** number.

## First implication: if primes 3 mod 4 appear only to even powers…
We prove the result first for the primes, and will then show that niceness is preserved on taking products.



* Let \\(p=2\\). Then \\(p\\) is trivially the sum of two squares: it is \\(1+1\\).
* Let \\(p\\) be 1 mod 4.
* Then modulo \\(p\\), we have \\(-1\\) is square.
* That is, there is \\(n \in \mathbb{N}\\) such that \\(x^2 + 1 = n p\\).
* That is, there is \\(n \in \mathbb{N}\\) such that \\((x+i)(x-i) = n p\\).
* \\(p\\) divides \\((x+i)(x-i)\\), but it does not divide either of the two multiplicands (since it does not divide their imaginary parts).
* Therefore \\(p\\) is not prime in the complex integers.
* Since \\(\mathbb{Z}[i]\\) is a UFD, \\(p\\) is not irreducible in the complex integers.
* Hence there exist non-invertible \\(a, b \in \mathbb{Z}[i]\\) such that \\(a b = p\\).
* Taking norms, \\(N(p) = N(ab)\\).
* Since the norm is multiplicative, \\(N(p) = N(a) N(b)\\).
* \\(N(p) = p^2\\), so \\(p^2 = N(a) N(b)\\).
* Neither \\(a\\) nor \\(b\\) was invertible, so neither of them has norm 1 (since in \\(Z[i]\\), having norm 1 is equivalent to being invertible).
* Hence wlog \\(N(a)\\) is exactly \\(p\\), since the product of two numbers being \\(p^2\\) means either one of them is 1 or they are both \\(p\\).
* Let \\(a = u+iv\\). Then \\(N(a) = u^2 + v^2 = p\\), which was what we needed.

Next, we need to take care of this "even powers" business:

* \\(p^2\\) is a sum of two squares if \\(p\\) is 3 mod 4: indeed, it is \\(0 + p^2\\).

All we now need is for niceness to be preserved under multiplication. (Recall \\(w^*\\) denotes the conjugate of \\(w\\).)

* Let \\(x, y\\) be the sum of two squares each, \\(x_1^2 + x_2^2\\) and \\(y_1^2 + y_2^2\\).
* Then \\(x = (x_1 + i x_2)(x_1 - i x_2)\\), and similarly for \\(y\\).
* Then \\(x y = (x_1 + i x_2)(x_1 - i x_2)(y_1 + i y_2)(y_1 - i y_2)\\).
* So \\(x y = w w^*\\), where \\(w = (x_1 + i x_2)(y_1 + i y_2)\\).
* Hence \\(x y = N(w)\\), so is a sum of two squares (since norms are precisely sums of two squares).

Together, this is enough to prove the first direction of the theorem.

## Second implication: if \\(n\\) is the sum of two squares…
We'll suppose that \\(n = x^2 + y^2\\) has a prime factor which is 3 mod 4, and show that it divides both \\(x\\) and \\(y\\).

* Let \\(n = x^2 + y^2\\) have prime factor \\(p\\) which is 3 mod 4.
* Then taken mod \\(p\\), we have \\(x^2 + y^2 = 0\\).
* That is, \\(x^2 = - y^2\\).
* If \\(y\\) is not zero mod \\(p\\), it is invertible.
* That is, \\((x y^{-1})^2 = -1\\).
* This contradicts that \\(p\\) is 3 mod 4 (since \\(-1\\) is not square mod \\(p\\)). So \\(y\\) is divisible by \\(p\\).
* Symmetrically, \\(x\\) is divisible by \\(p\\).
* Hence \\(p^2\\) divides \\(n\\), so we can divide through by it and repeat inductively.

That ends the proof. Its beauty lies in the way it regards sums of two squares as norms of complex integers, and dances into and out of \\(\mathbb{C}\\), \\(\mathbb{Z}[i]\\) and \\(\mathbb{Z}\\) where necessary.

[Gaussian integers]: https://en.wikipedia.org/wiki/Gaussian_integers
[UFD]: https://en.wikipedia.org/wiki/Unique_factorization_domain
[irreducible]: https://en.wikipedia.org/wiki/Irreducible_element
[prime]: https://en.wikipedia.org/wiki/Prime_element
[Anki deck]: {{< baseurl >}}AnkiDecks/SumOfTwoSquaresTheorem.apkg
