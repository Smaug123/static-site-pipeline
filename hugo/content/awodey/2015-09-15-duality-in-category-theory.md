---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- awodey
comments: true
date: "2015-09-15T00:00:00Z"
math: true
aliases:
- /categorytheory/duality/
- /duality-in-category-theory/
title: Duality in category theory
---

I don't have strong preconceptions about this chapter. The previous chapter I knew would contain general constructions, and I was looking forwards to that, but this one is more unfamiliar to me. I'll be doing pages 53 through 61 of Awodey here - coproducts.

The first bits are stuff I recognise from when I flicked through Categories for the Working Mathematician, I think. Or something. Anyway, I recognise the notion of formal duality and the very-closely-related semantic duality. (Like the difference between "semantic truth" and "syntactic truth" in first-order logic.) It's probably a horrible sin to say it, but both of these are just obvious, once they've been pointed out.

Now the definition of a coproduct. The notation \\(A+B\\) is extremely suggestive, and I'd have preferred to try and work out what the coproduct was without that hint. \\(z_1: A \to Z\\) and \\(z_2: B \to Z\\) are "ways of selecting \\(A\\)- and \\(B\\)-shaped subsets of any object" (yes, that's not fully general, but for intuition I'll pretend I'm in a concrete category). So for any \\(Z\\), and for any way of selecting an \\(A\\)-shaped and a \\(B\\)-shaped subset of \\(Z\\), we can find a unique way of selecting an \\(A+B\\)-shaped subset according to the commuting-diagram condition. I'm still a bit unclear as to what that all means, so I whizz down to the Sets example below.

In Sets, if we can find an \\(A\\)-shaped subset of some set \\(Z\\), and a \\(B\\)-shaped subset, then we can find a subset which is shaped like the disjoint union of \\(A\\) and \\(B\\) in a unique way. (Note that our arrows need not be injective, which is why the \\(A+B\\)-shaped subset exists. For instance, if \\(A = \{1\}, B = \{1\}\\), and our \\(A\\)-shaped subset and \\(B\\)-shaped subset of \\(\{a,b \}\\) were both \\(\{a\}\\), then the \\(A+B\\)-shaped subset would be simply \\(\{a \}\\). Both selections of shape end up pointing at the same element.)

This leads me to wonder: what about in the category of sets with injections as arrows? Now it seems that the coproduct is only defined on disjoint sets, because the arrows \\(z_1, z_2\\) which pick out \\(A\\)- and \\(B\\)-shaped subsets now need to have distinct images in \\(Z\\) so that the coproduct may pick out an \\(A \cup B\\)-shaped subset.

The free-monoids coproduct: given any "co-test object" \\(N\\), and any two monoid homomorphisms selecting subsets of \\(N\\) corresponding to the shapes of \\(M(A)\\) and \\(M(B)\\), there should be a natural way to define a shape corresponding to some kind of union. The shape of \\(M(A)\\) corresponds exactly to "where we send the generators", so we can see intuitively that \\(M(A) + M(B) = M(A+B)\\). This is very much not a proof, and I'll make sure to check the diagrammatic proof from the book first; that proof is fine with me. "Forgetful functor preserves products -> a structure-imposing functor preserves coproducts" has a certain appeal to it, but I don't quickly see a sense in which the structure can be imposed in general.

Coproduct of two topological spaces: given a co-test topological space \\(X\\), and two continuous functions into \\(X\\) which pick out subspaces of shape \\(A\\) and \\(B\\), we want to find a space \\(P\\) such that for all \\(A\\)- and \\(B\\)-shape subspaces of \\(P\\), there is a unique \\(P\\)-shaped subspace of \\(X\\) composed of the same shapes as the \\(A\\)- and \\(B\\)-subspaces. Then it's fairly clear that \\(P\\) should be the disjoint union of \\(A\\) and \\(B\\) (compare with the fact that the forgetful functor to Set again yields the correct Set coproduct), but what topology? Surely it should be the "product" given by sets of the form (open in \\(A\\), open in \\(B\\)), since \\(A\\)-shaped subspaces of this will map directly into \\(A\\)-shaped subspaces of the co-test space, etc.

Coproducts, therefore, are a way of putting two things next to each other, and this is pointed out in the next paragraph, where the coproduct of two posets is the "disjoint union" of them. The coproduct of two rooted posets is what I'd have guessed, as well, given that we need to make sure the coproduct is also rooted.

Coproduct of two elements in a poset: that's easy by duality, since the opposite category of a poset is just the same poset with the opposite ordering. The product is the greatest lower bound, so the coproduct must be the least upper bound. How does this square with the idea of "put the two elements side by side"? This category is not concrete, so we need to work out what we mean by "an element of shape \\(A\\)". Since an arrow \\(A \to X\\) is precisely the fact that \\(A \leq X\\), we have that for every element \\(y\\) of the poset, all elements which compare less than or equal to that element have "images of shape \\(y\\)" in \\(X\\). Therefore, the coproduct condition says "for every co-test object \\(X\\), for every pair of images of shape \\(A, B\\) in \\(X\\), the there is an image of shape \\(A+B\\) in \\(X\\) which restricts to the images of shape \\(A\\) and \\(B\\) respectively". With a bit of mental gymnastics, that does correspond to \\(A+B\\) being the least upper bound.

Coproduct of two formulae in the category of proofs: an arrow from one formula to another is a deduction. An "image of shape \\(A\\) in \\(X\\)" - an arrow \\(A \to X\\) - is therefore a statement that we can deduce \\(X\\) from \\(A\\). We want a formula \\(A+B\\) such that for any co-test formula \\(X\\), and for any images of \\(A, B\\) in \\(X\\), there is a unique image of \\(A+B\\) in \\(X\\) which respects the shapes of \\(A\\) and \\(B\\) in \\(A+B\\). Hang on - at this point I realise that the opposite category of the category of proofs is the "category of negated proofs", and the "opposite category" functor is simply taking "not" of everything. That's because the contrapositive of a statement is equivalent to the statement. Therefore since the product is the "and", the coproduct should be the "or" (which is the composition of "not-and-not", or "dual-product-dual). I'll keep going anyway.

We need to be able to prove \\(A+B\\) from \\(A\\), and to prove \\(A+B\\) from \\(B\\). That's already mighty suggestive. Moreover, if there's a proof of \\(X\\) from \\(A\\), there needs to be a unique corresponding proof of \\(X\\) from \\(A+B\\). That's enough for my intuition to say "this is OR, beyond all reasonable doubt".

I now look at the book's explanation of this. Of course, I omitted to perform an actual proof that OR formed the coproduct, and that bites me here: identical arrows must yield identical proofs, but any proof which goes via "a OR b" must be different from one which ignores b. Memo: need to prove the intuitions.

Coproduct of two monoids. Ah, this is a cunning idea, viewing a monoid as a sub-monoid of its free monoid. We already know how to take the coproduct of two free monoids, and we can do the equiv-rel trick that worked with the category of proofs above. Is it possible that in general we do coproducts by moving into a free construction and then quotienting back down? I'm struggling to see how free posets might work, so I'll shelve that idea for now.

I went to sleep in between the previous paragraph and this one, so I'm now in a position to write out a proper proof that the coproduct of two monoids is as stated. I did it without prompting in a very concrete way: given a word('s equivalence class) in \\(M(\vert A \vert + \vert B \vert)\\), and two maps \\(z_1: A \to N\\) and \\(z_2: B \to N\\), we send the letter \\(a \in \vert A \vert\\) to \\(z_1(a)\\), etc. The book gives a more abstract way of doing it. I don't feel like I could come up with that myself in a hurry without a better categorical idea of "quotient by an equivalence relation". At least this way gave me a good feel for why we needed to do the quotient: otherwise our \\(\phi: a \mapsto z_1(a)\\) could have been replaced by \\(a \mapsto u_A z_1(a)\\). The map is unique in this setting. Indeed, suppose \\(\phi([w]) \not = \phi_2([w])\\) for some \\(w\\). We may wlog that \\(w\\) is just one character long, since any longer and we could use that \\(\phi, \phi_2\\) are "homomorphic" to find a character where they differed. (That's where we need that we're working with equivalence classes.) Wlog \\([w] = [w_1]\\). Then \\(\phi([w_1]) \not = \phi_2([w_1])\\); but that means \\(z_1(w_1) \not = z_1(w_1)\\) because the map \\(\phi_2\\) also needs to commute with \\(z_1\\).

I make sure to note that the forgetful functor Mon to Sets doesn't preserve coproducts.

Aha! An example I've seen recently in a different context. (Oops, I've glanced to the bottom of the page, Proposition 3.11. I'll wait til I actually get there.)

I'm confused by the "in effect we have pairs of elements" idea. What about a word like \\(a_1 a_2 b_1 b_2 b_3\\)? Then we don't get a pair of elements containing \\(b_3\\). Ah, I see - Awodey is implicitly pairing with \\(0_A\\) in that example. I'd have preferred to have that spelled out. Now I do see that the underlying set of the coproduct should be the same as that of the product, and that the given coproduct is indeed a coproduct.

Now my "aha" moment from earlier. I've seen this fact referenced [a few days ago][stack exchange] on StackExchange. I can follow the proof, and I see where it relies on abelian-ness, but don't really see much of an idea behind it. The obvious arrows \\(A \to A\\) and \\(B \to B\\) are picked, but it seems to be something of a trick to pick the zero homomorphism \\(A \to B\\). In hindsight, it's the only homomorphism we could have picked, but it would have taken me a while to think of it.

I skim over the bit about abelian categories, and over the various dual notions to products (like "coproducts are unique up to isomorphism", "the empty coproduct is an initial object" etc).

# Summary

This was a bit less intuitive than the idea of the product. Instead of having "finding \\(Z\\)-shaped things in \\(A\\) and \\(B\\) means we can find a \\(Z\\)-shaped thing in the product", we have "finding \\(A\\)- and \\(B\\)-shaped things in \\(Z\\) means we can find a coproduct-shaped thing in \\(Z\\) too", but it took me a while to fix this in my mind, and it still seems to me a little less easy for something to be a coproduct: we've been bothering with equivalence classes more.

[semantic truth]: https://en.wikipedia.org/wiki/Semantic_theory_of_truth
[syntactic truth]: https://en.wikipedia.org/wiki/Logical_consequence
[stack exchange]: https://math.stackexchange.com/a/1430755/259262
