---
lastmod: "2025-12-13T09:41:00.0000000+00:00"
author: patrick
categories:
- programming
date: "2025-12-13T09:41:00.0000000+00:00"
title: LLM arithmetic
summary: "I keep seeing people going on about the 3.9 - 3.11 = 0.79 thing, but we already know why they do that and how to avoid it!"
---

Just a quick one about something that really annoys me.

People go on and on about the fact that LLMs routinely get the question `What is 3.9 - 3.11?` wrong.

But we already know why they get it wrong!
It's because they are triggered into a basin containing dates and Bible verses: the `9` is kind of being considered as `09` rather than the arithmetically correct `90`.

The testable prediction is that you can get them to do the right thing by signalling that this is maths and not human language.
The simplest way to do that seemed to me to express it as TeX.
And indeed every model I've tried, even the tiny and fast ones, do `$3.9 - 3.11$` correctly even when they don't do `3.9 - 3.11` correctly.

Like, urgh, the "they're not generally intelligent" take might be *true*, but this arithmetic example is really terrible evidence for it!
They consistently misread this specific question, but it is *purely* a misreading, not a failure to compute the answer.
