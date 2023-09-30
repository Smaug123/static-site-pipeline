---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- awodey
comments: true
date: "2015-11-12T00:00:00Z"
math: true
aliases:
- /categorytheory/eilenberg-moore/
- /eilenberg-moore/
title: Eilenberg-Moore
summary: As an exercise in understanding the definitions involved, I find the Eilenberg-Moore category of a certain functor.
---

During my attempts to understand the fearsomely difficult Part III course "[Introduction to Category Theory][course]" by PT Johnstone, I came across the monadicity of the power-set functor \\(\mathbf{Sets} \to \mathbf{Sets}\\). The monad is given by the triple \\((\mathbb{P}, \eta_A: A \to \mathbb{P}(A), \mu_A: \mathbb{PP}(A) \to \mathbb{P}(A))\\), where \\(\eta_A: a \mapsto \{ a \}\\), and \\(\mu_A\\) is the union operator. So \\(\mu_A(\{ \{1, 2 \}, \{3\} \}) = \{1,2,3 \}\\).

It's easy enough to check that this is a monad. We have a theorem saying that every monad has an associated "[Eilenberg-Moore]" category - the category of algebras over that monad. What, then, is the E-M category for this monad?

Recall: an algebra over the monad is a pair \\((A, \alpha)\\) where \\(A\\) is a set and \\(\alpha: \mathbb{P}(A) \to A\\), such that the following two diagrams commute. (That is, \\(\alpha\\) here is an operation which takes a collection of elements of \\(A\\), and returns an element of \\(A\\).)

![Power-set monad algebra diagram][PowersetMonad]

Aha! The second diagram says that the operation \\(\alpha\\) is "massively associative": however we group up terms and successively apply \\(\alpha\\) to them, we'll come up with the same answer. Mathematica calls this attribute "[Flat]"ness, when applied to finite sets only.

Moreover, it doesn't matter what order we feed the elements in to \\(\alpha\\), since it works only on sets and not on ordered sets. So \\(\alpha\\) is effectively commutative. (Mathematica calls this "[Orderless]".)

The first diagram says that \\(\alpha\\) applied to a singleton is just the contained element. Mathematica calls this attribute "[OneIdentity]".

Finally, \\(\alpha(a, a) = \alpha(a)\\), because \\(\alpha\\) is implemented by looking at a set of inputs.

So what is an algebra over this monad? It's a set equipped with an infinitarily-Flat, OneIdentity, commutative operation which ignores repeated arguments. If we forgot that "repeated arguments" requirement, we could use any finite set with any commutative monoid structure; the nonnegative reals with infinity, as a monoid, with addition; and so on. However, this way we're reduced to monoids which have an operation such that \\(a+a = a\\). That's not many monoids.

What operations do work this way? The [Flatten]-followed-by-[Sort] operation in Mathematica obeys this, if the underlying set \\(A\\) is a power-set of a well-ordered set. The union operation also works, if the underlying set is a complete poset - so the power-set example is subsumed in that.

Have we by some miracle got every algebra? If we have an arbitrary algebra \\((A, \alpha)\\), we want to define a complete poset which has \\(\alpha\\) acting as the union. So we need some ordering on \\(A\\); and if \\(x \leq y\\), we need \\(\alpha(\{x, y\}) = y\\). That looks like a fair enough definition to me. It turns out that this definition just works.

So the Eilenberg-Moore category of the covariant power-set functor is just the category of complete posets.

(Subsequently, I looked up the definition of "complete poset", and it turns out I mean "complete lattice". I've already identified the need for unions of all sets to exist, so this is just a terminology issue. A complete poset only has sups of directed sequences. A complete lattice has all sups.)


[course]: /archive/2015IntroToCategoryTheory.pdf
[Eilenberg-Moore]: https://ncatlab.org/nlab/show/Eilenberg-Moore+category
[PowersetMonad]: {{< baseurl >}}images/CategoryTheorySketches/PowersetMonad.jpg
[OneIdentity]: https://reference.wolfram.com/language/ref/OneIdentity.html
[Orderless]: https://reference.wolfram.com/language/ref/Orderless.html
[Flat]: https://reference.wolfram.com/language/ref/Flat.html
[Flatten]: https://reference.wolfram.com/language/ref/Flatten.html
[Sort]: https://reference.wolfram.com/language/ref/Sort.html
