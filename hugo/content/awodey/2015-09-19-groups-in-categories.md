---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- awodey
comments: true
date: "2015-09-19T00:00:00Z"
math: true
aliases:
- /categorytheory/groups-in-categories/
- /groups-in-categories/
title: Groups in categories
---

I go into this chapter hoping that it will be on things I already know about group theory. This post will be on pages 75 through 85 of Awodey.

I already know about groups over sets, but this looks like they can be made more generally over other categories. It is clear that we will need to consider only categories with finite products, because the notion of a binary operation requires us to work on pairs of elements.

The definition of a group is the obvious one: an object \\(G\\) with an "inverses" arrow \\(i: G \to G\\), a "multiplication" arrow \\(m: G \times G \to G\\) and a "unit" arrow \\(u: 1 \to G\\), such that \\(m\\) is associative in the obvious way, \\(u\\) is a unit for \\(m\\), and \\(i\\) is an inverse with respect to \\(m\\) - drawing out the appropriate diagrams.

The definition of a homomorphism is likewise very familiar, and the examples which follow are very clear. (The operations are arrows, so they must preserve structure.)

Example 4.4 is a group in the category of groups. I remember having proved Proposition 4.5 on an example sheet somewhere, but it wasn't indicated there that it was anything particularly important. I've only glanced over the construction of a group in the category of groups, so I'll try and work out what it is myself. A group in the category of groups is a group \\(G\\) together with its self-product \\(G \times G\\), and associative homomorphism \\(m: G \times G \to G\\), and \\(u: \{ 1 \} \to G\\), and \\(i: G \to G\\) which acts as an inverse for \\(m\\). This is still a bit nonspecific, so can we say anything about \\(m\\)? It must preserve the group structure on \\(((G, \cdot), m, i)\\), and we know \\(\cdot\\) preserves the group structure on \\((G, \cdot)\\). Is there perhaps a way to get them to play nicely together?

I'll write \\(\times\\) as a shorthand for \\(m\\). Then \\(m(a \cdot b, c \cdot d) = m(a, c) \cdot m(b, d)\\) because \\(m\\) is a homomorphism \\(G \times G \to G\\). Letting \\(a = 1_G, d = 1_G\\) yields \\(m(b, c) = c \cdot b\\). Letting \\(b=1_G, c=1_G\\) yields \\(m(a, d) = a \cdot d\\). Therefore in fact \\(m\\) is the group operation on \\(G\\), and \\(G\\) is also abelian. (I won't bother with the converse, since on looking, the book says it's easy.)

A strict monoidal category is a monoid in Cat. Dear heavens, this is confusingly general. I'll have to go through the examples Awodey gives.

The operation of taking products and coproducts (that is, the meet/join operations) does indeed satisfy the criterion - ah, I move down and see that Awodey points out that these only hold up to isomorphism, not equality, so this isn't "strict". In posets, though, there's at most one arrow between any two objects, so we really do have equality.

A discrete monoidal category is a standard Set-monoid: I can see that each Set-monoid is a discrete monoidal category. How about the converse? Yep, that's fine as long as we're talking about locally small categories. (I briefly got confused between the morphisms and the \\(\otimes\\) operation, but that's cleared up now.)

A strict non-poset monoidal category is the finite ordinals: since no arrow between two different ordinals has an inverse, we must have that objects are unique not just up to isomorphism, but in a more specific sense. This again lets us say that this is a strict monoidal category.

I'll leave that and hope for the best. Next is the category of groups, and we see the familiar equivalence between kernels of homomorphisms and normal subgroups. There's also this idea of "the equaliser is the subgroup; the coequaliser is the quotient" from earlier. I prove the coequaliser statement myself without looking at the proof - it's not hard, and it just involves showing that for \\(H\\) normal in \\(G\\), if \\(k: G \to K\\) is such that \\(k i = k u\\), then \\(k\\) is constant on \\(H\\) and so descends to the quotient \\(G/H\\). The category-theoretic statement about coequalisers is much more fearsome than the concrete group-theoretic one!

I'm very familiar with these results, so having done one of them (the coproducts one), I skip through to the first one I don't know, which is Corollary 4.11. Actually this is the First Isomorphism Theorem in disguise. I whizz down to the exercises and see that the cokernel construction is an exercise, so I'll leave it til then (I'd like to avoid fragmenting them, and also I can't be bothered at the moment).

Section 4.3: groups as categories. Groups certainly are categories - that's how I defined them in my Anki card for the category theory deck. A functor is therefore clearly a group hom, as Awodey says.

Ah, that's cool. Functors from a group (viewed as a category) to any category form "representations" of that group. Elements of \\(G\\) become automorphisms of an object in \\(C\\). In the case of the functor into the category of finite-dimensional vector spaces with linear maps, we can have \\(G\\) appearing as the automorphism group of a wide variety of different objects: for instance, \\(C_5\\) acts on \\(\mathbb{C}^1\\), or on \\(\mathbb{C}^2\\) or on…

In the case of the functor into the category of sets, it's most natural to identify \\(G\\) with a subgroup of some permutation group and to make \\(G\\) act on the appropriate set; in fact this looks like the only way of describing such a functor, since every group is unique up to isomorphism, so corresponds to only one "distinct" permutation-subgroup.

Now we see the definition of a congruence on a category. It's easy to see that this is the equivalence relation we get by identifying all arrows which go to and from the same place, or an equiv rel with more classes than that.

The congruence category uses some rather strange notation. What even is \\(C_0\\)? Surely it must be the set of objects, and \\(C_1\\) the set of arrows, but that isn't notation I remember from earlier in the book. Once that's settled, the definitions become easy: the congruence category is "the thing on which we need to take the quotient" in order to get the quotient by the congruence. It is the category where the morphisms are instead "congruent pairs of arrows" in the original category, and the composition is well-defined because \\(f' f\\) and \\(g' g\\) are congruent if \\(f', f\\) and \\(g', g\\) are.

There are indeed two projection functors, because we're working on a category which has "pairs of arrows" as its morphisms; then the coequaliser of those two is the desired quotient. That seems fine.

We then construct the "kernel of a functor \\(F\\)" in an analogous way to groups: two arrows are \\(F\\)-congruent iff \\(F\\) treats them in the same way, and we define the quotient category to be universal such that for any congruence \\(\sim\\), \\(F\\) descends to the quotient by \\(\sim\\) iff \\(\sim\\) is a sub-congruence of \\(\sim_F\\). (I had to sleep on this one, but I think I understand it now.)

Finally, picking \\(\sim\\) to equal \\(\sim_F\\) gives that all functors descend to their quotients, where the descent is bijective on objects, surjective on hom-sets, and the descended map is injective on hom-sets.

# Summary

This section was an interesting one, but it took me a while to get the hang of it. I'm used to all of this in a concrete setting; seeing it in the abstract makes everything quite difficult. I'm going back to the section on hom-sets now, because the last paragraph is not intuitive at all to me, and I feel it ought to be.
