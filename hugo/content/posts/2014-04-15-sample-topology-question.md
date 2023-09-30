---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
- proof_discovery
comments: true
date: "2014-04-15T00:00:00Z"
math: true
aliases:
- /mathematical_summary/sample-topology-question/
- /sample-topology-question/
title: Sample topology question
---
As part of the recent series on how I approach maths problems, I give another one here (question 14 on the Maths Tripos IB 2007 paper 4). The question is:

> Show that a compact metric space has a countable dense subset.

This is intuitively clear if we go by our favourite examples of metric spaces (namely \\(\mathbb{R}^n\\), the discrete metric and the indiscrete metric). Indeed, in \\(\mathbb{R}^n\\), which isn't even compact, we have the rationals (so the theorem doesn't give a necessary condition, only a sufficient one); in the indiscrete metric, any singleton \\(\{x \}\\) is dense (since the only closed non-empty set is the whole space); in the discrete metric, where every set is open, we can't possibly be compact unless the space is finite, so that's why the theorem doesn't hold for a topology with so many sets.

However, there are some really weird metric spaces out there, and if there's one thing I've learnt about topology it's that intuition-by-examples is an extremely bad way to prove things, although it's often a good way to work out *how* to prove something.

Right. Our metric space could be really odd - it might be massively uncountable or something - so that means we're going to have to build our dense subset anew for each metric space. (It's like trying to find a good diet for your pet - the possible pets are so diverse that one diet won't fit all, so we have to find the right diet for each pet individually.) The "countable" bit can only come in from the rationals or naturals - it can't pop out of the metric space itself, because we have no idea how huge the metric space might be.

That's all I can come up with for meta-reasoning at the moment. Let's find an example to guide intuition. By far the simplest is \\([a,b] \subset \mathbb{R}\\), whose dense subset is \\(\mathbb{Q} \cap [a,b]\\).

My first thought is to make a dense subset by grabbing an arbitrary point \\(x\\) and then taking one point \\(x_p\\) such that \\(d(x_p, x) = p\\) for all rational \\(p\\). That definitely works for \\([a,b]\\), but actually it clearly fails in \\(\mathbb{R}^2\\) - what if we happened to pick our points so they all lay on the same line? They'd be dense along that line, but not anywhere else in the set. It's going to be a lot of work to fix this in \\(\mathbb{R}^2\\) without using special properties of \\(\mathbb{R}\\), so I'll abandon that line of thought.

Nothing obvious has come of the "density" part of the statement. Let's move on to the other bit - we know our metric space is compact (or, equivalently, that any open cover has a finite subcover). That means we're going to want to create an open cover. Because our metric space might be so odd, the only obvious cover to take is one consisting of a ball around every point. (Those balls might all be different sizes, of course.) That's the only way to make sure that we have actually included our entire space in the cover.

Compactness then gives us that there is a finite subcover of this cover of balls. That's not going to get us very far if we require a countable number of points, though. Where might we get a *point* rather than an open set (after all, compactness is all about sets, not points)? The only possible place is as the centre of some ball. Aha - we need to create a countable number of points, each of which lies at the centre of some ball. Equivalently, we want a countable number of balls.

OK, we can create hugely many balls to cover the set (wrap every point in a ball), and we can turn that into finitely many balls to cover the set (by compactness). How can we get countably many? Obviously not from the "hugely many" directly, because it might be very very uncountable - but we can make countable from finite, by taking a countable union. That is, we're going to need a countable union of {finitely many balls which cover the set}.

The simplest way I can create that countable union is to make every ball the same size (\\(\frac{1}{n}\\)), and use the cover \\(B_{\frac{1}{n}}\\) consisting of a \\(\frac{1}{n}\\)-ball around every point. We use compactness to turn that into \\(C_{\frac{1}{n}}\\) a collection of finitely many balls (which covers the entire space), and consider the union of all these \\(C_{\frac{1}{n}}\\).

This has given us a countable collection of points \\(\cup_{n \geq 1} \cup_{j = 1}^{i_n} P_{\frac{1}{n},j}\\) (namely, the centres of the balls; notationally, \\(P_{\frac{1}{n}, j}\\) refers to the centre of the \\(j\\)th element of \\(C_{\frac{1}{n}}\\)). Now, we want that set to be dense - we need the closure to be the entire space. What would it mean if the closure weren't the entire space? There would be a point which was in the space but not the closure.

At this point, I move back to the \\(\mathbb{R}^2\\) intuition-guide. I have drawn a mental picture of \\([0,1] \times [0,1]\\) with a countable collection of balls covering it, with a single point not in the closure of the set of centres. Aha, something is not right here - how can a point manage not to be in the closure of that set, unless it is outside the cover?

Suppose \\(x\\) does not lie in \\(\text{cl}(\cup_n P_{\frac{1}{n}})\\) - that is, \\(x\\) is outside the closure. Then \\(x\\) lies in an open set - namely the complement of the closure - so there is an open ball \\(B_{\epsilon}(x)\\) which lies outside the closure. I can feel that we're going to use \\(\frac{1}{n}\\)-ness at some point, because that's how we defined our cover, so let's make \\(\epsilon = \frac{1}{m}\\) for some \\(m\\) (which we can do - if our original \\(\epsilon\\) didn't work, make it smaller until it is the reciprocal of an integer).

Then we have a radius-\\(\frac{1}{m}\\) ball which doesn't lie inside the closure. That doesn't bode well for \\(C_{\frac{1}{m}}\\) being a cover, but it's just possible that the balls may sit next to each other in some way that makes it work (that's how vague my thoughts are, not just my incompetence at communication). For safety, let's consider \\(C_{\frac{1}{2m}}\\) instead.

Then we have \\(x \in B_{\frac{1}{2m}}(k)\\) for some \\(k \in P_{\frac{1}{2m}}\\), because \\(C_\frac{1}{2m}\\) was a cover so \\(x\\) does lie in a ball in that cover; pick \\(k\\) to be the cetntre of that ball. In particular, \\(k\\) lies at most \\(\frac{1}{2m}\\) away from \\(x\\), and \\(k\\) lies both in \\(B_{\frac{1}{m}}(x)\\) (which is not in the closure) and in \\(P\\) (which is in the closure). This is a contradiction - we've found a point which is both in and not in the closure.

Hence we must have the closure being the entire space, which means our countable collection of points is dense.

# Summary

I started off by thinking about the problem - working out roughly how I might be able to attack it, and deciding that it was too general for clever tricks to work. I then constructed an intuition-guide example, and worked off that, but decided that the line of attack suggested by my example would be very hard in general.

Having exhausted one of the parts of the theorem's statement, I moved to the other, and followed my nose. The problem was so general that there were only a few possible places we could acquire a countable collection of points; compactness suggested using balls around every point in the space, to get a finite cover of balls. From finite we can create countable by just taking a union, so I made the finite covers more formal (giving the balls a particular size) and took the union of all of them. That naturally gives a countable set of points (the centres of the balls); in the spirit of "do as little work as possible", I set out to prove that this set was dense. Assuming the contrary made it obvious from my intuition-picture that the set was indeed dense.
