---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
- proof_discovery
comments: true
date: "2014-04-26T00:00:00Z"
math: true
aliases:
- /mathematical_summary/proof_discovery/sequentially-compact-iff-compact/
- /sequentially-compact-iff-compact/
title: Sequentially compact iff compact
---
[Prof Körner][1] told us during the [IB Metric and Topological Spaces][2] course that the real meat of the course (indeed, its hardest theorem) was "a metric space is sequentially compact iff it is compact". At the moment, all I remember of this result is that one direction requires Lebesgue's lemma (whose statement I don't remember) and that the other direction is quite easy. I'm going to try and discover a proof - I'll be honest when I have to look things up.

# Easy direction

I don't remember which direction was the easy one. However, I do know that in Analysis we prove very early on that closed intervals are sequentially compact (that is, they have the Bolzano-Weierstrass theorem), so I'm going to guess that that's the easy direction.

## Thought process

Suppose the space is compact. (Then for every open cover there is a finite subcover.) We want to show that every sequence has a convergent subsequence, so of course we'll try a proof by contradiction, because the statement is so general.

Suppose the sequence \\(x_n\\) has no convergent subsequence. That is, no subsequence of \\(x_n\\) converges to \\(y\\), for any \\(y\\). We're aiming for some kind of open cover, and we're in a very general kind of metric space, so we're going to have to generate our cover by considering balls around every point.

What does it mean for every subsequence of \\(x_n\\) not to converge to \\(y\\)? It means that for every ball around \\(y\\), and for every subsequence, we can find arbitrarily many \\(x_n\\) in the subsequence such that \\(x_n\\) is outside that ball. My first thought is that we've made a sequence which might be useful - the \\(x_n\\) outside balls of radius \\(\delta_i\\) for \\(i = \frac{1}{m}\\) - but it's not obvious whether that will in fact be useful, because all we know about this sequence is that it doesn't get near a particular point.

OK, let's look at the "for every \\(y\\)" bit, because that's bound to be where our cover comes from. We're going to want a ball around each \\(y\\), so let's say the ball is of radius \\(\delta_y\\). (We'll delay stating what \\(\delta_y\\) actually is in value, because I have no idea what it's going to be.) Ah, then we know that for every subsequence, there are infinitely many \\(x_i\\) which lie outside the ball \\(B(y, \delta_y)\\).

What does our finite subcover look like? It's a finite collection (say, \\(k\\) many) of balls, and we know that there are infinitely many \\(x_i\\) in any subsequence such that the \\(x_i\\) are outside a given one of those balls. But this is a contradiction: take the subsequence of \\(x_n\\) such that all of the \\(x_i\\) in the subsequence lie outside ball 1. Then take a subsequence of that such that all the elements lie outside ball 2. Repeat: eventually we end up with a subsequence of \\(x_n\\) such that all the elements lie in ball \\(k\\). This subsequence converges.

## Proof

Suppose \\((X,d)\\) is a compact metric space, and take a sequence \\(x_n\\) in \\(X\\). We show that there exists \\(y \in X\\) such that there is a subsequence \\(z_i\\) of the \\(x_n\\) such that \\(z_i \to y\\).

Indeed, if the sequence \\(x_n\\) gets arbitrarily close to \\(y\\) then there is a subsequence of \\(x_n\\) tending to \\(y\\) (namely, let \\(\epsilon_m = \frac{1}{m}\\); then pick \\(x_{n_m}\\) such that \\(d(x_{n_m}, y) < \epsilon_m\\)), so it is enough to show that there is some \\(y\\) such that the sequence \\(x_n\\) gets arbitrarily close to \\(y\\).

We show that this is true. Indeed, suppose not. Then for all \\(y\\) there exists \\(\delta_y\\) such that \\(x_n\\) never gets within \\(\delta_y\\) of \\(y\\) (for all \\(n > N\\), some \\(N\\) - the sequence might have started at \\(y\\), but we know it never returns after some point). Take a cover consisting of those \\(B(y, \delta_y)\\); by compactness, there is a finite subcover.

Now, we have that for the \\(i\\)th ball in the cover, there exists \\(N_i\\) such that \\(x_n\\) never gets into the \\(i\\)th ball for \\(n > N_i\\); but there are only finitely many balls, so \\(x_n\\) never gets into any of the balls for \\(n > N = \text{max}(N_i)\\). But the finite collection of balls is a cover. That is, no \\(x_n\\) is in \\(X\\), for \\(n > N\\) - contradiction.

## Postscript

That did indeed turn out to be the easier direction, then.

# Hard direction

I'm not even going to begin attempting to find out what Lebesgue's lemma is on my own, so I'll just look it up and state it.

> For a sequentially compact metric space \\((X, d)\\), and an open cover \\(U_{\alpha}\\), we have that there exists \\(\delta\\) such that for all \\(x \in X\\), there exists \\(\alpha_x\\) such that \\(B(x, \delta) \subset U_{\alpha_x}\\).

That is, "given any open cover, we can find a ball-width such that for every point, a ball of that width lies entirely in some set in the cover". It feels kind of related to Hausdorffness - while "metric spaces are Hausdorff" guarantees that we can wrap distinct points in non-overlapping balls, Lebesgue's lemma tells us that if our distinct points are not covered by the same set then we can separate them while remaining in those different sets in the cover.

OK, let's go for a proof of this.

## Proving Lebesgue's lemma

Well, where can we start? To actually produce such a \\(\delta\\), it looks like we'd need to take some kind of minimum, and that would require a finite cover (which is assuming compactness). So that's not a good place to start.

If we don't know where to start, we contradict. Suppose there is no \\(\delta\\) such that for all \\(x \in X\\) there exists \\(\alpha_x\\) such that \\(B(x, \delta) \subset U_{\alpha}\\). That is, for every \\(\delta\\) there exists \\(x \in X\\) such that for all open sets in the cover, \\(B(x, \delta) \not \subset U_{\alpha}\\).

We're in a sequentially compact space - we need a sequence, so that it can have a convergent subsequence. Mindlessly (nearly literally - I'm exhausted at the moment, having had an unusually long supervision since proving the easier direction), I'll take \\(\delta_n = \frac{1}{n}\\) and create a sequence \\(x_n\\) such that \\(B(x_n, \frac{1}{n})\\) is not wholly contained in any set of the cover. Then the \\(x_n\\) has a convergent subsequence \\(x_{n_i} \to x\\), say.

Picture pause. We've got our \\(x_{n_i}\\) tending to \\(x\\), with ever-decreasing balls around them. It seems sensible that at some point (since the position of the balls, the centre \\(x_{n_i}\\), is hardly changing, while the radius is getting smaller) the balls will get so small that they start being contained in some cover-set.

That's actually so close to a proof that I'll write it up formally from this point.

### Proof

Let \\((X, d)\\) be a sequentially compact metric space, and let \\(U_\alpha\\) be a cover (ranging \\(\alpha\\) over some indexing set). Assume for contradiction that for every \\(\delta\\) there exists \\(x \in X\\) such that for all \\(\alpha\\), \\(B(x, \delta) \not \subset U_{\alpha}\\).

Specialise to the sequence \\(\delta_n = \frac{1}{n}\\), and let \\(x_n\\) be the corresponding \\(x \in X\\). Then by sequential compactness, there exists a subsequence \\(x_{n_i}\\) tending to some \\(x\\).

Now, \\(B(x_{n_i}, \frac{1}{n_i}) \not \subset U_{\alpha}\\) for any \\(\alpha\\). Also, because each \\(U_{\alpha}\\) is open, we have that for every \\(\alpha\\) such that \\(x \in U_{\alpha}\\) there exists \\(\epsilon_{\alpha}\\) such that \\(B(x, \epsilon_{\alpha})\\) is wholly contained within \\(U_{\alpha}\\).

Fix some \\(\alpha\\) such that \\(x \in U_{\alpha}\\), and let \\(\epsilon = \epsilon_{\alpha}\\). Take \\(n_i\\) such that \\(d(x_{n_i}, x) < \frac{\epsilon}{2}\\) (possible, because \\(x_{n_i} \to x\\)). We have \\(B(x_{n_i}, \frac{1}{n_i})\\) entirely contained in \\(B(x, \epsilon)\\), because any point in the former ball is at most \\(\frac{1}{n_i}\\) away from \\(x_{n_i}\\), which is itself at most \\(\frac{\epsilon}{2}\\) away from \\(x\\); hence any point in \\(B(x_{n_i}, \frac{1}{n_i})\\) is at most \\(\frac{1}{n_i} +\frac{\epsilon}{2}\\) away from \\(x\\). Picking \\(n_i > \frac{2}{\epsilon}\\) (as well as such that \\(d(x_{n_i}, x) < \frac{\epsilon}{2}\\)) ensures that \\(\frac{1}{n_i} +\frac{\epsilon}{2} < \epsilon\\).

But this is a contradiction: we have a ball entirely contained in some \\(U_{\alpha}\\) - namely \\(B(x, \epsilon)\\) - which contains a ball which is not entirely contained in \\(U_{\alpha}\\) - namely \\(B(x_{n_i}, \frac{1}{n_i})\\).

## Proving the main theorem

OK, what do we have? We have that any open cover of a sequentially compact space allows us to draw a ball of *predetermined width* around each point, such that every ball is contained entirely in a set from the cover.

What do we want? We want every open cover of a sequentially compact space to have a finite subcover. [^when]

OK, let's do the only possible thing and take an open cover of a sequentially compact space. We might be able to build a finite subcover because of our predetermined-width balls, but I want a picture first.

### Pictures (feel free to skip)

Let's use \\([0, 1]\\) and the cover \\([0, \frac{1}{5}), (\frac{1}{n+2}, \frac{1}{n}), (\frac13, 1]\\) where \\(n \geq 2\\), and let's suppose \\(\delta = \frac17\\). (This clearly works as a \\(\delta\\) in Lebesgue's lemma.) Then a \\(\frac17\\)-ball around any point remains in some set of the cover. The reason we have a finite subcover in this case is that the sets in the cover get smaller, so eventually we can just discard the ones which are too small to contain a \\(\frac17\\)-ball. It turns out that wasn't a great intuition guide - metric spaces can be a lot odder than that.

We want a space where the "balls get smaller" argument fails. Let's use \\(\mathbb{R} \cup \{ \infty \}\\) under the usual metric, and the cover \\((n-\frac34, n+\frac34)\\) along with some ball around \\(\infty\\). The reason this one works is because the ball around infinity makes sure we can throw out most of the sets of the cover, because they are contained in the ball around infinity. (A suitable \\(\delta\\) is \\(\frac14\\).)

### End of pictures

Hmm, I don't think I can easily come up with an example which explains exactly why the theorem is true. I slept on this, and got no further, so I looked up the next step: assume that it is not possible to cover the space with a finite number of \\(B(x_i, \delta)\\). (This should perhaps have been suggested to me by my finite examples, in hindsight.) It turns out that this step makes it really easy.

Then for all finite sequences \\((x_i)_{i=1}^n\\), there is a point \\(x_{n+1}\\) such that \\(x_{n+1}\\) is not in the cover; this forms a sequence which must have a convergent subsequence. Because the covering-balls are all of fixed width \\(\delta\\), we must have that eventually the points in the subsequence draw together enough to sit in the same ball.

## Proof

Suppose \\((X, d)\\) is a sequentially compact metric space which is not compact, and fix an arbitrary open cover \\(U_{\alpha}\\) such that there is no finite subcover. Then by Lebesgue's lemma, there is \\(\delta\\) such that for all \\(x \in X\\), there is \\(\alpha_x\\) such that \\(B(x, \delta) \subset U_{\alpha}\\).

Now, if it were possible to cover \\(X\\) with a finite number of \\(B(x_i, \delta)\\) then we would have a finite subcover (namely, \\(U_{\alpha_{x_i}}\\) for each \\(i\\)). Hence it is impossible to cover \\(X\\) with a finite number of \\(B(x_i, \delta)\\). Take a sequence \\((x_n)_{n=1}^{\infty}\\) such that \\(x_i\\) does not lie in any \\(B(x_j, \delta)\\) for \\(j < i\\) (and where \\(x_1\\) is arbitrary). Then there is a convergent subsequence \\(x_{n_i} \to x\\), say; wlog let \\(n_i = i\\), for ease of notation (so the original sequence converged).

But this contradicts the requirement that \\(x_i\\) always lies outside \\(B(x_j, \delta)\\) for \\(j < i\\): indeed, \\(d(x_i, x_j) < \delta\\) for sufficiently large \\(i, j\\), since convergent sequences are Cauchy.

Hence \\((X, d)\\) is compact.

# Postscript

Ouch, that took a long time. There were three key ideas I ended up using.

1.  One direction is so easy that it's one of the first theorems we prove in Analysis.
2.  Lebesgue's lemma.
3.  Contradict ALL the things. (Every single major step in either direction of the proof is a contradiction, and everything just falls out.)

[^when]: When do we want it? Now!

 [1]: https://en.wikipedia.org/wiki/Tom_Körner "Prof Körner Wikipedia page"
 [2]: https://www.dpmms.cam.ac.uk/study/IB/MetricTopologicalSpaces/ "Met+Top"
