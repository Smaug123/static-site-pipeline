---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
- proof_discovery
comments: true
date: "2014-05-03T00:00:00Z"
math: true
aliases:
- /mathematical_summary/proof_discovery/discovering-a-proof-of-sylvesters-law-of-inertia/
- /discovering-a-proof-of-sylvesters-law-of-inertia/
title: Discovering a proof of Sylvester's Law of Inertia
---
*This is part of what has become a series on discovering some fairly basic mathematical results, and/or discovering their proofs. It's mostly intended so that I start finding the results intuitive - having once found a proof myself, I hope to be able to reproduce it without too much effort in the exam.*

# Statement of the theorem

[Sylvester's Law of Inertia][1] states that given a quadratic form \\(A\\) on a real finite-dimensional vector space \\(V\\), there is a diagonal matrix \\(D\\), with entries \\(( 1_1,1_2,\dots,1_p, -1_1, -1_2, \dots, -1_q, 0,0,\dots,0 )\\), to which \\(A\\) is congruent; moreover, \\(p\\) and \\(q\\) are the same however we transform \\(A\\) into this diagonal form.

# Proof

The very first thing we need to know is that \\(A\\) is diagonalisable. (If it isn't diagonalisable, we don't have a hope of getting into this nice form.) We know of a few classes of diagonalisable matrices - symmetric, Hermitian, etc. All we know about \\(A\\) is that it is a real quadratic form. What does that mean? It means that \\(A(x) = x^T A x\\) if we move into some coordinate system; transposing gives us that \\(A(x)^T = x^T A^T x\\), but the left-hand-side is scalar so is symmetric, whence \\(A = A^T\\) (because \\(x\\) was arbitrary). Hence \\(A\\) has a symmetric matrix and so is diagonalisable: there is an orthogonal matrix \\(P\\) such that \\(P^{-1}AP = D\\), where \\(D\\) is diagonal. (Recall that a matrix \\(M\\) is orthogonal if it satisfies \\(M^{-1} = M^T\\).)

Now we might as well consider \\(D\\) in diagonal form. Some of the elements are positive, some negative, and some zero - it's easy to transform \\(D\\) so that the positive ones are all together, the negative ones are all together and the zeros are all together, by swapping basis vectors. (For instance, if we want to swap diagonal elements in positions \\((i,i), (j,j)\\), just swap \\(e_i, e_j\\).) Now we can scale every diagonal element down to \\(1\\), by scaling the basis vectors - if we scale \\(e_i\\) by \\(\sqrt{ \vert A_{i,i} \vert }\\), calling the resulting basis \\(f_i\\) we'll get \\(A(f_i) =  \vert A_{i,i} \vert  A(e_i) = A_{i,i} e_i\\) as required. (The squaring comes from the fact that \\(A\\) is a \*quadratic\* form, so \\(A(a x) = a^2 A(x)\\).)

Hence we've got \\(A\\) into the right form. But how do we show that the number of positive and negative elements is an invariant?

## Positive bit

All I remember from the notes is that there's something to do with positive definite subspaces. It turns out that's a really big hint, and I haven't been able to think up how you might discover it. Sadly, I'll just continue as if I'd thought it up for myself rather than remembering it.

The following section was my first attempt. My supervisor then told me that it's a bit inaccurate (and some of it doesn't make sense). In particular, I talk about the dimension of \\(V \backslash P\\) for \\(P\\) a subspace of \\(V\\) - but \\(V \backslash P\\) isn't even a space (it doesn't contain \\(0\\)). During the supervision I attempted to refine it by using \\(P^C\\) the complement of \\(P\\) in \\(V\\), but even that is vague, not least because complements aren't unique.

### Original attempt

We have a subspace \\(P\\) on which \\(A\\) is positive definite - namely, make \\(A\\) diagonal and then take the first \\(p\\) basis vectors. (Remember, positive definite iff \\(A(x, x) > 0\\) unless \\(x = 0\\); but \\(A(x,x) > 0\\) for \\(x \in P\\) because \\(x^T A x\\) is a sum of positive things.) Similarly, we have a subspace \\(Q\\) on which \\(A\\) is negative semi-definite (namely "everything which isn't in \\(P\\)"). Then what we want is: for any other diagonal form of \\(A\\), there is the same number of 1s on the diagonal, and the same number of -1s, and the same number of 0s. That is, we want to ensure that just by changing basis, we can't alter the size of the subspace on which \\(A\\) is positive-definite.

We'll show that for any subspace \\(R\\) on which \\(A\\) is positive-definite, we must have \\(\dim(R) \leq \dim(P)\\). Indeed, let's take \\(R\\) on which \\(A\\) is positive definite. The easiest way to ensure that its dimension is less than that of \\(P\\) is to show that it's contained in \\(P\\). Now, that might be hard - we don't know anything about what's in \\(R\\) - but we might do better in showing that nothing in \\(R\\) is also in \\(V \backslash P\\), because we know \\(A\\) is negative semi-definite on \\(V \backslash P\\), and that's inherently in tension with the positive-definiteness on \\(R\\).

Suppose \\(r \not \in P\\) and \\(r \in R\\). Then \\(A(r,r) \leq 0\\) (by the first condition) and \\(A(r,r) > 0\\) (by the second condition, since \\(R\\) is positive-definite) - contradiction.

That was quick - we showed, for all subspaces \\(R\\) on which \\(A\\) is positive-definite, that \\(\dim(R) \leq \dim(P)\\).

### Supervisor-vetted version

We have a subspace \\(P\\) on which \\(A\\) is positive-definite - namely, make \\(A\\) diagonal and take the first \\(p\\) basis vectors. We'll call the set of basis vectors \\(\{e_1, \dots, e_n \}\\); then \\(P\\) is spanned by \\(\{e_1, \dots, e_p \}\\).

Now, let's take any subspace \\(\tilde{P}\\) on which \\(A\\) is positive-definite. We want \\(\dim(\tilde{P}) \leq \dim(P)\\); to that end, take \\(N\\) spanned by \\(\{e_{p+1}, \dots, e_n \}\\). We show that \\(\tilde{P} \cap N = \{0\}\\). Indeed, if \\(r \in\tilde{P} \cap N\\), with \\(r \not = 0\\), then:

*   \\(r \in \tilde{P}\\) so \\(A(r,r) > \\)0
*   \\(r \in N\\) so \\(A(r,r) \leq \\)0

But this is a contradiction. Hence \\(\tilde{P} \cap N\\) is the zero space, and so \\(\dim(\tilde{P}) \leq \dim(P)\\) because \\(\dim(P) + \dim(N) = n\\) while \\(\dim(\tilde{P}) + \dim(N) \leq n\\).

### Commentary

Notice that my original version is conceptually quite close to correct: "take something in a positive-definite space, show that it can't be in the negative-semi-definite bit and hence must be in \\(P\\)". I was careless in not checking that what I had written made sense. I am slightly surprised that no alarm bells were triggered by my using \\(V \backslash P\\) as a space - I hope that now my background mental checks will come to include this idea of "make sure that when you transform objects, you retain their properties".

### Completion (original and hopefully correct)

Identically we can show that for all subspaces \\(Q\\) on which \\(A\\) is negative-definite, that \\(\dim(Q) \leq \dim(N)\\) (with \\(N\\) defined analogously to \\(P\\) but with negative-definiteness instead of positive-definiteness). And we already know that congruence preserves matrix rank (because matrix rank is a property of the eigenvalues, and basis change in this way only alters eigenvalues by multiples of squares), so we have that the number of zeros in any diagonal representation of \\(A\\) is the same.

Hence in any diagonal representation of \\(A\\) with \\(p', q', z'\\) the number of \\(1, -1, 0\\) respectively on the diagonal, we need \\(p' \leq p, q' \leq q, z' = z\\) - but because the diagonal is the same size on each matrix (since the matrices don't change dimension), we must have equality throughout.

 [1]: https://en.wikipedia.org/wiki/Sylvester's_Law_of_Inertia "Sylvester's law of inertia Wikipedia page"
