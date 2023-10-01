---
lastmod: "2023-10-01T20:53:00.0000000+01:00"
author: patrick
categories:
- programming
- g-research
date: "2023-10-01T20:53:00.0000000+01:00"
title: Property-based testing introduction
summary: "A talk I gave at work introducing property-based testing and then giving some more advanced techniques."
---

A linkpost for [the slides for a talk](/misc/DogeConfPBT/DogeConfPBT.pdf) I gave in 2019 at G-Research.
I've put it up now because I keep on losing it and wanting to look stuff up in it.

We first cover what [property-based testing](https://en.wikipedia.org/wiki/Software_testing#Property_testing) is and why you might want to use it.
Then we discuss more advanced techniques: how to check that the distribution is sane from which you're drawing tests, and what to do about it if the distribution turns out not to be sane.
We next consider how to test stateful systems by modelling the transitions you want it to undergo (ultimately perhaps even progressing to a full alternative immutable implementation of the system, where the property is "the system under test behaves exactly like this reference implementation").
Finally we give a warning that while it's possible to sink arbitrary amounts of time and cleverness into testing every corner of your system, you can do much better than most people if you simply start small and stop whenever you think it's worth stopping.
