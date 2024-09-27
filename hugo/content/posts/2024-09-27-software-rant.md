---
lastmod: "2024-09-27T18:14:00.0000000+01:00"
author: patrick
categories:
- programming
date: "2024-09-27T18:14:00.0000000+01:00"
title: Unhinged rant about software
summary: "Modern software practices and their sadness."
---

*Epistemic statement: wail of anguish*

I've given this rant twice recently, so will unwisely write it down to avoid giving it a third time.

# Most people seem bent on self-flagellation

Subtitle: And I Don't Think They Realise How Hard They're Making It For Themselves.

## Python

Python is touted as "simple".
What people really mean by is that library developers put in large amounts of effort to make it *concise*.
Python itself is pretty complicated (indeed, by design you essentially can't make *any* static guarantees), and its extreme dynamism makes it in practice *extremely complex*.

I recently mentioned [Pyright](https://github.com/microsoft/pyright) to a professional Python developer.
This person tried it out, and stopped, saying "it's giving me all these false positives".
He then described two such broad classes of false positives, *both* of which were in fact true positives: they were indicating bugs in the code.
(I'm not talking about logic bugs here, revealed by an attempt to impose types; these are bugs arising due to the use of actual language features.)

A professional full-time Python developer did not know that they were bugs!
This is not his fault: Python is really hard to understand!

(I shall not mention the dependency management situation because everyone already knows what a flaming mess that is.)

## .NET and ASP.NET

Idiomatic .NET code seems to be bizarrely full of galaxy-brained object orientation.
ASP.NET is a *particularly* bad example.
Throughout the standard libraries and chunks of the ecosystem, Microsoft and everyone else goes to extreme lengths to construct a system that's as hard as possible to understand.
For example:

* ASP.NET specialises in converting all compile-time errors to runtime errors. Its total reliance on runtime dependency injection means you simply have to run your server to discover whether it even has a chance of working. This is the part of working on ASP.NET stuff that causes me literal physical pain (in my legs, if you're interested). As far as I know, you can't opt out of this insanity. [There's a correct way to do dependency injection](https://www.bartoszsypytkowski.com/dealing-with-complex-dependency-injection-in-f/), which is type-checked and compile-time-safe, but of course C# can't express it.
* Convention Over Configuration, i.e. "don't worry your pretty little head about how this thing works; just trust Daddy Microsoft". All abstractions leak, and Microsoft's approach makes it almost completely impossible to work out what's happening when ASP.NET leaks.
* No human is capable of writing an ASP.NET service correctly. The middleware system is notoriously brittle: it depends fundamentally and silently on chaining together all the middleware in the correct order. GitHub [is](https://github.com/aspnet/SignalR/issues/2316) [full](https://github.com/dotnet/AspNetCore.Docs/issues/28467) [of](https://github.com/IzyPro/WatchDog/issues/46) [issues](https://github.com/dotnet/aspnetcore/issues/15313) [describing](https://github.com/dotnet/aspnetcore/issues/34146) [people](https://github.com/dotnet/aspnetcore/issues/14049#issuecomment-533190098) [getting](https://github.com/dotnet/aspnetcore/issues/52295) [this](https://github.com/dotnet/AspNetCore.Docs/issues/14221#issuecomment-530436736) [wrong](https://github.com/dotnet/AspNetCore.Docs/issues/19957#issuecomment-698572231), [or](https://github.com/domaindrivendev/Swashbuckle.AspNetCore/issues/2641) [asking](https://github.com/dotnet/AspNetCore.Docs/issues/17031) [for](https://github.com/dotnet/aspnet-api-versioning/issues/704) [better](https://github.com/dotnet/aspnetcore/issues/45302) [documentation](https://github.com/dotnet/aspnet-api-versioning/issues/979). All common .NET languages are strongly- statically- typed; why did they decide to throw away all the help the computer can give you?
* ASP.NET has painted itself into such a corner that they have had to start putting some *seriously* ridiculous features into C#. I'm thinking here of [interceptors](https://devblogs.microsoft.com/dotnet/new-csharp-12-preview-features/#interceptors), which they describe as "enabl[ing] exciting code patterns". I do not want exciting code patterns! If you want to generate source code, then do so; give us a macro system if you like; but don't bake this stuff into your language - you're not a Lisp!
* Also by the way you're not Ruby. When I discovered [Harmony](https://github.com/pardeike/Harmony) in a dependency recently, I had several minutes of existential terror.
* Why do the Microsoft identity libraries perform 80ms of reflection before decoding a JWT (we timed this)?

For a system which eschews compile-time safety in favour of "convention", .NET sure has terrible docs.
Why are they so big, and why do they contain so little useful information?
Why are all these systems built to be impossible to use without a comprehensive knowledge of their implementation, such that I have to open the .NET source code *every time* I have a question about what something does?
Why do I [keep](https://github.com/dotnet/dotnet-api-docs/pull/9753) [on](https://github.com/dotnet/dotnet-api-docs/pull/9595) [having](https://github.com/dotnet/runtime/pull/95956) [to](https://github.com/dotnet/docs/pull/35171) [raise](https://github.com/dotnet/dotnet-api-docs/pull/9394) [docs](https://github.com/dotnet/docs/pull/42637) [PRs](https://github.com/dotnet/aspnetcore/pull/57779) adding the most basic information?
So many questions!

## Golang

Another example of a "simple" language which it's impossible to write correctly without [a large suite of linters](https://github.com/golangci/golangci-lint) you don't get out-of-the-box.
[Fasterthanli.me](https://fasterthanli.me/articles/i-want-off-mr-golangs-wild-ride) has written most of what I want to say about this.

I particularly enjoy the fact that you can identify a Golang program by the extremely cursed error messages you get out of it, where it dumps uninitialised memory to the console and that sort of thing.
This happens with considerable regularity.
I've even observed it in `kubectl`, so it's not just that I've been unlucky; even the best Golang programmers can't reliably avoid thinking garbage memory is a string.
But apparently Golang error handling is great, so what would I know.

[Boats](https://without.boats/blog/let-futures-be-futures/):

> You might also decide your language should have other classic features like null pointers, default constructors, data races and GOTO, for reasons known only to you.

Why did the creators not put algebraic data types into the language, if they were going to do errors-as-return-values?

## Summary

The Jonathan Blow/Casey Muratori sphere of the Internet probably expresses this the most strongly, but they are completely correct.
I think people are using *really hard environments* to solve *usually very simple problems*, and it makes their lives so much harder than necessary.
Their work environment is absolutely full of [incidental complexity](https://en.wikipedia.org/wiki/No_Silver_Bullet).

To lightly paraphrase someone very senior at $WORK describing me, my schtick (a decent chunk of why I'm a "Principal Engineer" there) is to get annoyed at the existing solution to a problem and write a dumb replacement in F#, in four hours, that's orders of magnitude faster, orders of magnitude less code, and requires less than one PR of maintenance a month (and usually *much* less).
I've done this several times now.
(There's one thing, "Kraken" for those who know the G-Research internal environment, which doesn't fit that pattern in that I did actual extended work to create it; I think that last received a PR nearly a year ago, which is to say that it is also essentially complete. That used engineering techniques no more complicated than [diligently making sure all state was reified][dryrun] and using discriminated unions to tightly constrain the domains. None of this is rocket science!)

I believe I'm not a "10x engineer" but that most people are following practices which hold them back *so much*.

# Copilot etc

As an encore, I believe I have an answer to "why does everyone seem to like the Copilot-like things so much, whereas I have to turn them off within five minutes of trying them?".

Most people work in environments which have been built to resist understanding, for which you can't get a good mental model without vast expenditure of effort, so most people are forced to write software by vibes.
ChatGPT and friends are astonishingly powerful vibes engines, and in any given case they can often (usually?) vibe better than a human can; in particular, they can vibe code at a human level.
Since humans are only vibing when they write code, ChatGPT is good enough to do a large chunk of the human job.
A human can't reliably do better because almost no human (very much including me!) can develop the superhuman systems understanding that is required to *engineer* a solution.

I am thinking of things like:

* ASP.NET (see earlier).
* Python (see earlier).
* CSS, which is essentially a vast collection of special cases.
* Javascript, about whose shortcomings enough words have certainly been written elsewhere.

[dryrun]: {{< ref "2021-02-20-in-praise-of-dry-run" >}}
