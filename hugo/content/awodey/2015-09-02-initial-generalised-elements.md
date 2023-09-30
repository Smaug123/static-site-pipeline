---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- awodey
comments: true
date: "2015-09-02T00:00:00Z"
math: true
aliases:
- /categorytheory/initial-generalised-elements/
- /initial-generalised-elements/
title: Initial, terminal, and generalised elements
---

This is pages 33 to 38 of Awodey.

This bit looks really cool. A categorical way of expressing "this set has one element only": a terminal object. We have more examples of UMPs - these aren't quite of the same form as the previous ones.

The proof that initial objects are unique up to unique isomorphism is easy - no need for me even to consider the diagram. On to the huge list of examples.

Sets example: agreed. I actually asked about this (the fact that Set is not isomorphic to its dual) on Stack Exchange, and got basically this answer. Just a quick check that the one-point sets are indeed unique up to unique isomorphism, which they are.

The category 0 is definitely initial in Cat; I agree that 1 is also terminal.

In Groups: the initial objects are those for which there is precisely one homomorphism between it and any other group. Such a group needs to be the trivial group, since if \\(G\\) contains any other element, we can send \\(G\\) to \\(G\\) in a non-identifying way by sending every element to its inverse. The terminal objects: again that's just the trivial group, because for any other group \\(G\\), we can take two different homomorphisms into \\(G \times G\\), by projection onto the first or second coordinates. In Rings, on the other hand, I agree that \\(\mathbb{Z}\\) is initial: the unit has to go somewhere, and that determines the image of all of \\(\mathbb{Z}\\).

Boolean algebras are something I ought to have met before in Part II Logic and Sets, but it was not lectured. I think I'll come back to this if it becomes important, because I feel like I have a good idea for the moment of what an initial/terminal object are.

Posets: an object is indeed initial iff it is the least element. We have that initial elements are isomorphic up to unique isomorphism. What does that mean here? It means there is a unique arrow which has an inverse between these two elements. That is, it means the two elements are comparable and equal (by \\(a \leq b, b \leq a \Rightarrow a=b\\)). We therefore require there to be a *single* least element, if it is to be initial. What about the poset consisting of two identical copies of \\(\mathbb{N}\\), the elements of each copy incomparable to those of the other? There is no arrow from the 1 in the first \\(\mathbb{N}\\) into any element of the second \\(\mathbb{N}\\), so I'm happy that this is indeed not initial.

Identity arrow is terminal in the slice category: everything has a unique morphism into this arrow, yes, because there is always a single commutative triangle between an arrow into \\(X\\) and the identity arrow on \\(X\\).

Generalised elements, now. Hopefully this will be about ways of saying categorically that "this set has three elements", in the same way as "this set is terminal" was a categorical way of identifying a set with one element.

"A set \\(A\\) has an arrow \\(f\\) into the initial object \\(A \to 0\\) just if it is itself initial." An initial object, remember, is one which has exactly one arrow into every other object, so it must have an arrow into \\(A\\); but the composition of \\(f\\) with that arrow must then be the identity on \\(0\\), since there is only one arrow \\(0 \to 0\\). Therefore \\(A, 0\\) are isomorphic and hence both initial.

In monoids and groups, every object has a unique arrow to the initial object - that's trivial, since there is only one object. Unless it means objects in the category of monoids? The unique initial object is the trivial group, and it's also terminal. That makes more sense.

Curses, I'm actually going to have to understand Boolean algebras now. I'll flick back to the definition and try to understand example 4 above. The definition looks an awful lot like the definitions of intersection and union, so I think I'll just think of them in that way. What's a filter? It's what we get when we infect some sets with filterness, and filterness propagates to "parents" and to "children of two parents" (intersections). An ultrafilter then is a filter where adding any other set infects everything.

A filter \\(F\\) on \\(B\\) is an ultrafilter iff for every \\(b \in B\\), either \\(b \in F\\) or \\(b^C \in F\\) but not both: if \\(b \in F\\) then \\(b^C\\) can't be in \\(F\\) because then the empty set (that is, the intersection) is in the filter, so the filter is "everything". If \\(b \not \in F\\) then unless \\(b^C \in F\\), we could add \\(b\\) to \\(F\\) to obtain a strictly larger filter which still isn't everything, since \\(b^C\\) is still not in the augmented filter.

Then I agree with the following stuff about "ultrafilters correspond to maps \\(B \to 2\\)". Not much more I can find to say there immediately.

Ring homomorphisms \\(p\\) from ring \\(A\\) into the initial ring \\(\mathbb{Z}\\) correspond with prime ideals: yep, since \\(p^{-1}(0)\\) is an ideal of \\(A\\) (being the kernel of \\(p\\)), which is prime because we quotient by it to get a Euclidean domain \\(\mathbb{Z}\\).

From arrows from initial objects to arrows from terminal objects. The definition of a point of object \\(A\\) is a natural one, as is the warning that objects are not necessarily determined by points (this is in the case that structural information is bound up in the arrows, like in a monoid viewed as a category). How many points does a Boolean algebra have? The terminal Boolean algebra is \\( \{ 0 \} \\); an arrow from \\(\{0\}\\) to a Boolean algebra must only ever pick out the \\(0\\) element, because the arrows must preserve the zero. That is, Boolean algebras have only one point.

"Generalised elements" is therefore a way of trying to capture all the information, which the terminal object does not necessarily. The example which follows is a summary of this idea. There is something there to prove: that \\(f = g\\) iff \\(fx = gx\\) for all arrows \\(x\\). This leaves me stuck for a bit - I'm reviewing possible ways to prove that two arrows are the same, but the only ways I can think of require some kind of invertibility. What does it even mean for two arrows to be equal? At this point I got horribly confused and asked StackExchange, where I was told that I don't need to worry about that - just let \\(x\\) be the identity arrow. (By the way, it seems that equality of arrows is in the first-order logic sense here.)

Example 2.13: aha, a way of showing categories are not isomorphic. Always handy to have ways of doing this. The number of \\(\mathbf{2}\\)-elements from \\(\{0 \leq 1 \}\\) to \\(\{x \leq y, x \leq z \}\\): \\(0\\) may map to \\(x\\), then \\(1\\) may map to \\(x\\) \\(y\\) or \\(z\\), or \\(0\\) may map to \\(y\\) or \\(z\\), when \\(1\\) must map to the same, producing five such 2-elements. I'm not sure I see why this is invariant, but on the next page I see that will be explained, and it all seems quite satisfactory.

Example 2.14: ah, the "figures of shape \\(T\\) in \\(A\\)" interpretation makes it actually intuitive why the number of \\(2\\)-elements of the posets above are what they are. The arrows from the free monoid on one generator suffice to distinguish homomorphisms? That is, if we know where all \\(\mathbb{N}\\)-shapes go from \\(M\\), can we entirely determine the homomorphism? Yes, we can. If we have access to the elements of the monoid, we can do better (by simply specifying the image of each element), but of course we don't have the elements.

# Summary

I might need a bit more exposure to these ideas before I understand them properly, but I suspect the exercises at the end of this chapter will help with that. This feels like the first really categorical thing that has happened: ways of cheating so that we can consider the elements of structures without actually needing any elements.
