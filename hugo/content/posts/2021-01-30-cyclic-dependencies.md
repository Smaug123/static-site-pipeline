---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- programming
- hacker-news
comments: true
date: "2021-01-30T00:00:00Z"
title: Cyclic dependencies (a note from Hacker News)
summary: "A quick note from Hacker News about how to model in F# something that might look like cyclic dependencies."
---

In response to [a comment by bob1029 on Hacker News](https://news.ycombinator.com/item?id=25970583), which ran as follows.

> Language constraints aside, the real world is not something that can be cleanly modeled without the notion of circular dependencies between things. Not very many real, practical activities can be truly isolated from other closely-related activities and wrapped up in some leak-proof contract.
>
> Consider briefly the domain model of a bank. Customers rely on Accounts (I.e. have one or many). Accounts rely on Customers (i.e. have one or many). This is a simple kind of test you can apply to your language and architecture to see if you have what it takes to attack the problem domain. Most approaches lauded on HN would be a messy clusterfuck when attempting to deal with this. Now, if I can simply call CustomerService from AccountService and vice versa, there is no frustration anymore. This is the power of reflection. It certainly has other caveats, but there are advantages when it is used responsibly.
>
> If you want to understand why functional-only business applications are not taking the world by storm, this is the reason. If it weren't for a few "messy" concepts like reflection, we would never get anything done. Having 1 rigid graph of functions and a global ordering of how we have to compile these things... My co workers would laugh me off the conference call if I proposed these constraints be imposed upon us today.

[I reply](https://news.ycombinator.com/item?id=25970628):

> In F#, you would naturally approach this by defining a `Customer` independent of the `Account` (e.g. just containing a name and address), and an `Account` independent of the `Customer` (e.g. just containing an ID), and then a `Bank` which is a mapping of `Account` to `Set<Customer>`. What you see as a cyclic dependency, I see as a data type that you haven't reified.

Other commenters note that indeed this is precisely how SQL would model the domain without cyclic dependencies.
And [JackFr](https://news.ycombinator.com/user?id=JackFr) gave a [rather nice soundbite](https://news.ycombinator.com/item?id=25970879):

> Not really rocket science but some times your model is telling you something if you’re willing to listen.
