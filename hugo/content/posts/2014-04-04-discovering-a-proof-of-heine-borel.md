---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
- proof_discovery
comments: true
date: "2014-04-04T00:00:00Z"
math: true
aliases:
- /mathematical_summary/proof_discovery/discovering-a-proof-of-heine-borel/
- /discovering-a-proof-of-heine-borel/
title: Discovering a proof of Heine-Borel
---
I'm running through my Analysis proofs, trying to work out which ones are genuinely hard and which follow straightforwardly from my general knowledge base. I don't find the [Heine-Borel Theorem][1] "easy" enough that I can even forget its statement and still prove it (like [I can with the Contraction Mapping Theorem][2]), but it turns out to be easy in the sense that it follows simply from all the theorems I already know. Here, then, is my attempt to discover a proof of the theorem, using as a guide all the results I know but can't necessarily prove without lots of effort.

# Statement of the theorem

The Heine-Borel Theorem states that a subset of \\(\mathbb{R}^n\\) is compact if and only if it is closed and bounded.

# First direction

One direction looks easy - if we assume our set is not closed or not bounded, it should be simple to show that it is not compact, using an argument based on the fact that \\((0,1]\\) is not compact and \\([0, \infty)\\) is not compact. Both of those I know how to prove.

## Assume not closed

If the set \\(S\\) is not closed, the only thing we can do is take a sequence \\((x_n)_{n \geq 1}\\) tending to a limit \\(x\\) which is not in \\(S\\). From this, we need to create an open cover of \\(S\\) which has no finite subcover.

In one dimension, this is easy because we can just take a ball around each \\(x_i\\), each ball overlapping by a tiny bit with the next. Clearly since any finite cover must include each \\(x_i\\), it must also include those balls, whence it must include an infinite number of balls (contradiction). However, in more dimensions this is not so obvious, because we don't have this handy "next ball" concept. What was really key in that 1D example was that the balls around each \\(x_i\\) didn't overlap to the extent that a ball contained more than one \\(x_i\\), and that no ball got near the forbidden limit point. (There was always "room to keep going" - in the \\((0,1]\\) example, taking the sets \\((\dfrac{1}{n+1}, \dfrac{1}{n})\\) and filling in some tiny balls around each \\(\dfrac{1}{n}\\), every set is some finite distance away from \\(0\\).)

In more dimensions, if we create an open cover of \\(S\\) such that no set gets near the limit point \\(x\\) - that is, such that each set in the cover has some neighbourhood of \\(x\\) which it doesn't encroach upon - then any finite cover must also have some neighbourhood of \\(x\\) which it doesn't encroach upon. (A finite collection of things which don't get close to 0 must also not get close to 0.) Hence, because we have a sequence tending to \\(x\\) in \\(S\\), which \*does\* get close to \\(x\\), one of the \\(x_i\\) can't be included in our finite cover. That contradicts compactness.

## Assume not bounded

Remember our key example here was \\([0, \infty)\\). Since our set isn't bounded, we can take a sequence in it getting arbitrarily far out from \\(0\\) (that is, for every \\(n\\) there is \\(x_n\\) such that \\(\vert x_n \vert \geq n\\)). But then the easiest cover to use is just the set of balls centred on \\(0\\) with radius \\(n\\); this is an infinite cover, but there is no finite subcover because if we ever stop, there's an \\(x_n\\) we've missed.

# The other direction

Here's the bit that looks harder, because we're taking any closed bounded set and showing a strong property of it. Remember, though, that we have in fact proved this in 1D already: we proved the Bolzano-Weierstrass property of the reals, and it is a fact (although I don't remember how to prove it) that sequential compactness implies compactness. Let's see if we can make that proof work. (The proof I know goes along the lines of "fix an infinite sequence in an interval; keep halving the interval; there's an infinite subsequence in one of the halves; repeat".)

Firstly, we're faced with an arbitrary closed bounded set. With the not-closed or not-bounded sets it was easier - we had somewhere to start from. We're going to need to make the problem simpler, because closed bounded sets can look really quite odd. The simplest possible closed bounded set is the closed ball centred on the origin of radius \\(r\\), but that's not great for halving. What we can halve is a box \\([-r, r]^n\\) - that's the second-simplest possible closed bounded set (arguably the most simple).

Take an open cover of the box, and assume for contradiction that it has no finite subcover. Divide the box up into \\(2^n\\) smaller boxes by cutting halfway along each side. One of these boxes must have no finite subcover of the original cover (otherwise they'd all have finite subcovers, so we could union them all together to get a finite subcover of the big box), so we can repeat on that box. Inductively we obtain a sequence of nested boxes, none of which has a finite subcover in the original cover, and they are boxes of side length \\(r \times 2^{-n}\\).

What do we know about these nested boxes? In 1D, the proof then went "our infinite sequence therefore has a limit": there was a point which lay in every box. We'd love that to be true here: an infinite sequence of closed nested boxes must have non-empty intersection. Fortunately, that's easy to prove: take a sequence \\(z_n\\) such that each \\(z_n\\) lies in the \\(n\\)th box but not the \\(n+1\\)th. This sequence tends to a limit, because it's clearly Cauchy; we'll show that the limit lies in every box. Indeed, we know that the boxes are closed, so the sequence \\(z_n, z_{n+1}, z_{n+2}, \dots \to z\\) tells us that \\(z\\) lies in box \\(n\\) for every \\(n\\), so there is no \\(n\\) such that \\(z\\) is not in the \\(n\\)th box, and hence \\(z\\) is in every box.

Now, we have our concentric boxes homing in on \\(z\\), and \\(z\\) lies in all of these boxes. Moreover, the boxes get smaller and smaller, quite rapidly, and each of them requires an infinite number of sets from our original cover in order to cover it. But where is \\(z\\)? \\(z\\) lies in some set \\(U\\) in the original cover; \\(U\\) is some finite size, so it must cover one of the boxes completely, because the sizes of the boxes goes to zero. Formally, \\(U\\) contains some ball \\(B_z(\epsilon)\\); for all \\(\epsilon\\) there is \\(n\\) such that the \\(n\\)th box lies wholly in \\(B_z(\epsilon)\\); hence \\(U\\) contains the \\(n\\)th box, for some \\(n\\).

This contradicts the fact that the \\(n\\)th box requires an infinite cover of open sets - we've done it in just one!

Hence all boxes are compact.

## Dealing with all possible closed bounded sets

We've dealt with the easiest kind of closed bounded sets. How can we transform any other closed bounded set into one of these? We can't do that necessarily - closed sets aren't necessarily unions of closed boxes - but what we can say is that all closed bounded sets are contained some closed box. (Indeed, all bounded sets are.) It would be great if a closed subset \\(C\\) of a compact set \\(X\\) were compact.

That's easy, though - if we have an open cover of \\(C\\), we can make an open cover of \\(X\\) by just adding \\(U = \mathbb{R}^n - C\\) to the cover. (That extra set is open, being the complement of a closed set.) Then this has a finite subcover, by compactness of \\(X\\); that subcover probably contains \\(U\\), but if it does, just throw it out and we've got a finite subcover of \\(C\\). Hence \\(C\\) is compact.

# Summary

We proved it as follows:

1.  Show the easier direction: assume not closed, make sequence tending to point not in set, define open cover such that no set individually gets close to that point; any finite subcover doesn't get close to that point, so the sequence can't be in the finite subcover. Assume not bounded, then use the nested balls centred on the origin.
2.  Do the easiest case of boxes, by taking an open cover with no finite subcover, repeatedly dividing up the box to get a sequence of nested boxes each with no finite subcover; there is a point in every box (by defining a sequence of points, one in each box, which must tend to a limit); that point is in some open set in the original cover, and eventually the boxes get small enough that a box is entirely contained within an open set - contradiction.
3.  Do the harder cases of boxes, by showing that a closed subset of a compact set is compact (by taking an open cover, extending it to a cover of the big set, and compactly taking a finite subcover, which turns back into a finite subcover of the small set).

 [1]: https://en.wikipedia.org/wiki/Heine-Borel_theorem "Heine-Borel theorem"
 [2]: {% post_url 2014-03-30-how-to-discover-the-contraction-mapping-theorem %}
