---
lastmod: "2021-02-07T08:50:46.0000000+00:00"
author: patrick
categories:
- programming
comments: true
date: "2020-12-28T00:00:00Z"
title: A bug in Git
summary: "A bug I found and reported in Git."
---

*This is a copy of [a mail](https://lore.kernel.org/git/31599b45-cf4e-be77-22bb-8fa03f0a52d6@patrickstevens.co.uk/) I sent to the git mailing list.*

Below the fold is a `git bugreport`-generated report of a bug with `git apply --cached --reject`, which I have reproduced in three different environments.
Summary: we do not correctly stage the removal of a file if there is also an unrelated change that cannot be applied.

I don't think this behaviour is intended; in the report I give a couple of variations which correctly do what I expected, and this one breaks the semantics I expect, given the behaviour of those variations.
I have not tried to find the source of the bug.

Thanks,

Patrick Stevens

---

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Complete reproduction instructions:

```bash
mkdir badrepo && cd badrepo && git init
echo "start" >> file.txt && git add file.txt && git commit -m "Initial
commit"
git tag initialcommit
echo "another" >> another.txt && git add another.txt && git commit -m
"Something else"
git tag commit2
git rm another.txt && git rm file.txt && git commit -m "Remove both"
git tag commit3
git checkout initialcommit
git diff commit2 commit3 | git apply --reject --cached
```

What did you expect to happen? (Expected behavior)

We should be left detached at tag `initialcommit`, with the working copy clean (i.e. containing only `file.txt`), and with the deletion of `file.txt` staged.

What happened instead? (Actual behavior)

The final `git apply` correctly leaves us detached at tag `initialcommit`, with a clean working copy, but incorrectly the deletion of `file.txt` is not staged: the index is also clean.

What's different between what you expected and what actually happened?

The file `file.txt` should have had its deletion staged, because this is part of the diff which could apply cleanly.

Anything else you want to add:

If I delete the `--cached` from the last line, the right thing happens: the working copy has `file.txt` deleted in the working copy but the deletion is not staged.
If instead I remove the `git rm another.txt`, then similarly the right thing happens: now we end up with the deletion of `file.txt` staged (but the working copy is correctly unchanged).

I have reproduced this using git version 2.24.1.windows.2, as well as 2.29.2 built on Windows using the WSL and invoked through WSL, as well as from the Mac HomeBrew install where I produced this bug report.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.29.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 18.7.0 Darwin Kernel Version 18.7.0: Mon Aug 31 20:53:32
PDT 2020; root:xnu-4903.278.44~1/RELEASE_X86_64 x86_64
compiler info: clang: 11.0.0 (clang-1100.0.33.17)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

