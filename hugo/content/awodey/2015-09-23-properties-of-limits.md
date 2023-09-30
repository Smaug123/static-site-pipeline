---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- awodey
comments: true
date: "2015-09-23T00:00:00Z"
math: true
aliases:
- /categorytheory/properties-of-limits/
- /properties-of-categorical-limits/
title: Properties of categorical limits
---

We've seen how limits are formed, and that they exist iff products and equalisers do. Now we get to see about continuous functions and colimits, pages 105 through 114 of Awodey.

The definition of a continuous functor is obvious in hindsight given the real-valued version: it "preserves all limits", where "preserves a particular limit" means the obvious thing that limits of cones of the given shape remain limits when the functor is applied.

The example is the representable functor, taking any arrow in category \\(\mathbf{C}\\) to its corresponding "apply me on the left!" arrow in Sets. That is basically to the relevant commutative triangle in \\(\mathbf{C}\\). I hope the following proof will help me understand the representable functors more clearly.

Representable functors preserve all limits: we need to preserve all products and all equalisers. Awodey shows the empty product first, which is clear: the terminal object goes to the terminal object. Then an arbitrary product \\(\prod_{i \in I} X_i\\) gets sent to \\(\text{Hom}(C, \prod_i X_i)\\), which is itself a product because \\(f: C \to \prod_i X_i)\\) corresponds exactly with \\(\{ f_i: C \to X_i \mid i \in I\}\\). (Indeed, the projections give \\(f \mapsto \{ f_i \mid i \in I\}\\); conversely, the UMP of the product gives a unique \\(f\\) for the collection \\(\{ f_i \mid i \in I \}\\).)

This has given me the intuition that "the representable functor preserves all the structure" in the sense that the diagrams will look the same before and after having done the functor.

Equalisers are the other thing to show, and that falls out of the definition in a completely impenetrable way. I can't distill that into "the representable functor preserves all the structure" so easily.

Then the definition of a contravariant functor. I've heard the terms "covariant" and "contravariant" before, several times, when people talk about tensors and general relativity and electromagnetism, but I could never understand what was meant by them. This definition is clearer: a functor which reverses input arrows with respect to the objects. Operations like \\(f \mapsto f^{-1}\\) would be contravariant, for instance.

The representable functor \\(\text{Hom}_{\mathbf{C}} ( -, C) : \mathbf{C}^{\text{op}} \to \mathbf{Sets}\\) is certainly contravariant, taking \\(A\\) to \\(\text{Hom}(A, C)\\) and an arrow \\(f: B \to A\\) to \\(f^* : \text{Hom}(A, C) \to \text{Hom}(B, C)\\) by \\((a \mapsto g(a)) \mapsto (b \mapsto g(f(b)))\\). The contravariant functor reverses the order of arrows in its argument; it takes arrows to co-arrows, so it should take colimits to co-colimits, or limits. I need to keep in mind this example, to avoid the intuition that "functors take things to things and cothings to cothings": if the functor is covariant, it flips the co-ness of its input.

Example: a coproduct is a colimit, so \\(\text{Hom}_{\mathbf{C}} ( - , C)\\) should take the coproduct to a product. That might be why we had \\(\mathbb{P}(A+B) \cong \mathbb{P}(A) \times \mathbb{P}(B)\\) as Boolean algebras: the functor \\(\mathbb{P}\\) might be contravariant. What does it do to the arrow \\(B \to A\\)? Recall that an arrow in the category of Boolean algebras (interpreted as posets) is an order-preserving map. Huh, not contravariant after all: the \\(\mathbb{P}\\) functor seems covariant to me. There must be some other reason; [it turns out][SE] that I'm mixing up two different functors, one of which is covariant and takes sets to sets, and one of which is contravariant and takes sets to Boolean algebras.

"The ultrafilters in a coproduct of Boolean algebras correspond to pairs of ultrafilters": recall that the functor \\(\text{Ult}: \mathbf{BA}^{\text{op}} \to \mathbf{Sets}\\) takes an ultrafilter to the corresponding set of indicator functions picking out whether a given subset is in the filter, and an arrow \\(f: B \to A\\) of ultrafilters to the arrow \\(\text{Ult}(f): \text{Ult}(A) \to \text{Ult}(B)\\) by \\(\text{Ult}(f)(1_U) = 1_U \circ f\\), and so it is representable. (I barely remember this. I think I deferred properly thinking about representable functors until Awodey covered them properly.) At least once we've proved that, we do get "ultrafilters in the coproduct correspond to pairs of ultrafilters", by the iso in the previous paragraph.

The exponent law is much easier - it follows immediately from the same iso.

(Oh, by the way, we have that limits are unique up to unique isomorphism, because they may be formed from products and equalisers which are themselves unique up to unique isomorphism.)

Next section: colimits. The construction of the co-pullback (that is, pushout) is dual to that of the pullback: take the coproduct and then coequalise across the two sides of the square. So the coproduct of two rooted posets would be the pushout of the two "pick out the root" functions: let \\(A = \{ 0 \}\\), and \\(B, C\\) be rooted posets with roots \\(0_B, 0_C\\). Then the pushout of \\(f: A \to B\\) by \\(f(0) = 0_B\\) and \\(g: A \to C\\) by \\(g(0) = 0_C\\) is just the coproduct of the two rooted posets.

Ugh, a geometrical example next. Actually, this is fairly neat: the coproduct of two discs, but where we view two points as being the same if they are both images of the inclusion. That's just two circles glued together on the boundary, which is topologically the same as a sphere. In the next lower dimension, we want to take two intervals, glued together at their endpoints, making a circle.

Then the definition of a colimit, which is the obvious dual to that of a limit. I skip through to the "direct limit" idea, where the colimit is taken over a linearly ordered indexing category. I can immediately see that this might be associated with the idea of a limit in \\(\mathbb{R}\\), but I'll save that until after the worked example, which is the direct limit of groups.

The colimit setup is all pretty obvious in retrospect, but I didn't try and come up with it myself. (The exercises will show whether it really is obvious!) The colimiting object does exist because coproducts and coequalisers do, and we can construct it as the coproduct followed by a certain coequaliser - namely, the one where "following a path through the sequence, then going out to the colimit, is the same as just going straight to the colimit". That is, such that \\(p_n g_{n-1} g_{n-2} \dots g_i = p_i\\), where the \\(p_i: G_i \to L\\) are the maps into the colimit. The equivalence relation whose quotient we take, is therefore: if \\(x \in G_n, y \in G_m\\), then \\(x \sim y\\) iff there is some \\(k\\) such that if we follow along the homomorphisms starting from \\(x\\) and \\(y\\), we eventually hit a common element. (Indeed, if there existed elements \\(x, y\\) which didn't have this property, then \\(p_m g_{m-1} \dots g_n(x) \not = p_n(x)\\).) I think I've got that.

The operations are the obvious ones, and we've made a kind of "infinite intersection" of these groups, where the maps \\(u_n: G_n \to G_{\infty}\\) are the "inclusions". Universality is inherited from Sets, so as long as the limiting structure obeys the group axioms, we have indeed ended up with a colimit.

What does it mean, then, for functor \\(F: \mathbf{C} \to \mathbf{D}\\) to "create limits of type \\(\mathbf{J}\\)"? For each diagram \\(D\\) in \\(\mathbf{D}\\) of type \\(\mathbf{J}\\), and each limit of that diagram, there is a unique cone in \\(\mathbf{C}\\) which is sent to \\(D\\) by \\(F\\), and moreover that cone is itself a limit.

In the example above, \\(F\\) is the forgetful functor Groups to Sets, \\(\mathbf{J}\\) is the ordinal category \\(\omega\\). For each diagram \\(D\\) in Sets of type \\(\omega\\), the colimit of the diagram is given by taking the coproduct of all the \\(D_i\\), and identifying \\(x_n \sim g_n(x_n)\\) (where \\(g_n: D_n \to D_{n+1}\\) is the arrow in \\(D\\) corresponding to the arrow in \\(\omega\\) from \\(n\\) to \\(n+1\\)). Then we can pull this back through the forgetful functor to obtain a corresponding cocone in Groups, and we can check that it's still a colimit. That is, \\(F\\) creates \\(\omega\\)-colimits.

Why does it create all limits? Take a diagram \\(C: \mathbf{J} \to \mathbf{Groups}\\) and limit \\(p_j: L \to U C_j\\) in \\(\mathbf{Sets}\\). Then we need a unique Groups-cone which is a limit for \\(C\\). The Set-limit can be assigned a group structure, apparently. It's obvious how to do that in the case that the limit was an ordinal - it's the same as we saw above - but in general…

I'll leave that for the moment, because I want to get on to adjoints sooner rather than later (they're apparently treated very early in the Part III course).

The idea behind the cumulative hierarchy construction is clear in the light of the \\(\omega\\) example above, and this makes it immediately obvious that each \\(V_{\alpha}\\) is transitive. The construction of the colimit is the obvious one (although I keep having to convince myself that it is indeed a colimit, rather than a limit).

What does it mean to have all colimits of type \\(\omega\\)? A diagram of \\(\omega\\)-shape is an \\(\omega\\)-chain. A colimit of that chain would compare bigger than all the elements of the chain (that's "there is an arrow \\(n \to \omega\\)" - that is, "it is a cocone"), and would have the property that if \\(n \leq x\\) for all \\(n\\) then \\(\omega \leq x\\) (that's "all other cocones have a map into the colimit"). The colimit is a "least upper bound" for the specified chain. A monotone map is called continuous if it maintains this kind of least upper bound.

Then we have a restated version of the theorem that "an order-preserving map on a complete poset has a fixed point", which I remember from Part II Logic and Sets. The proof here is very different, though. I follow it through, doing pretty natural things, until "The last step follows because the first term \\(d_0 = 0\\) of the sequence is trivial". Does it actually make a difference? If we remove the first element of the chain, I think it couldn't possibly alter anything in this case, even if the first element were not trivial, because we've already taken the quotient identifying "things which are eventually equal".

I was a little confused by the statement of the theorem. "Of course \\(h\\) has a least fixed point, because it's well-ordered" was my thought, but obviously that's nonsense because \\([0,1]\\) is not well-ordered. So there is some work to do here, although it's easy work.

The final example seems almost trivial when it's spelled out, but I would never have come up with it myself. Basically saying that "you need to check that your proposed colimit object actually exists", and if it doesn't, you might have to add things to your colimit until it starts existing". I don't know how common a problem this turns out to be in practice, but the dual says that we can't assume naive limits exist either.

# Summary

This was another rather difficult section. Fortunately the exercises come next, and that should help a lot. I've dropped behind a bit on my Anki deck, and need to Ankify the colimits section.

[SE]: http://math.stackexchange.com/a/1448655/259262
