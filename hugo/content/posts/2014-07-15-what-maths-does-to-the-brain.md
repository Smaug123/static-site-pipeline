---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- psychology
comments: true
date: "2014-07-15T00:00:00Z"
disqus: true
math: true
aliases:
- /psychology/what-maths-does-to-the-brain/
- /what-maths-does-to-the-brain/
title: What maths does to the brain
---

In my activities on [The Student Room], a student forum, someone (let's call em Entity, because I like that word) recently asked me about the following question.

>Isaac places some counters onto the squares of an 8 by 8 chessboard so that there is at most one counter in each of the 64 squares. Determine, with justiﬁcation, the maximum number that he can place without having ﬁve or more counters in the same row, or in the same column, or on either of the two long diagonals.

You might like to have a think about it before I give first the answer Entity gave, and my commentary on it.

I paraphrase Entity's answer:

>The maximum is 32, because the maximum along each row is 4 and so having 33 counters means having more than one row being full. Moreover, I have found a pattern which satisfies the 32 requirement. Hence we have shown that the correct answer is at most and at least 32, so it must be 32.

I'm going to assume that the 32-pattern is correct, because I wasn't shown the purported answer. What interested me was that my mind immediately pointed out internally that we have made an unproved claim. Again, you might like to think what the unproved claim might be - it's completely trivial to prove, but I found it fascinating. It'll come in the next paragraph.

The unproved claim is "having 33 counters means having more than one row being full". There are a couple of trivial proofs:

* \\(\frac{33}{64} > \frac{1}{2}\\) is the proportion of the board which is becountered, and the mean of eight quantities (the proportion of counters in each row) which are all less than or equal to a half cannot itself be greater than a half. Hence at least one of the eight quantities is greater than a half (that is, a row has more than four counters in).
* The [pigeonhole principle] gives the result directly in a similar way (33 pigeons into eight holes means one hole has more than four pigeons).

However, my mind flagged this claim automatically as something that wasn't necessarily obvious. It turned out to be trivial, but it is an example of a step which is in general not true. For instance:

> Consider the natural numbers (greater than 0). The set of even numbers takes up half the space. Now if we remove the number 2 from the set of even numbers, we have the collection still taking up half the space, but now it's a smaller set - it's missing an element. Conundrum.

Here, we used very similar reasoning ("removing something from a set makes it take up proportionally less space") but got nonsense, ultimately because the pigeonhole principle doesn't apply to infinite sets.

I think what I did here was recognise a general pattern, but I struggle to work out what that pattern might be. The closest I've come is "if one property of a structure holds, then an obviously related property of that structure holds", because I'm pretty sure my thought wasn't triggered by the need for the pigeonhole principle. (In that case, the pattern would have been "if we fill up some slots, then some subset of the slots must be full", which is much more specific and trivial than I feel my reaction was. It felt like a specific instance of a very general check.)

A similar pattern which is much more concrete is the distinction between "if" and "only if" and "if and only if". A mathematician trains emself early on to not get confused between these. It doesn't take too long before you simply stop having the mental architecture that lets you make a mistake like "all odd squares are squares of odd numbers. Indeed, if n is odd then n^2 is odd. QED" unless the structures you're working with are quite a bit more complicated. Of course, my mental checks can be overwhelmed by complexity, and I have certainly proved the wrong direction of a problem many times, but in everyday conversation and in simpler mathematical problems, it becomes not only easy but automatic to distinguish between "implies" and "is implied by".

It feels vaguely similar to some of the filters I've installed in myself for other reasons. For instance, earlier today I was asked which of five leaflets looked best. I had already seen one of them before, and my first reaction (before any other) was "I've seen this one before, so I'm likely to think it looks better". I have a few anti-bias systems like these, and I have no idea whether they're useful or not, but I can certainly feel them going sometimes, without any input from myself.


[The Student Room]: http://www.thestudentroom.co.uk
[pigeonhole principle]: https://en.wikipedia.org/wiki/Pigeonhole_principle
