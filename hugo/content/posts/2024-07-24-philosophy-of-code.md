---
lastmod: "2024-07-24T17:38:00.0000000+01:00"
author: patrick
date: "2024-07-24T17:38:00.0000000+01:00"
title: Code having "the right philosophy"
summary: "Those who would give up essential safety, to purchase a little temporary simplicity, deserve (and will get) neither safety nor simplicity."
---

[Hacker News](https://news.ycombinator.com/item?id=41032806):

> Time library can be simple, it's just rust libraries tend to be philosophic for some reason, but it's only one of many design approaches.

Certainly a true statement.

I claim that the "some reason" here is that this "philosophic" design approach is correct, and the other ones aren't.
Most standard libraries (.NET, Golang, Python) don't care about correctness enough that they'd actually *model the domains* in question, so they don't, so they make it trivial to write completely unnecessary bugs.

As evidence, I submit the fact that I have twice had to rewrite someone else's .NET code to fix time-related bugs in it, whose ultimate direct cause was "the .NET `DateTime` type is an extremely bad model for dates-and-times in the world".
In one of those two cases, I ended up completely rewriting the entire application, using NodaTime to drive the date-time computations, because that's a library that actually attempts to model dates-and-times.

Those who would give up essential safety, to purchase a little temporary simplicity, deserve (and will get) neither safety nor simplicity.
