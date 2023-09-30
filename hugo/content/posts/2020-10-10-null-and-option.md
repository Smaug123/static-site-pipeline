---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- hacker-news
- programming
comments: true
date: "2020-10-10T00:00:00Z"
title: Nulls and options (a note from Hacker News)
summary: "A quick note from Hacker News about why we want optional types but why 'null' is unintuitive."
---

A [question by user gitgud](https://news.ycombinator.com/item?id=24737961) on Hacker News:

> > "4. Objects must always be initialized to a valid state. Not doing so is a compile-time error."
>
> So this essentially means there can never be a NULL object assigned to anything... how is this possible? is it avoided by throwing exceptions instead of returning NULL?

[My response](https://news.ycombinator.com/item?id=24738020):

> If you forget everything you ever learned about programming, and then I ask you for an integer, you're never in a million years going to reply "null"; the existence of "null" is something you had to learn. A language could simply not have a concept of "null". Even an OO language could have no concept of "null".
> In practice, it's useful to be able to answer "I'm sorry, Dave, I can't do that". Some languages do that by silently and implicitly allowing this special value "null" in a return type. Some languages allow you to throw an exception (again without ever having declared that this is something you might do). But some languages take one of those approaches and make it explicit: in the two cases, you have the "option"/"maybe" type, or checked exceptions. Either of these explicit methods let a function declare that it may fail, and moreover the language forces you to handle the possibility of failure in any function which may fail.
> The "reasonability" comes from the fact that the language forces you to be explicit about the possibility of failure, rather than implicitly allowing all functions to fail.
