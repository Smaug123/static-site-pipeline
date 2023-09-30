---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- hacker-news
- mathematical_summary
comments: true
date: "2020-08-02T00:00:00Z"
title: The uncountability of the reals (a note from Hacker News)
summary: "A quick note from Hacker News about a beautiful proof of the uncountability of the reals."
---

[My barely-related response](https://news.ycombinator.com/item?id=24030441) to a [linkpost](https://news.ycombinator.com/item?id=24029791) on Hacker News to [a paper by Chaitin](https://arxiv.org/abs/math/0411418).

The link is now https://web.archive.org/web/20120915113514/http://people.math.gatech.edu/~mbaker/pdf/mmrealgame.pdf .

> I know it's completely unrelated to the article, but I would like to take a moment to plug an absolutely beautiful proof of the uncountability of [0,1], which I first saw in `http://people.math.gatech.edu/~mbaker/pdf/realgame.pdf` .

> Briefly: Alice and Bob play a game. Alice starts at 0, Bob starts at 1, and they alternate taking turns (starting with Alice), each picking a number between Alice and Bob's current numbers. (So start with A:0, B:1, then A:0.5, B:0.75, A:0.6, … is an example of the start of a valid sequence of plays.) We fix a subset S of [0,1] in advance, and Alice will win if at the end of all time the sequence of numbers she has picked converges to a number in S; Bob wins otherwise. (Alice's sequence does converge: it's increasing and bounded above by 1.)
>
> It's obvious that if S = [0,1] then Alice wins no matter what strategy either of them uses: a convergent sequence drawn from [0,1] must converge to something in [0,1].
>
> Also, if S = (s1, s2, …) is countable then Bob has a winning strategy: at move n, pick s_n if possible, and otherwise make any legal move. (Think for a couple of minutes to see why this is true: if Bob couldn't pick s_n at time n, then either Alice has already picked a number bigger, in which case she can't ever get back down near s_n again, or Bob has already picked a number b which is smaller, in which case she is blocked off from reaching s_n because she can't get past b.)
>
> So if [0,1] is countable then Alice must win no matter what either of them does, but Bob has a winning strategy; contradiction.
