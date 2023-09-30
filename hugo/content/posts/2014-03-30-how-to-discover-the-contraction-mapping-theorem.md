---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
- proof_discovery
comments: true
date: "2014-03-30T00:00:00Z"
math: true
aliases:
- /mathematical_summary/proof_discovery/how-to-discover-the-contraction-mapping-theorem/
- /how-to-discover-the-contraction-mapping-theorem/
title: How to discover the Contraction Mapping Theorem
---
A little while ago I set myself the exercise of stating and proving the [Contraction Mapping Theorem][1]. It turned out that I mis-stated it in three different aspects ("contraction", "non-empty" and "complete"), but I was able to correct the statement because there were several points in the proof where it was very natural to do a certain thing (and where that thing turned out to rely on a correct statement of the theorem).

Here, then, is how you might go about discovering it from the point of having a definition of a [Lipschitz function][2] on a metric space \\((X, d)\\) (that is, a function \\(f\\) for which there exists \\(\lambda \in \mathbb{R}^{>0}\\) such that for all \\(x, y \in X\\), \\(d(f(x),f(y)) \leq \lambda d(x,y)\\)). We'll aim for a statement describing the fixed points of such a function.

## Define the terms

What is a "fixed point"? There's nowhere obvious to start other than working out what we mean by one of these. Well, what we mean is "a point \\(x \in X\\) such that \\(f(x) = x\\)". We'll also define \\((X, d)\\) to be an arbitrary metric space, and \\(f\\) an arbitrary Lipschitz function on that space with Lipschitz constant \\(\lambda\\).

## How might we proceed?

We're looking for a fixed point. We have a Lipschitz function (that is, one which "draws points together", in the sense that two points which are originally \\(\delta\\) apart end up \\(\lambda \delta\\) apart, or closer, after \\(f\\) is applied to them). That suggests the idea of starting out with two arbitrary points, repeatedly pulling them closer together with \\(f\\), and seeing where we end up. Actually, on second thoughts, we can dispense with one of the arbitrary points, because we can make another point given our arbitrary \\(x\\) - namely \\(f(x)\\).

## What did we assume?

So far, we've made a (silly) assumption: that the space \\(X\\) is not empty, because we've just picked a point in it. In order to use this "\\(f\\) draws points together", we're going to want \\(\lambda < 1\\), otherwise it's actually blowing them outwards.

## How might we proceed?

We have two points, \\(x\\) and \\(f(x)\\). We want to pull them together using \\(f\\), so it's natural to keep applying \\(f\\) to them. So that we can have access to all these values, we'll define a sequence \\(z_i = f(z_{i-1})\\) and \\(z_0 = x\\). What we really want is for this sequence to converge to the fixed point (after all, if we're drawing the points together to some limit, we'd imagine that the limit of the sequence is a local accumulator in some sense).

Now, we know nothing about this metric space, and we know nothing about the limit of the sequence. There's a key thing we do in analysis if we want a limit of a sequence but know nothing about it: we show that it is [Cauchy][3]. In order to use this, though, we'll need to suppose that the metric space is complete (so that Cauchy sequences converge).

Then we want to show that this sequence \\(z_i\\) is Cauchy. That is, we want \\(d(z_i,z_j) \to 0\\) as \\(i,j \to \infty\\) independently of each other, which means that for all \\(\epsilon > 0\\) there exists \\(N \in \mathbb{N}\\) such that for all \\(i, j > N\\), \\(d(f^i(x), f^j(x)) < \epsilon\\).

Aha - we have \\(d(f^i(z), f^j(z))\\). We know \\(f\\) is Lipschitz, so ([wlog][4] \\(i \leq j\\)) this is \\(d(f^i(z), f^j(z)) \leq \lambda^i d(x, f^{j-i}(x))\\). It would be very convenient if the \\(d\\) expression were bounded, because then as \\(i \to \infty\\), the \\(\lambda^i\\) will take care of the rest (since \\(\lambda < 1\\)).

But what else do we know about \\(d\\)? We're going to need something to bound \\(d(x, f^{j-i}(x))\\), but we don't know anything about this expression - we only know about \\(d(z_i, f(z_i)) \leq \lambda d(z_{i-1}, z_i)\\), by the Lipschitzness of \\(f\\). But in fact we can make \\(d(x, f^{j-i}(x))\\) in terms of those: \\(d\\) is a metric, which means that it obeys the triangle inequality.

Hence \\(\displaystyle d(x, f^{j-i}(x)) \leq d(x, f(x)) + d(f(x), f^{j-i}(x)) \leq \dots \leq \sum_{k=1}^{j-i} d(z_{k-1}, z_k)\\). This we can bound: it's \\(\displaystyle \leq \sum_{k=1}^{j-i} \lambda^{k-1} d(z_0, z_1) = d(z_0, z_1) \sum_{k=1}^{j-i} \lambda^{k-1}\\). And, joy of joys, this sum is bounded, because the infinite sum \\(\displaystyle \sum_{k=1}^{\infty} \lambda^{k-1} = \dfrac{1}{1-\lambda}\\).

Hence \\(d(z_i, z_j) < \lambda^i d(z_0, z_1) \dfrac{1}{1-\lambda}\\). This goes to \\(0\\) as \\(i \to \infty\\), so the sequence \\(z_i\\) is Cauchy.

## What did we assume?

In this section, we assumed that the space was complete.

## Summary

So far, we have shown that the sequence \\(f^i(x)\\) is Cauchy, so it converges to a limit. We'll call the limit \\(L\\): so we have \\(f^i(x) \to L\\) as \\(i \to \infty\\).

## What next?

It feels like we're very close to a result now. What we really want is for \\(L\\) to be a fixed point: we need \\(f(L) = L\\). Equivalently, we need \\(f(\lim z_i) \to \lim z_i\\); but \\(z_i = f(z_{i-1})\\), so this is \\(f(\lim z_i) \to \lim f(z_i)\\). This will be trivial if \\(f\\) is continuous. But \\(f\\) is Lipschitz, so it is uniformly continuous and hence continuous (this is a really simple lemma).

That is, \\(L\\) is a fixed point of \\(f\\): we have proved that \\(f\\) has a fixed point.

## Extension

But we don't have to stop there - if we're drawing points together using \\(f\\), and we end up at a fixed point, surely there can't be two fixed points (since if there were, \\(f\\) would draw them together). Let's aim to prove that \\(f\\)'s fixed point is unique, by supposing that \\(L_1, L_2\\) are fixed points. Then \\(d(L_1, L_2) = d(f(L_1), f(L_2))\\), because \\(L_1, L_2\\) are fixed points, and then \\(d(f(L_1), f(L_2)) \leq \lambda d(L_1, L_2) < d(L_1, L_2)\\), contradiction.

## Summary

We have shown that there exists a unique fixed point \\(L\\) of a Lipschitz function \\(f\\) with Lipschitz constant \\(\lambda < 1\\) on a non-empty complete metric space. Moreover, we have shown that \\(f^(i)(x) \to L\\) for all \\(x\\), because we can perform this same construction of \\(z_i\\) starting from any point \\(x\\). Even more, we have shown that convergence is geometrically fast (by the \\(\lambda^i\\) term). This is a really strong theorem, and all I needed to remember in order to construct it was that Lipschitz functions were important and that we were looking for information about fixed points. (I didn't look up anything during the proof - I checked my statement of it afterwards, and it turned out to be correct. I didn't change anything after I finished it.)

 [1]: https://en.wikipedia.org/wiki/Contraction_mapping_theorem "Contraction Mapping Theorem Wikipedia page"
 [2]: https://en.wikipedia.org/wiki/Lipschitz_function "Lipschitz function Wikipedia page"
 [3]: https://en.wikipedia.org/wiki/Cauchy_sequence "Cauchy sequence Wikipedia page"
 [4]: https://en.wikipedia.org/wiki/Wlog "Wlog Wikipedia page"
