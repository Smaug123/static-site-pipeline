---
lastmod: "2023-10-18T20:36:00.0000000+01:00"
author: patrick
categories:
- programming
date: "2023-10-18T20:36:00.0000000+01:00"
title: Squashed stacked PRs workflow
summary: "How to handle stacked pull requests in a repository which requires squashing all history on merge."
---

Recall that the "stacked PRs" Git workflow deals with a set of changes (say `C` depends on `B`, which itself depends on `A`), each dependent on the last, and all going into some base branch which I'll call `main` for the sake of this note.
The workflow represents this set of changes as a collection of pull requests: `A` into `main`, `B` into `A`, and `C` into `B`.

# Problem statement

The stacked PRs workflow is fine as long as we *merge* each pull request into its target, because then Git's standard merge algorithms are "sufficiently associative" that the sequence of merges tends to do the right thing.
(Of course, Git's standard merge algorithms are not associative; see [the Pijul manual](https://pijul.org/manual/why_pijul.html) for concrete examples and discussion of why this is inherently true.)

But if we *squash* each pull request into its target, then the only way we can merge the entire stack is to merge `C` into `B`, then `B+C` into `A`, then `A+B+C` into `main`.
Any other order, and the rewrite of history in the squash causes the computed merge base of our source and target to be very different from what we actually know it is, and this almost always causes the merge to become wildly conflicted.

For example, if we squash-merge `A` into `main` (which for the sake of argument should be a fast-forward merge, except that we've squashed), then we construct a new commit `squash(A)` whose tree is the same as `A` and which has the parent `main`; then we set `main` to point to `squash(A)`.
The merge base of `B` with `squash(A)` would be simply `A` if we hadn't squashed, but `A` is no longer in the history of `squash(A)`, so the merge base is actually `main^` (i.e. `main` as it was before the squash-merge); and the merge of `squash(A)` and `B` with a base of `main^` is liable to be gruesome.
So we can't cleanly merge `B` into `main = squash(A)`.

The clean problem statement, then, is:

> How do I squash-merge the stack in the order `A -> main`, `B -> main + A`, `C -> main + A + B`, without having to resolve conflicts at each step?

# Solution

Since we're squashing into `main` anyway, we should feel free to make a complete mess of history on our branches.

* Squash-merge `A` into `main`.
* Merge into `B` the `A` commit that's immediately before the squash into `main`. (This should be clean unless you made changes to `A` which genuinely conflicted with `B`, so this is work you should really have done in preparation for the review of `B` anyway.)
* Fetch `origin/main` locally, and merge into `B` the `main` commit that's immediately before the squash of `A`. (This should be clean if you've been hygienically keeping your branches up to date with `main` by merging `main -> A`, `A -> B`, `B -> C`. If it's not clean, again this is work that you would have to do anyway even in a non-squashing world.)

Now `B` is up to date both with `main` and `A` as of immediately before `A` was squashed into `main`, so it should be the case that merging `main + A` into `B` would be a no-op: it should not change the tree of `B`.
However, we aren't merging `main + A`.
We're instead merging the squashed `main + squash(A)` for some single commit `squash(A)` which Git thinks is completely unrelated to `A`, but which in fact has the same *tree* as `A`.

So the last step is:

* Merge the squashed `main + squash(A)` commit into `B` with the `ours` strategy: `git merge $COMMIT_HASH --strategy=ours`. That is: since we know `B`'s got the right *tree*, but its history is woefully incompatible with `main + squash(A)`'s history, we just do a dummy no-op merge to make their histories compatible again.

(Then merge this back up the stack, by merging the new `B` into `C`.)

## The state after performing this procedure

* `A` has been squashed into `main`.
* `B`'s tree is as if `A` were merged into `main` and then the resulting `main + A` were merged into `B`.
* `B`'s history contains the squashed `main + squash(A)`, so subsequent merges of `main` into `B` or `B` into `main` will be clean.
* `B`'s history looks a bit mad, but we shrug and move on.