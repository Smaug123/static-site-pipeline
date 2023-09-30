---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
comments: true
date: "2016-04-21T00:00:00Z"
aliases:
- /modular-machines/
title: Modular machines
---

I've written [a blurb][MM] about what a modular machine is (namely, another Turing-equivalent form of computing machine),
and how a Turing machine may be simulated in one.
(In fact, that blurb now contains an overview of how we may use modular machines to produce a group with insoluble word problem,
and how to use them to embed a recursively presented group into a finitely presented one.)

A modular machine is like a slightly more complicated version of a Turing machine, but it has the advantage
that it is easier to embed a modular machine into a group than it is to embed a Turing machine directly into a group.
We can use this embedding to show that there is a group with unsolvable word problem:
solving the word problem would correspond to determining whether a certain Turing machine halted.

This is as part of my revision process for the Part III course on "Infinite Groups and Decision Problems".
It's probably more comprehensible if you already know what a modular machine is.
Below are some notes which are handwritten, because I needed to draw pictures easily; the linked notes are typeset but might be less legible.

![Notes1]
![Notes2]

[MM]: /misc/ModularMachines/EmbedMMIntoTuringMachine.pdf
[Notes1]: /images/ModularMachines/ModularMachines1.jpg
[Notes2]: /images/ModularMachines/ModularMachines2.jpg
