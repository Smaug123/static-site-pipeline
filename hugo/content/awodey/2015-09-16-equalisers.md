---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- awodey
comments: true
date: "2015-09-16T00:00:00Z"
math: true
aliases:
- /categorytheory/equalisers/
- /equalisers/
title: Equalisers
---

This is pages 62 through 71 of Awodey, on [equalisers] and coequalisers.

The first paragraph is really quite exciting. I can see that there would be a common generalisation of kernels and varieties - they're the same idea that lets us find complementary functions and particular integrals of linear differential equations, for instance. But the axiom of separation ("subset selection") as well? Now that's intriguing.

We are given the definition of an equaliser: given a pair of arrows with the same domain and codomain, it's an arrow \\(e\\) which may feed into that domain to make the two arrows be "the same according to \\(e\\)".

Let's see the examples of \\(f, g: \mathbb{R}^2 \to \mathbb{R}\\) with \\(f(x, y) = x^2+y^2, g(x,y) = 1\\). I'll try and find the equaliser (in Top) myself. It'll be a topological space \\(E\\) and a continuous function \\(e: E \to \mathbb{R}^2\\) such that \\(f \circ e = g \circ e\\). That is, such that \\(f \circ e = 1\\). That makes it easy: were it not for the "universal" property, \\(E\\) could be anything which has a continuous function mapping it into the unit circle in \\(\mathbb{R}^2\\), and \\(e\\) would be that mapping. (I'm beginning to see where the axiom of subset selection might come in.) But if we took the space \\(E = \{ (1, 0) \}\\) and the inclusion mapping as \\(e\\), this would fail the uniqueness property because there's more than one way we can continuously map a single point into that unit circle. In order to make sure everything is specified uniquely, we'll want \\(E\\) to be the entire unit circle and its inherited topology. Ah, Awodey points out that in this case, the work is easy because the inclusion is monic and so uniqueness is automatic.

Let's do the same thing for Set. The equaliser of \\(f, g: A \to B\\) is a function \\(e: E \to A\\) such that \\(f \circ e = g \circ e\\). We need to make sure \\(f, g\\) only ever see the elements where they're equal after the \\(e\\)-filter has been applied to them, so \\(e\\) must only map into the set \\(\{a \in A : f(a) = g(a) \}\\). It should be easy to show that the equaliser is actually that set with the obvious inclusion into \\(A\\), and I look at the book to see that it is indeed so.

"Every subset is an equaliser" is therefore true, and the characteristic function is indeed the obvious way to go about it. Huh - the axiom of subset selection has just fallen out, stating that there is an inverse to the characteristic function. Magic. Then \\(\text{Hom}(A, 2) \cong \mathbb{P}(A)\\), which we already knew because to specify an element of the power-set is precisely to specify which elements of \\(A\\) are included.

Equalisers are monic: well, the diagram certainly looks like being the right shape, and it's intuitive for Sets: if \\(E \to A\\) weren't injective, then we could choose more than one way of mapping \\(Z \to E \to A \to B\\). The proof in general mimics the Sets example.

Then a blurb on how equalisers can often be made as "restrict the sets and inherit the structure". That's a nice rule of thumb. Awodey points out the "kernel of homomorphism" interpretation, which I'd already pattern-matched in the first paragraph. The equaliser is basically specifying an equivalence class under an equiv rel.

Hah, I wrote that before seeing that a coequaliser is a generalisation of "take the quotient by an equiv rel". Makes sense: if the equaliser is an equivalence class, it seems reasonable for its dual to be a quotient. I skip past the definition of an equivalence relation, because I already know it. What does the definition of a coequaliser really mean? It's an arrow \\(q: B \to Q\\) such that once we've let \\(f, g\\) do their thing, we can apply \\(q\\) to make it look like they've done the *same* thing. It's the other way round from the equaliser, which restricted \\(f, g\\) so that they could only do the same thing. I can see why this is like taking a quotient, and the next example makes that very clear.

Coproduct of two rooted posets: we quotient by the appropriate equivalence relation. That is, we co-equalise using \\(\{ 0 \}\\) and its obvious inclusions into the two posets. I draw out the diagram and after some wrestling I convince myself that the rooted-posets coproduct is as stated. I'm still getting used to this diagram-chasing. I'll wait til the exercises to do the Top example.

Presentations of algebras. I've never seen a demonstration that all groups can be obtained as presentations of free groups, I think, although it's fairly clear that it can be done (just specify every single relation that can possibly hold - in effect writing out the Cayley table). I would prefer it if Awodey defined \\(F(1)\\) explicitly, since it takes me a moment to realise it's the free algebra on one generator. Then \\(F(3) = F(x(1), y(1), z(1))\\). We then perform the next coequaliser. Awodey is again confusing me a bit, and I have to stop and work out that by \\(q(y^2)\\), he means \\(q \circ (1 \mapsto y^2)\\), and by \\(q(1)\\) he means \\(q \circ (1 \mapsto 1)\\). It's obvious what the intent is - chaining together these coequalisers in the obvious way. Each coequaliser doesn't significantly change the structure of the free group, so each coequaliser can be applied in turn, using the inherited structure where necessary. However, this is a bit of a confusing write-up.

"The steps can be done simultaneously": oh dear. It looks like we should be able to do this construction sequentially all the time, and that is conceptually easier, but I'll try and understand the all-at-once construction anyway. Firstly, we define \\(F(2)\\) because we want to equalise two 2-tuples. (It would be \\(F(3)\\) if we had three constraints and so wanted to equalise two 3-tuples.) My instinct would have been to do this with the algebra product instead of the algebra coproduct - using \\(F(2) = F(1) \times F(1)\\). I asked a friend about this. The intuition is apparently that the product is good for imposing multiple conditions at the same time, while what we really want is a way to impose one of a number of conditions. The coproduct (by way of the direct sum) has the notion of "one of a number of things, but not necessarily all of them together".

I draw out the diagram again the next day. This time it makes a bit more sense that we need the coproduct: it's because we need a way of getting from \\(F(1)\\) to \\(F(3)\\), and if we used the product we'd have all our arrows ending at \\(F(1)\\) rather than originating at \\(F(1)\\). I can see why the UMP guarantees the uniqueness of the algebra given by these generators and relations now.

On to the specialisation to monoids. The construction is… odd, so I'll try and forget about it for a couple of minutes and then do it myself. We want to construct the free group on all the generators we have available - that is, all the monoid elements - so we're going to need a functor \\(T\\) (to use Awodey's notation) taking \\(N \to M(\vert N \vert)\\). Then we're also going to need a way to specify all the different relations in the monoid. We can do that by specifying a mapping taking a word \\(x_1, x_2, \dots, x_n\\) to the monoid product \\(x_1 x_2 \dots x_n\\). Write \\(C\\) for that multiplication ("C" for "collapsing") functor \\(T(N) \to N\\). Aha: our restrictions become of the form \\(C(x_1, x_2) = x_3\\), representing the equation \\(x_1 x_2 = x_3\\).

Very well: we're going to need our left-hand sides to be going from \\(T^2 N \to T N\\), and our right-hand sides likewise. Then we'll coequalise them. Let \\(f: T^2 N \to T N\\) taking a word of words to its corresponding word of products, and let \\(g: T^2 N \to T N\\) taking a word of words to the product of products. Wait, that's got the wrong codomain. Let \\(g: T^2 N \to T N\\) taking a word of words to the corresponding word of letters. That's better: we have basically provided a list of equivalences between \\((x_1, x_2)\\) and \\(x_1 x_2\\).

Finally, we take the coequaliser \\(e\\) of \\(f\\) and \\(g\\), and hope and pray that \\(N\\) (our original monoid) has the UMP for the resulting object. I remember from the proof in the book that we should first show that the coequaliser arrow is the operation "take the product of the word". (In hindsight, that's a great place to start. It's harder to deal with a function without knowing what it is.) Certainly the "take the product of the word" function does what we want, but does it actually satisfy the UMP? Drawing out a diagram convinces me that it does: any \\(\phi\\) which doesn't care how the letters are grouped between words, descends uniquely to a map from the monoid of all words.

The coequaliser arrow therefore definitely does go into \\(N\\), and we can identify \\(N\\) with the coequaliser in the obvious way by including from the coequaliser (which still technically has the structure of a free group).

# Summary

This is yet another thing I've started to get a feel for, but not really understood. I now know what coequalisers and equalisers are for, and the utility of the "duals" idea. The exercises will certainly be helpful.

[equalisers]: https://en.wikipedia.org/wiki/Equaliser_(mathematics)#In_category_theory
