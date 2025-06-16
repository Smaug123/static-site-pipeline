---
lastmod: "2025-06-16T09:28:00.0000000+01:00"
author: patrick
categories:
- programming
date: "2025-06-16T09:28:00.0000000+01:00"
title: LLM effect on my programming (2025 edition) 
summary: "Since my last post about this in 2024-03, LLMs have become a distinctly positive addition to my ability."
---

I wrote in a [previous post] that ChatGPT 4 was not clearly having a positive effect on my ability to code.

We're over a year later now, and we have larger models and reasoning models, and those *are* definitely an improvement over not having them.

# As documentation-knower

[Opus 4](https://claude.ai) has memorised how .NET works to a terrifying level of detail.
In general, I can ask it minutely specific questions about the .NET runtime and it will simply answer them correctly.

I found Gemini 2.5 Pro to be fairly solid as an engine for searching the .NET spec (which I uploaded to its context), although still quite prone to making things up.

# As bug-finder

Opus 4 is also a powerful debugging engine, the first one that I actually trust to tell me the cause of a bug without handholding.

My workflow is:

* Put a whole load of tracing into my code
* Run the code to obtain the tracing
* Dump the trace into Opus 4 (using the ordinary chat interface) along with the code (usually from working in a Project, but sometimes also supplying the `git diff` against `main` if I believe that the diff introduced the bug), and ask it what is wrong.

This Just Works alarmingly frequently.

# As sanity-checker

At work, I feed many (non-sensitive) diffs automatically on `git push` through o3-mini-high with a prompt asking for a sanity check, obvious mistakes, etc.
This catches a bunch of really dumb stuff like typos, and is particularly valuable for the cursed dynamic languages like Groovy where you can't know whether anything is wrong without running it.

I've found o3-mini-high less valuable for "proper" code reviews (the sort that you'd have an engineer do to identify design problems, for example).

# As LeetCode solver

o3 is better than I am at solving well-defined tightly-scoped LeetCode-style problems.
(Fortunately for me, I basically never have to do this in real life.)

# Wrapup

Many of my points in the previous post are still correct: I still don't trust any of the models to write code for me, and for the same reasons.
But now the utility of the models in other areas is much higher - I now have what I described in the "What I actually want from such a system" section of the previous post, for example - and I would absolutely recommend a Claude Pro subscription.
(I'm even considering Claude Max; Opus consumes a *lot* of quota.)

[previous post]: {{< ref "2024-03-27-chatgpt-and-programming" >}}
