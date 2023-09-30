---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
comments: true
date: "2015-11-28T00:00:00Z"
math: true
aliases:
- /mathematical_summary/my-first-forcing/
- /my-first-forcing/
title: My First Forcing
summary:
    In the Part III Topics in Set Theory course, we have used forcing to show the consistency of the Continuum Hypothesis, and we are about to show the consistency of its negation. I don't really grok forcing at the moment, so I thought I would go through an example.
---

In the Part III Topics in Set Theory course, we have used [forcing] to show the consistency of the [Continuum Hypothesis][CH], and we are about to show the consistency of its negation. I don't really grok forcing at the moment, so I thought I would go through an example.

A forcing is just a quasiorder, so I'll pick a nice one: \\(\mathbb{N}\\), with the usual order. Let's go through some terminology: condition \\(p \in \mathbb{N}\\) is stronger than condition \\(q \in \mathbb{N}\\) (according to my course's convention) iff \\(q \leq p\\). All conditions are compatible, because for every pair of conditions there is a condition stronger than both of them.

The dense subsets of this forcing are precisely the unbounded ones: that is, the infinite ones.

The directed subsets are precisely all subsets, because there is always a natural bigger-than-or-equal-to any two specified naturals. The downward-closed subsets are the initial segments.

The generic set existence theorem is in this case satisfied trivially by \\(G = \mathbb{N}\\), which is generic relative to any collection of dense subsets, and which contains any specified element.

The sets which are \\(\mathbb{P}\\)-generic over \\(\mathbb{M}\\) (any model which contains \\(\mathbb{N}\\)) are those initial segments of \\(\mathbb{N}\\) which intersect every dense set: that is, the only \\(\mathbb{P}\\)-generic set over \\(\mathbb{M}\\) is \\(\mathbb{N}\\) itself.

\\(\mathbb{P}\\) is not separative, because it's total so every pair of elements is compatible. That means our forcing isn't guaranteed to add any elements. Let's plough on anyway.

What are the \\(\mathbb{P}\\)-names of rank \\(0\\)? The empty set is the only such name.

What are the \\(\mathbb{P}\\)-names of rank \\(1\\)? They are all of the form \\(\tau = \{ (n_i, \sigma_i) : n_i \in \mathbb{N}, \sigma_i = \emptyset, i < i_0 \in \text{Ord} \}\\): that is, \\(\{ (n_i, \emptyset): n_i \in \mathbb{N} \}\\). Hence the \\(\mathbb{P}\\)-names of rank \\(1\\) are in one-to-one correspondence with the subsets of \\(\mathbb{N}\\), and subset \\(N\\) is taken to \\(\{ (n, \emptyset) : n \in N \}\\).

What are the \\(\mathbb{P}\\)-names of rank \\(2\\)? They are of the form \\(\tau = \{ (n_i, \sigma_i): n_i \in \mathbb{N}, (\sigma_i = \emptyset) \vee (\sigma_i = N \subseteq \mathbb{N}) \}\\), where I'm abusing notation and identifying the subset of \\(\mathbb{N}\\) with its corresponding \\(\mathbb{P}\\)-name of rank \\(1\\). (This isn't a horrible abuse, because \\(\emptyset\\) means the same thing in the two contexts.) That is, it's basically an arbitrary relation between naturals and subsets of naturals.

The ones of rank \\(3\\), after some mental gymnastics, turn out effectively to be arbitrary relations between pairs of naturals and subsets of naturals; and those of rank \\(n\\) are arbitrary relations between \\(n-1\\)-tuples of naturals and subsets of naturals.

The ones of rank \\(\omega\\) look like being relations between \\(\omega\\)-indexed tuples of naturals and subsets of naturals, and so on. I'm willing to proceed on the assumption that they are.

On to the interpretation. We can interpret with respect to any set \\(G \subseteq \mathbb{N}\\), although most of our theorems only really talk about when \\(G\\) is \\(\mathbb{P}\\)-generic: that is, when it is \\(\mathbb{N}\\) itself.

The interpretation of anything of rank \\(0\\) is, of course, the empty set. If we take anything of rank \\(1\\) - that is, a subset of the naturals - its interpretation is either the empty set (if \\(G\\) doesn't intersect the subset) or the set containing the empty set (if \\(G\\) does intersect the subset).

Let \\(\sim\\) be a relation between the naturals and subsets of the naturals: that is, a name of rank \\(2\\). Then the interpretation is \\(\{ \sigma_G: (\exists p \in G: p \sim \sigma) \}\\). That is, for everything in \\(G\\), take everything it twiddles, and interpret that (producing the empty set if \\(G\\) doesn't intersect the twiddled thing, or \\(\{ \emptyset \}\\) if it does). Hence we produce the empty set if nothing in \\(G\\) twiddles anything; we get \\(\{ \emptyset \}\\) if everything in \\(G\\) only twiddles things which intersect \\(G\\); and \\(\{ \{ \emptyset \}, \emptyset \}\\) if {something in \\(G\\) twiddles something which intersects \\(G\\), and something in \\(G\\) twiddles something which is disjoint from \\(G\\)}.

Repeating, it looks like we're building the ordinals, and with the right choice of \\(\mathbb{P}\\)-name, we'll get every ordinal for most choices of \\(G\\) (including the only generic one, \\(\mathbb{N}\\)).

I'm struggling to think why the entire class of ordinals isn't in this extension. If we started from a countable transitive model, there's a theorem which says that not only have we gained no new ordinals, but we still remain countable. So perhaps we've only actually generated the ordinals up to the Hartogs ordinal of the CTM (that is, \\(\omega_1\\)).

Let's move into \\(\mathbb{M}\\). As far as \\(\mathbb{M}\\) is concerned, we've just verified the existence of the von Neumann hierarchy (that is, we can show that every subset of every ordinal is present as an interpretation), so our forcing hasn't added anything at all. Aha, I've got it! Every \\(\mathbb{P}\\)-name lives in \\(\mathbb{M}\\), and so there are only countably many of those, but \\(\mathbb{M}\\) thinks that lots of those \\(\mathbb{P}\\)-names are different, though they are actually (from our outside, $V$, perspective) the same. \\(\mathbb{M}\\) doesn't have enough power to show they're the same. Therefore, from \\(\mathbb{M}\\)'s point of view, every ordinal really does exist. The previous paragraph was all backwards: our interpretations contain every ordinal because \\(\mathbb{M}\\) thinks there is every ordinal represented among the \\(\mathbb{P}\\)-names, even though to us with the super-strong large cardinal axiom that "the CTM isn't everything" fundamentally is, there's only countably many of those names.

Are there indeed countably many of those names, to us in \\(V\\)? There must be, because we're in a CTM. Indeed, if we go up to \\(\alpha = \omega_1\\), we are attempting to talk about \\(V\\)-uncountable families of elements drawn from this countable model, so actually there aren't any \\(\mathbb{P}\\)-names of rank \\(\omega_1\\).

OK. The above all goes to show that if we force our CTM by \\(\mathbb{N}\\), we don't get anything new. (And this doesn't contradict our theorem that if \\(\mathbb{P}\\) is separative, then we do get something new, because \\(\mathbb{N}\\) is not separative.) Hooray! I feel like I've just cast my first spell with a shiny new magic wand, examined what the spell did, and discovered that it did nothing more than check that magic was still working today.

Next time, I'll try a separative forcing, so I'm guaranteed something new.

[forcing]: https://en.wikipedia.org/wiki/Forcing_(mathematics)
[CH]: https://en.wikipedia.org/wiki/Continuum_hypothesis
[quasiorder]: https://en.wikipedia.org/wiki/Preorder
