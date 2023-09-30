---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- awodey
comments: true
date: "2015-09-29T00:00:00Z"
math: true
aliases:
- /categorytheory/exponentials/
- /exponentials-in-category-theory/
title: Exponentials in category theory
---

Now we come to Chapter 6 of Awodey, on exponentials, pages 119 through 128. Supposedly, this represents a kind of universal property which is not of the form "for every arrow which makes this diagram commute, that arrow factors through this one".

First, we define the currying of a function \\(f: A \times B \to C\\), producting a function \\(f(a) : B \to C\\) - that is, a function \\(f(a) \in C^B\\). That is, we view \\(f: A \to C^B\\), defining an isomorphism of homsets \\(\text{Hom}_{\mathbf{Sets}}(A \times B, C)\\) to \\(\text{Hom}_{\mathbf{Sets}}(A, C^B)\\).

Now, we try to generalise this construction, by generalising the "currying" construct to allow for more kinds of evaluation. We just need a way to take \\(C^B \times B \to C\\) in a universal way. The resulting diagram is perhaps not something I could have come up with, but it is extremely reminiscent of the UMP of the free monoid.

The general definition of an exponential is then "a way of currying", defined in terms of "a way of evaluating". We get some terminology - the "evaluation" is the way of evaluating, and the "transpose" of an arrow is the curried form. We can also define the transpose of a curried arrow, by giving it a way of evaluating on any input; the UMP tells us that if we transpose twice, we recover the original arrow; therefore, the "curry me" operation is an isomorphism between \\(\text{Hom}_{\mathbf{C}}(A \times B, C)\\) and \\(\text{Hom}_{\mathbf{C}}(A, C^B)\\). (This is all probably very harmful, thinking of this in terms of currying, but so far I think it is helping.)

A category is then Cartesian closed if it has all finite products and exponentials. That is, if we can define multi-variable functions which curry. (Yes, arrows are usually not functions. This is for my beginner's intuition.)

Then Example 6.4, showing that the product of two posets is a poset, and defining the exponential to be the Sets-exponential but with the pointwise ordering on arrows. There is work to do to show that the evaluation is an arrow and that the transpose of an arrow is an arrow.

Restricting to \\(\omega\\)CPOs, we still need to show that \\(Q^P\\) is an \\(\omega\\)CPO. Indeed, given an \\(\omega\\)-chain in \\(Q^P\\), we need to find an upper bound in \\(Q^P\\). Say the chain was \\(f_1, f_2, \dots\\). Then for each \\(p\\), the chain with members \\(f_i(p)\\) has a least upper bound \\(f(p)\\). This defines an order-preserving function because if \\(p \leq q\\) then each \\(f_i(p) \leq f_i(q)\\), and weak inequalities respect the limiting operation. Therefore our prospective exponential is in fact in the category.

\\(\epsilon\\) needs to be \\(\omega\\)-continuous: it needs to respect least upper bounds. Let \\((f_i, p_i)\\) be an \\(\omega\\)-chain in \\(Q^P \times P\\). (I'll take it as read that products exist.) We need that evaluating the least upper bound, \\(\epsilon(f, p)\\), yields the limit of \\(\epsilon(f_i, p_i)\\). This follows from the lemma that if the LUB of \\((f_i)\\) is \\(f\\), and of \\((p_i)\\) is \\(p\\), then the least upper bound of \\((f_i, p_i)\\) is \\((f, p)\\) (which is true: it is an upper bound, while any other upper bound is bigger than it). Then \\(\epsilon(f, p) = f(p)\\) while \\(\epsilon(f_i, p_i) = f_i(p_i)\\), so we do get the result: each \\(f_i(p_i) \leq f(p)\\) because \\(f_i(p_i) \leq f(p_i) \leq f(p)\\), while any other upper bound \\(g\\) would have all \\(f_i(p_i) \leq g\\) so (fixing \\(j\\)) all \\(f_j(p_i) \leq g\\), so all \\(f_j(p) \leq g\\), so (releasing \\(j\\)) \\(f(p) \leq g\\).

Finally, the transpose of an \\(\omega\\)-continuous function needs to be \\(\omega\\)-continuous: let \\(f: A \times B \to C\\) be \\(\omega\\)-continuous. Its transpose is \\(\bar{f}: A \to C^B\\) given by \\(\epsilon \circ (\bar{f} \times 1_B) = f\\). If \\(\bar{f}\\) weren't \\(\omega\\)-continuous, there would be a witness sequence \\((a_i)\\) which had \\(\lim \bar{f}(a_i) \not = \bar{f}(\lim a_i)\\); plugging this into the definition of \\(\bar{f}\\) gives that \\((a_i)\\) is a witness against the \\(\omega\\)-continuity of \\(f\\). Contradiction.

And now for something completely different: an exponential with more structure than previously. I just check the definition of the product graph, because I don't think we had it in our Graph Theory course; it seems to be the obvious one, taking pairs of vertices and corresponding pairs of edges. Then the exponential graph. This is defined as to have vertices "set-exponential of the vertices", and an edge between \\(\phi: G \to H\\), \\(\psi: G \to H\\) is a \\(e(G)\\)-indexed collection of edges in \\(H\\) which have "the source is where \\(\phi\\) takes the corresponding \\(G\\)-source" and "the target is where \\(\psi\\) takes the corresponding \\(G\\)-target". It's a way of embedding \\(G\\) into \\(H\\) along \\(\phi\\) and \\(\psi\\).

The evaluation is the obvious one given those structures, and the transpose of a map is the curried version of that map. The different thing about this system is the fact that our maps have to have two parts (one for vertices and one for edges).

"Basic facts about exponentials". The transpose of evaluation, without looking at the rest of the page: \\(\epsilon: B^A \times A \to B\\) must transpose to \\(\bar{\epsilon}: B^A \to B^A\\) with \\(\epsilon \circ (\bar{\epsilon} \times 1_{A}) = \epsilon\\). If \\(\epsilon\\) were monic, we could say that \\(\bar{\epsilon} = 1_{B^A}\\) immediately, but it's not monic. Ah, but we do have that \\(\bar{\epsilon}\\) is uniquely specified by the UMP, so it must be \\(1_{B^A}\\) after all. Maybe that'll help me remember things, if nothing else.

A proof that "exponentiation by a fixed object" is a functor: it starts in Set, which makes me worry that representable functors are going to be involved again (because we seem to be able to cast many things as Set-based things). Onwards: currying is certainly functorial in Set because application of functions is associative, and because we check that the identity curries in the right way.

In general, the definition of the exponential of an arrow \\(\beta: B \to C\\) is the obvious one: there's only one way to make an element of \\(C^A\\) given one in \\(B^A\\) and a map \\(\beta : B \to C\\), and that's to "evaluate at \\(a\\), then do \\(\beta\\)". This method does keep the identity map as an identity: \\(1: B \to B\\) causes \\(f: A \to B\\) to become \\(f: A \to B\\), of course. It respects composition by just writing a couple of lines of symbol-manipulation.

Finally, the transpose of \\(1_{A \times B}\\), which is a map \\(\eta: A \to (A \times B)^B\\). This takes a value \\(a\\) and returns a function \\(b \mapsto (a, b)\\). Then some symbol shunting gives \\(\bar{f} = f^A \circ \eta\\).

![Calculating the exponential][exponential]

# Summary

This section is the one I've thought most concretely about so far. That's probably something I'll have to unlearn. It's useful already being familiar with currying; this chapter would have been a lot harder without already having that intuition.

[exponential]: {{< baseurl >}}images/CategoryTheorySketches/ExponentialEvaluation.jpg
