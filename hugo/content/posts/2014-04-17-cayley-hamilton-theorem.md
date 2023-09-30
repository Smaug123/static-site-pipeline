---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
comments: true
date: "2014-04-17T00:00:00Z"
math: true
aliases:
- /mathematical_summary/cayley-hamilton-theorem/
- /cayley-hamilton-theorem/
title: Cayley-Hamilton theorem
---
This is to detail a much easier proof (at least, I find it so) of [Cayley-Hamilton][1] than the ones which appear on the Wikipedia page. It only applies in the case of complex vector spaces; most of the post is taken up with a proof of a lemma about complex matrices that is very useful in many contexts.

The idea is as follows: given an arbitrary square matrix, upper-triangularise it (looking at it in basis \\(B\\)). Then consider how \\(A-\lambda I\\) acts on the vectors of \\(B\\); in particular, how it deals with the subspace spanned by \\(b_1, \dots, b_i\\).

# Lemma: upper-triangulation

> Given a square matrix \\(A\\), there is a basis with respect to which \\(A\\) is upper-triangular.

Proof: by induction. It's obviously true for \\(1 \times 1\\) matrices, as they're already triangular. Now, let's take an arbitrary \\(n \times n\\) matrix \\(A\\). We want to make it upper-triangular. In particular, thinking about the top-left element, we need \\(A\\) to have an eigenvector (since if \\(A\\) is upper-triangular with respect to basis \\(B\\), then \\(A(b_1) = \lambda b_1\\), where \\(\lambda\\) is the top-left element). OK, let's grab an eigenvector \\(v_1\\) with eigenvalue \\(\lambda\\).

We'd love to be done by induction at this point - if we extend our eigenvector to a basis, that extension itself forms a smaller space, on which \\(A\\) is upper-triangulable. We have that every subspace has a complement, so let's call pick a complement of \\(\text{span}(v_1)\\) and call it \\(W\\).

Now, we want \\(A\\) to be upper-triangulable on \\(W\\). It makes sense, then, to restrict it to \\(W\\) - we'll call the restriction \\(\tilde{A}\\), and that's a linear map from \\(W\\) to \\(V\\). Our inductive hypothesis requires a square matrix, so we need to throw out one of the rows of this linear map - but in order that we're working with an endomorphism (rather than just a linear map) we need \\(A\\)'s domain to be \\(W\\). That means we have to throw out the top row as well - that is, we compose with \\(\pi\\) the projection map onto \\(W\\).

Then \\(\pi \cdot \tilde{A}\\) is \\((n-1)\times(n-1)\\), and so we can induct to state that there is a basis of \\(W \leq V\\) with respect to which \\(\pi \cdot \tilde{A}\\) is upper-triangular. Let's take that basis of \\(W\\) as our extension to \\(v_1\\), to make a basis of \\(V\\). (These are \\(n-1\\) length-\\(n\\) vectors.)

Then we construct \\(A\\)'s matrix as \\(A(v_1), A(v_2), \dots, A(v_n)\\). (That's how we construct a matrix for a map in a basis: state where the basis vectors go under the map.)

Now, with respect to this basis \\(v_1, \dots, v_n\\), what does \\(A\\) look like? Certainly \\(A(v_1) = \lambda v_1\\) by definition. \\(\pi(A(v_2)) = \pi(\tilde{A}(v_2))\\) because \\(\tilde{A}\\) acts just the same as \\(A\\) on \\(W\\); by upper-triangularity of \\(\pi \cdot \tilde{A}\\), we have that \\(\pi \cdot \tilde{A}(\pi(v_2)) = k v_2\\) for some \\(k\\). The first element (the \\(v_1\\) coefficient) of \\(A(v_2)\\), who knows? (We threw that information away by taking \\(\pi\\).) But that doesn't matter - we're looking for upper-triangulability rather than diagonalisability, so we're allowed to have spare elements sitting at the top of the matrix.

And so forth: \\(A\\) is upper-triangular with respect to some basis.

## Note

Remember that we threw out some information by projecting onto \\(W\\). If it turned out that we didn't throw out any information - if it turned out that if we could always "fill in with zeros" - then we'd find that we'd constructed a basis of eigenvectors, and that the matrix was diagonalisable. (This is how the two ideas are related.)

# Theorem

Recall the statement of the theorem:

> Every square matrix satisfies its characteristic polynomial.

Now, this would be absolutely trivial if our matrix \\(A\\) were diagonalisable - just look at it in a basis with respect to which \\(A\\) is diagonal (recalling that change-of-basis doesn't change characteristic polynomial), and we end up with \\(n\\) simultaneous equations which are conveniently decoupled from each other (by virtue of the fact that \\(A\\) is diagonal).

We can't assume diagonalisability - but we've shown that there is something nearly as good, namely upper-triangulability. Let's assume (by picking an appropriate basis) that \\(A\\) is upper-triangular. Now, let's say the characteristic polynomial is \\(\chi(x) = (x - \lambda_1)(x-\lambda_2) \dots (x-\lambda_n)\\). What does \\(\chi(A)\\) do to the basis vectors?

Well, let's consider the first basis vector, \\(e_1\\). We have that \\(A(e_1) = \lambda_1 e_i\\) because \\(A\\) is upper-triangular with top-left element \\(\lambda_1\\), so we have \\((A-\lambda_1 I)(e_1) = 0\\). If we look at the characteristic polynomial as \\((x-\lambda_n)\dots (x-\lambda_1)\\), then, we see that \\(\chi(A)(e_1) = 0\\).

What about the second basis vector? \\(A(e_2) = k e_1 + \lambda_2 e_2\\); so \\((A - \lambda_2 I)(e_2) = k e_1\\). We've pulled the \\(2\\)nd basis vector into an earlier-considered subspace, and happily we can kill it by applying \\((A-\lambda_1 I)\\). That is, \\(\chi(A)(e_2) = (A-\lambda_n I)\dots (A-\lambda_1 I)(A-\lambda_2 I)(e_2) = (A-\lambda_n I)\dots (A-\lambda_1 I) (k e_1) = 0\\).

Keep going: the final case is the \\(n\\)th basis vector, \\(e_n\\). \\(A-\lambda_n I\\) has a zero in the bottom-right entry, and is upper-triangular, so it must take \\(e_n\\) to the subspace spanned by \\(e_1, \dots, e_{n-1}\\). Hence \\((A-\lambda_1 I)\dots (A-\lambda_n I)(e_n) = 0\\).

Since \\(\chi(A)\\) is zero on a basis, it must be zero on the whole space, and that is what we wanted to prove.

 [1]: https://en.wikipedia.org/wiki/Cayley-Hamilton_theorem "Cayley-Hamilton theorem"
