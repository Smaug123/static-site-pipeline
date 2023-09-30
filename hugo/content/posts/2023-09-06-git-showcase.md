---
lastmod: "2023-09-06T13:51:00.0000000+01:00"
author: patrick
categories:
- programming
date: "2023-09-06T13:51:00Z"
title: Notes for a Git fireside chat
summary: "A syllabus for a fireside chat to give at work, on Git"
---

This is simply an outline, with no actual content.

# How Git works

* Recommendation to read Pro Git
* Fundamental model: the object database
  * Blobs, trees, tags, commits
* Extra metadata
  * Branches
  * Lightweight tags
  * HEAD (and other symbolic refs)
  * Remotes
* Mention of performance optimisations such as packfiles
* Merge algorithms
  * recursive
  * ort
  * ours
* Useful commands
  * `git rev-parse`
  * `git merge-base`
  * `git symbolic-ref`
  * `git clone --depth=1`
  * `git commit --amend`
  * `git grep` (although ripgrep is generally faster anyway)
  * `git log -p` (for patch) and `-S function_name`
  * `git blame`
* Brief mention of what a submodule is
* Brief mention of what `git rebase` is
* How-tos
  * Stacked PRs in a squash-merge-to-`main` world
* Case studies
  * `$INTERNAL_WORKSPACE_TOOL push-files`
  * my internal Git-related dotfiles
  * [git-appraise](https://github.com/google/git-appraise)


# Problems with Git, and why Pijul is interesting

## Merging

Git works on snapshots => merging is impossible in principle.
Here's the textbook example:

Start:
```
A
B
```

Branch 1:
```
A
X
B
```

Branch 2:
```
G
A
B
```
then
```
A
B
G
A
B
```

When merging branch 1 and branch 2, the snapshot-based merge algorithm can't know which AB pair the X was added in between, so it must choose arbitrarily.


## Conflicts

Conflicts are not modelled at all: a conflict is only a property of the working tree, and you can't "commit it".
That means *you can never tell Git how to resolve a conflict* in such a way that it can reliably resolve the same conflict again in the future.
(`git rerere` is a hack that in my experience frequently does not do the right thing.)