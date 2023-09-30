---
lastmod: "2021-10-25T23:41:14.0000000+01:00"
author: patrick
categories:
- uncategorized
date: "2021-10-25T00:00:00Z"
sidenotes: true
title: Don't supply `-f` to `rm` unless you know you need it
summary: "A vignette on the theme of 'do not allow yourself to get into the habit of supplying the `-f` flag to `rm`'."
---

```bash
➜  hugo git:(master) ✗ ./build.sh
Building thumbnails.
Building LaTeX.
Building site.
Start building sites …

                   | EN
-------------------+------
  Pages            | 196
  Paginator pages  |   6
  Non-page files   |   0
  Static files     | 371
  Processed images |   0
  Aliases          | 208
  Sitemaps         |   1
  Cleaned          |   0

Total in 45838ms
Linting.

➜ chrome --disable-web-security --user-data-dir=~/.chrome
```

{{< side right time-note "(checks local render of website)" >}}Yes, you read that timing correctly. Docker for Mac is truly astonishingly slow.{{< /side >}}

```bash
➜  hugo git:(master) ✗ git status
On branch master
Your branch is up to date with 'alligator/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   build.sh
        modified:   content/posts/2016-03-03-a-certain-limit.md
        modified:   layouts/partials/math.html

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        lint.sh
        ~/

no changes added to commit (use "git add" and/or "git commit -a")

➜  hugo git:(master) ✗ rm -r ~
rm: /Users/Patrick/Music: Permission denied
^C
^C
^C
^C
```
