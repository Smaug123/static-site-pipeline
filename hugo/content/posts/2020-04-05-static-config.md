---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- hacker-news
- programming
comments: true
date: "2020-04-05T00:00:00Z"
title: Static config (a note from Hacker News)
summary: "A quick note from Hacker News about my preference for static config rather than dynamic."
---

Hacker News user [amelius](https://news.ycombinator.com/user?id=amelius) [commented](https://news.ycombinator.com/item?id=22788623) on a [linkpost](https://news.ycombinator.com/item?id=22787332) to [an article about how configuration languages are all terrible](https://beepb00p.xyz/configs-suck.html):

> I don't agree. Configuration files tell a program what to do. You want expressive power there. Telling a program what to do merely through values only makes things more indirect.
> To give an example: you can get into the situation that some configuration values are only valid when configuration value X is Y, and otherwise other configuration values are valid. What better way to model this than through an if-statement in a programming language? This makes it immediately apparent which settings have effect.

[I responded](https://news.ycombinator.com/item?id=22788713):

> I am involuntarily howling internally in anguish, and if the feeling could speak, it would be screaming "[parse, don't validate](https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/)".
> If some config values are valid when X is true, and other config values are valid when X is false, then use a different schema for the two cases. This is what discriminated unions are for: for representing conditionals statically, inspectably, serialisably!
> If some config values are valid when X is 0.339, and some are valid when X is 0.340, and some are valid when X is 0.341, and so on, then… I don't know how to help, and maybe I must just avert my eyes in shame as I implement the dynamic logic. (But in that case it seems a bit odd to say you're "telling the program what to do" with this configuration; I'd say you're bolting on a little extra program at the start.)
