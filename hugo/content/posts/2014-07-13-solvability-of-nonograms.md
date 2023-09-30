---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
comments: true
date: "2014-07-13T00:00:00Z"
math: true
aliases:
- /mathematical_summary/nonograms/
- /solvability-of-nonograms/
title: Solvability of nonograms
---
Recently, a friend re-introduced me to the joys of the [nonogram] (variously known as "hanjie" or "griddler"). I was first shown these about ten years ago, I think, because they appeared in [The Times]. When The Times stopped printing them, I forgot about them for a long time, until two years ago, or thereabouts, I tried these on [a website][griddlers.net]. I find the process much more satisfying on paper with a pencil than on computer, so I gave them up again and forgot about them again.

Anyway, the thought occurred to me: is a given griddler always solvable, and is it solvable uniquely? That is, given a grid and the edge entries, is it always a valid puzzle?

Notation: we will say that a given *solved grid* has an *edge-set* consisting of the numbers we would see if we were about to start solving the nonogram. We say that an edge-set *applies to* a solved grid if that edge-set is consistent with the solved grid. (For instance, the empty edge-set doesn't apply to any solved grid apart from the zero-size grid.)

Then our question has become: is there in some way a bijection between (edge-sets) and (solved grids)?

# Existence of edge-sets

We can trivially describe any solved grid by an edge-set and a grid size: simply write down the grid size of the solved grid, and write down the obvious edge-set. (We do need the grid size to be specified, because given an edge-set which applies to a solved grid, we can create a new grid to which that edge-set applies by simply appending a blank row to the solved grid.)

# Uniqueness of edge-sets

Is there an obvious reason why we could never have two different edge-sets applying to the same solved grid? It seems intuitively clear that a given solved grid can only have the obvious edge-set (namely, the one we get by writing down the blocks in each row and column in the obvious way). Is this rigorous as a proof? Yes: suppose that we had two edge-sets describing the same solved grid, and (wlog) the sets differ in the first row. In fact, let us wlog that our solved grid is only one row long.

* If one edge-set is empty, we're done: because the two edge-sets are not the same, that means the other edge-set is non-empty, and so under the first edge-set the solved grid is empty, while under the second the solved grid is nonempty.
* If both edge-sets are non-empty: suppose the first starts with the number \\(a\\), and the second with the number \\(b\\). Then we have some number of blank squares, and then \\(a\\) filled-in squares (by edge-set 1) and also \\(b\\) filled-in squares (by edge-set 2); hence \\(a=b\\), because our solved grid is fixed.

# Existence of solutions
Must a solution exist for a given grid size and edge-set? Is it possible to create a nonogram with no solution? One strategy for proving this might be to count the number of allowable edge-sets and to count the number of allowable solved grids (the latter problem is extremely easy if we consider a grid as being a binary number whose bits are laid out in a rectangle), because we have that any two finite sets of the same size must biject. However, the former problem sounds very hard.

On second thoughts (read: I slept on this), it's blindingly obvious that there is a grid with no solution - namely, the one-by-one grid with edge-set "1 as column heading, 0 as row heading". So there certainly are edge-sets which don't have a solution grid.

# Uniqueness of solutions
OK, if we don't always have solvability, how about the "easy puzzle-setting property": that a given edge-set and grid-size cannot have two solved grids to which the edge-set applies? If this were true, it would make generating puzzles extremely easy: simply draw out a solved grid, write down its edge-set (which is unique, as shown above), and set that edge-set and grid-size as the puzzle, without fear that someone could sit down and solve the puzzle validly to get a different grid to your solution.

On the same second thoughts as the 'existence of solutions' thoughts, it's clear that the 2-by-2 grid with a diagonal black stripe has two solutions - namely, send the stripe top-left to bottom-right, or top-right to bottom-left. Curses.

# Summary
Every solved grid has an edge-set, which is unique to that grid. However, not all edge-sets are solvable, and we don't have uniqueness of solutions. That was much less interesting than I had hoped.

[nonogram]: https://en.wikipedia.org/wiki/Nonogram
[griddlers.net]: https://www.griddlers.net/home
[The Times]: http://www.thetimes.co.uk/tto/news/
