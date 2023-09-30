---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
comments: true
date: "2014-05-26T00:00:00Z"
math: true
aliases:
- /mathematical_summary/proof-that-symmetric-matrices-are-diagonalisable/
- /proof-that-symmetric-matrices-are-diagonalisable/
title: Proof that symmetric matrices are diagonalisable
---
This comes up quite frequently, but I've been stuck for an easy memory-friendly way to do this. I trawled through the 1A Vectors and Matrices course notes, and found the following mechanical proof. (It's not a discovery-proof - I looked it up.)

## Lemma

Let \\(A\\) be a symmetric matrix. Then any eigenvectors corresponding to different eigenvalues are orthonormal. (This is a very standard fact that is probably hammered very hard into your head if you have ever studied maths post-secondary-school.) The proof of this is of the "write it down, and you can't help proving it" variety:

Suppose \\(\lambda, \mu\\) are different eigenvalues of \\(A\\), corresponding to eigenvectors \\(x, y\\). Then \\(Ax = \lambda x\\), \\(A y = \mu y\\). Hence (transposing the first equation) \\(x^T A^T = \lambda x^T\\); the left hand side is \\(x^T A\\). Hence \\(x^T A y = \lambda x^T y\\); but \\(A y = \mu y\\) so this is \\(x^T \mu y = \lambda x^T y\\). Since \\(\lambda \not = \mu\\), this means \\(x^T y = 0\\).

## Theorem

Now, suppose \\(A\\) has eigenvalues \\(\lambda_1, \dots, \lambda_n\\). They might not be distinct; take the ones which are, \\(\lambda_1, \dots, \lambda_r\\). Then extend this to a basis of \\(\mathbb{R}^n\\), and orthonormalise that basis using the [Gram-Schmidt process][1]. (This can be proved - it's tedious but not hard, as long as you remember what the Gram-Schmidt process is, and I think it's safe to assume.) With respect to this basis, \\(A\\) is a matrix which is diagonal in the first \\(r\\) entries. Moreover, we are performing an orthonormal change of basis, and conjugation by orthogonal matrices preserves the property of "symmetricness" (proof: \\((P^T A P)^T = P^T A^T P = P^T A P\\)), so the \\(r+1\\)th to \\(n\\)th row/column block is symmetric. It is also real (because we have performed a conjugation by a real matrix). And we have that the first \\(r\\) columns of \\(P^T A P\\) are filled with zeros below the diagonal (being the image of eigenvectors), so \\(P^T A P\\) is also filled with zeros in the first \\(r\\) rows above the diagonal, because it is a symmetric matrix.

Now by induction, that sub-matrix \\(A_{r,r} \dots A_{n,n}\\) is diagonalisable by an orthogonal matrix. Hence we are done: all symmetric matrices are diagonalisable by an orthogonal change of basis. (The eigenvectors produced by the inductive step must be orthogonal to the ones we've already found, because they fall in a subspace which is orthogonal to that of the one we already found.)

 [1]: https://en.wikipedia.org/wiki/Gram-Schmidt_process "Gram-Schmidt process Wikipedia page"
