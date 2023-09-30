---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
comments: true
date: "2013-08-26T00:00:00Z"
math: true
aliases:
- /wordpress/archives/364/index.html
- /mathematical_summary/topology-made-simple/
- /topology-made-simple/
title: Topology made simple
---
I've been learning some basic [topology][1] over the last couple of months, and it strikes me that there are some *very* confusing names for things. Here I present an approach that hopefully avoids confusing terminology.

We define a **topology** \\(\tau\\) on a set \\(X\\) to be a collection of sets such that: for every pair of sets \\(x,y \in \tau\\), we have that \\(x \cap y \in \tau\\); \\(\phi\\) the empty set and \\(X\\) are both in \\(\tau\\); for every \\(x \in \tau\\) we have that \\(x \subset X\\); and that \\(\displaystyle \cup_{\alpha} x_{\alpha}\\) is in \\(\tau\\) if all the \\(x_{\alpha}\\) are in \\(\tau\\). (That is: \\(\tau\\) contains the empty set and the entire set; sets in \\(\tau\\) are subsets of \\(X\\); not-necessarily-countable unions of sets in \\(\tau\\) are in \\(\tau\\); and finite intersections of sets in \\(\tau\\) are in \\(\tau\\).) We then say that \\((X, \tau)\\) is a **topological space**.

If a set \\(x\\) is in \\(\tau\\), then we say that \\(x\\) is **fibble**. On the other hand, if \\(x^{\mathsf{c}}\\) (the complement of \\(x\\)) is in \\(\tau\\), then we say that \\(x\\) is **gobble**.

We define a **metric space** \\((X,d)\\) to be a set \\(X\\) together with a "distance" function \\(d: X \to \mathbb{R}\\) such that: \\(d(x,y)=0\\) iff \\(x=y\\); \\(d(x,y)=d(y,x)\\); and \\(d(x,y)+d(y,z) \geq d(x,z)\\). (That is, "the distance between two points is 0 iff they're the same point; distance is the same if we reverse as if we go forward; and if we take a detour then the distance is greater".)

We then define a **fiball** \\(B(x,\delta )\\) to be "a set for which every \\(y \in X\\) is within \\(\delta\\) of \\(x\\)" - that is, \\(\{ y \in X: d(x,y)<\delta \}\\).

It turns out that we can create (or **induce**) a topology out of a metric space, by considering the fiballs. Let \\(x \in \tau\\) iff \\(x\\) is a union (not necessarily countable) of fiballs in the metric space. We can see that this is a topology, because unions of (things which are unions of fiballs) are unions of fiballs; the empty set is the union of no fiballs; the entire set \\(X\\) is the union of all possible fiballs; and it can be checked that intersections behave as required (although that takes a tiny bit of work).

Now we see why fiballs are called "fiballs" - because in the induced topology, fiballs are fibble.

We can define a **gobball** in the same way, by making the weak inequality strict in the definition of the fiball. And it can be verified that gobballs are gobble.

We can keep going with these definitions - a **continuous function** between two topological spaces \\(f: (X, \tau) \to (Y, \sigma)\\) is defined to be one such that if \\(y \subset Y\\) is fibble in \\(Y\\), then \\(f^{-1}(y)\\) is fibble in \\(X\\), and so forth.

Eventually we come to the reason that I've used the words "fibble" and "gobble". Consider the metric \\(d: \mathbb{R} \to \mathbb{R}\\) given by \\(d(x,y) = \vert x-y \vert\\). It can easily be checked that \\((\mathbb{R},d)\\) is a metric space, and so it induces a topology on \\(\mathbb{R}\\). What is the fiball \\(B(x,\delta)\\)? It is precisely the set of points which are within \\(\delta\\) of \\(x\\) - that is, the open interval \\((x-\delta, x+\delta)\\). So we know that open intervals are fibble. Note also that \\((1,2) \cup (3,4)\\) is fibble, but is not an open interval. All well and good.

But now consider a different topology on \\(\mathbb{R}\\). Let \\(x\\) be fibble if it is a union of half-open intervals \\([a,b)\\). It can be checked that this is a topology. Now the set \\([1,2) \cup [3,4)\\) is fibble, and note that it is not an open interval. We can see that \\((1,2)\\) is still fibble (it's the union of the fibble sets \\([x, 2)\\) for \\(1<x<1.1\\), for example).

And consider a third, final topology on\\(\mathbb{R}\\). Let \\(x\\) be fibble iff \\(x\\) is \\(\mathbb{R}\\) or the empty set. We can easily see that this is a topology. Now no open interval is fibble.

The problem is that in standard notation, fibble sets are referred to as **open**. It's all fine when you have that open intervals are open in the usual topology, but we can construct a topology in which there is an open set which is not an open interval, and we can construct a topology where no open intervals are open. What madness is this? Why not have a different word, because the meaning is different?!

When I am Master of the Universe, I will reform topology so that it makes sense.

 [1]: https://en.wikipedia.org/wiki/Topology "Topology Wikipedia page"
