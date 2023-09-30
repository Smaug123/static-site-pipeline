---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- awodey
comments: true
date: "2015-08-20T00:00:00Z"
math: true
aliases:
- /categorytheory/new-categories-from-old/
- /new-categories-from-old/
title: New categories from old
---

Here, I will be going through the Isomorphisms and Constructions sections of Awodey's Category Theory - pages 12 through 17.

The first definition here is that of an isomorphism within a category. I notice that it corresponds with the usual definition of an isomorphism, but it's not phrased in exactly the same way. Up til now, "isomorphism" has strictly meant "bijective homomorphism". Are these two notions secretly the same? They can't be, because arrows aren't necessarily homomorphisms. Let's proceed with this slightly unfamiliar definition: it is an "arrow which is invertible on either side by the same inverse". The book asks us to prove that inverses are unique - that's easy by the usual group-inverses proof, which only really requires associativity.

I need to be careful to remember that isomorphisms (as defined here) aren't between categories, but between members of a category. That is, they're not functors but arrows. (Though of course an arrow may represent a functor, but that's beside the point.)

Now comes a paragraph about abstract definitions, which basically crystallises my thoughts that isomorphism is a more general form of "bijective homomorphism" which works in all categories. The example from the poset category with monotone functions as arrows is something I'm going to have to get my head around. Here goes.

What does the category-theoretic definition of an isomorphism look like in the category of posets? It's a monotone function which has a monotone inverse. (Ah, that's more like the definition I remember: "a homeomorphism is a continuous function with a continuous inverse".) How is that different from "bijective homomorphism"? We'll want a monotone function which has an inverse which is not monotone. The standard topological spaces example was on an arbitrary space, between the discrete topology and the indiscrete topology. One direction is continuous and the other is not. Can I quickly turn that into a poset example? The obvious way to go would be on the same set from "nothing is related" to "total order". Definitely order-preserving: if \\(x < y\\) then \\(f(x) < f(y)\\) is vacuously true; definitely invertible; definitely not what we want an isomorphism to look like. I think I've got my head around the difference now.

In the case of a monoid (viewed as a category), "only the abstract definition makes sense". Is that true? Firstly, what does the abstract definition look like? In a group, all elements are isomorphisms. If we take the monoid \\((\mathbb{Z} \cup \{ \infty \}, +)\\), the arrow \\(\infty: G \to G\\) is not an isomorphism because it has no inverse. That seems fine. Can I make sense of the idea of a monoid element being a "bijective homomorphism"? I could make the element act on the monoid by left multiplication, and I don't see anything wrong with that at the moment. I moved on at the time, but asked someone a bit later about this. The answer is that there are some categories which can't be viewed concretely at all, so the idea of "an arrow is a function" can't be made to make sense in some categories.

Definition of a group is next; I definitely understand that, and I discovered for myself that a group has all its arrows as isomorphisms. I'll skip the bit about some examples of groups, because I know it, and go to the definition of a group homorphism. That bit is clear too, so on to Cayley's Theorem.

The proof which appears here is basically the same as the one I was taught: show that action-on-the-left gives us a way to turn \\(G\\) into a permutation group on itself.

The warning is interesting, and I hadn't noticed the feature it points out. I'll think about that a bit further. OK, it doesn't actually seem to be that problematic to understand, but definitely important to keep my thinking type-checked.

Theorem 1.6. This looks important. We instantiate objects by their collection of incoming arrows, and instantiate arrows by functions which "represent" an arrow in the same way as the regular representation does in groups. Actually, that doesn't seem particularly important: it's just saying "we can instantiate categories whose arrows form a set". Maybe the Remark will clear things up. It's basically saying by analogy that "there's nothing special about permutation groups, since all groups may be viewed as permutation groups, so stop thinking about them in that way please". I think I'll wait until the discussion of terminal objects before I try and get my head around the true interpretation of a concrete category.

Now the New Categories From Old section. The product looks easy enough, and its two projections are natural. The dual category likewise is pretty obvious, and makes the dual vector spaces idea much neater.

The arrow category takes me a while to get my head around. The composition operation clearly does compose arrows correctly. What does the arrow category of the integer category \\(3\\) look like? Let's call the objects of \\(3\\) by the names \\(a, b, c\\). Then the arrow category has six objects (three identity and three non-identity arrows). We can find all the commutative squares by brute force, which I did on paper: there are \\(3^4\\) squares, but anything with \\(c\\) in the top left corner must be the identity arrow on the arrow \\(c \to c\\). That narrows it down enough for me to do this by hand. We end up with \\(a \to a\\) being connected to every arrow; \\(a \to b\\) connected to every arrow except \\(a \to a\\); \\(a \to c\\) connected only to \\(a \to c, b \to c, c \to c\\); \\(b \to b\\) connected to \\(b \to b, b \to c, c \to c\\); \\(b \to c\\) connected to \\(b \to c, c \to c\\); and \\(c \to c\\) connected to \\(c \to c\\). That is, if we omit the identity arrows, we obtain the following Hasse diagram.

![Arrow category of 3][arrow]

I don't think that was very enlightening. Motto: arrow categories aren't obviously anything in particular. What about the forgetful functors specified by taking the codomain or the domain? I'm happy that those are both functors, having stared at my diagram.

Now comes the slice category. I've read this over once and got absolutely nowhere, so let's try again more carefully. The objects I can deal with: any arrow which goes into \\(C\\). The arrows? I'll do this with the category \\(3\\) again. If we slice on \\(a\\) then the only object is the identity arrow, and the only arrow is another identity. If we slice on \\(b\\) then there are two objects: \\(a \to b\\) and \\(b \to b\\). (Just quickly went back to the definition of a category, to check that \\((a \to b) \circ (b \to b)\\) isn't another arrow; in general it could be, but there isn't in this category.) Then in the slice category, there's an arrow \\((a \to b) \to (a \to b)\\) - namely the \\(C\\)-arrow \\(a \to a\\) - and an arrow \\((a \to b) \to (b \to b)\\) - namely the \\(C\\)-arrow \\(a \to b\\). We also have \\(b \to b\\)'s identity arrow. Therefore, we have recovered the category \\(2\\). That gives me intuition about what the identity arrows in the slice category look like.

I don't think I've got any more intuition here. I'll briefly move on to the bit about the functor which forgets the sliced object. Certainly I agree that the given functor behaves correctly on objects. Does it behave on arrows? Yes, that's obvious from the syntactic definition, but I'm not certain I grok it. (I notice at this point that the functor is not necessarily surjective, as the \\(3\\) example above shows.)

If I understand the composition law, then I should understand the arrows, so I'll aim for that instead. The composition law is clear from the book's diagram, on page 16: just add another triangle joined along edge \\(f'\\) to make a bigger supertriangle. OK, now I'm happier about the arrows in the slice category: they really are just arrows in the original category, and they join two slice-category objects (that is, arrows in \\(C\\)) if the two objects form a commutative triangle. This is actually a lot like the arrow category, by the looks of it.

What about this composition functor? It lets us slice out on a different vertex by "changing the worldview", viewing everything through the lens of a particular arrow. I'm happy enough with that as a concept, although I recognise that my "understanding that this is a functor" is purely syntactic. Hopefully I'll get used to this with time.

"The whole slicing construction is a functor". Yes, OK, that follows from the existence of the composition functor. I repeat that I'm understanding this at the surface level only, and I don't really grok any of it.

What happens if we slice out a group (viewed as a category) by its only object? Then we get a category which has objects {the elements of the group}, and arrows \\(g \to h\\) given by \\((h^{-1} \circ g) \in C\\). That seems to have taken the group and told us how all its elements are related, which is mildly interesting.

I verify that the slice category of a poset category is the "principal ideal" as stated, and note with relief that we will see more examples soon.

The coslice category: that's obviously just the dual of the slice category.

The category of pointed sets: yep, it's a category. I really don't' understand the isomorphism with the coslice category on sets. I can just about see it syntactically, but this is going to need a lot more work. I spent about ten minutes trying to work out what this really meant.

## Summary

I'm happy with some of these constructions, but I'll need a lot more work on others. I'll do these constructions on some more categories and see what happens.

After composing this post, I asked someone for intuition, and got the reply:

"The coslice category has objects which may be viewed as pairs \\((A, f)\\), where \\(f:\{ * \} \to A\\). So \\(f\\) is exactly a choice of element in \\(A\\). And the morphisms are maps such that the triangle commutes, i.e. the element "chosen" by \\(f\\) is the same as the one "chosen" by \\(f'\\)."

I think this has cleared things up, but time will tell.

[arrow]: {{< baseurl >}}images/CategoryTheorySketches/ArrowCategoryOf3.jpg
