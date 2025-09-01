---
lastmod: "2025-08-29T10:23:00.0000000+01:00"
author: patrick
categories:
- programming
date: "2025-08-29T10:23:00.0000000+01:00"
title: Boolean blindness
summary: "Why booleans are an advanced technique that should be used with care."
---

*Written off the back of [That Boolean Should Probably Be Something Else](https://ntietz.com/blog/that-boolean-should-probably-be-something-else/).*

Booleans often throw away information.
Consider *not* throwing away that information unless you have some good reason to do so.

I know of two main use cases for booleans: indicating that some condition was met, or indicating that some state is desired.
Here's what it means to "throw away information" in those two cases.

# Boolean to indicate that some condition was met

A boolean means "the condition was met" or "the condition was not met".
But why are you justified in making a judgement either way on the statement "the condition was met"?
It's usually because you ran some check that gave you evidence that the condition was met (that is, `true`), or that you have no evidence that the condition was met, or even counter-evidence (that is, `false`).

So why are you telling me that you ran a check and it gave you evidence?
Just give me the evidence instead!

## Timestamps

The article linked at the top uses the example of storing timestamps in a database, instead of simply a `true` value, indicating "this event happened".
That's an optimised case of this pattern.
To go purely into the "give me the evidence" mode, you would actually store not a timestamp but a complete representation of the event - who did it, when, and why, for example.
But in reality, that's just quite a lot of information, and some of it might be sensitive; so we truncate it.

In the boolean world, we truncate it all the way, throwing away *all* the information beyond the bare fact that the event happened.

But in the timestamps world, we truncate it down to just the timestamp component.
Now, when someone asks us whether the event happened, we can give them (a small amount of) evidence that it did happen, not just a yes/no answer.

## Enums

The article then discusses the question "is this user an admin?".
In the booleans world, again we can only say "yes" or "no".
But if we start replying with evidence instead of brute fact, we can give the type of the user: we can say "this user is a guest" and allow the caller to deduce that the user is not an admin.

That is, we can answer not with a boolean but with an enum.

## Thresholds

Claude commented on an earlier draft of this essay, suggesting the case of `x > 5` as a boolean result that doesn't have rich intermediate state worth capturing.
For such a simple check, though, I'd at least *consider* not passing the boolean around, but instead simply passing `x` and allowing the callee to perform the check explicitly.
Perhaps you don't need to anticipate what the callee needs from you, but instead give them *everything* and let them choose.

# Boolean to indicate that some state is desired

Config objects are often just big bags of ints and booleans and things.
This can be a decent representation, but be aware that it is often artificially restrictive: booleans are often the shadow of more general features that you might be able to offer with minimal extra effort.
The boolean causes the user to throw away information about their intent, in conforming to your API.

For example, `enableLogging = false` is OK, but `logThreshold = LogLevel.None` both expresses the same intent and allows more use cases.

Or a boolean `putSpacesAtEnd : bool` could instead be `suffix : string`: the boolean API is a constraint on what the user can supply, when you might instead prefer to offer the more general feature.

Whether a more general representation is *desirable* in any particular case is another matter - API design is hard - but be aware that it's an available option, that makes the meaning much more explicit!

# Philosophical point

The type `bool` is logically equivalent to `Option<unit>`.
If your usage of `bool` is one for which `Option<unit>` is a natural model, then it's fairly obvious that you've thrown stuff away: `unit` is a very unusual type because it's almost useless.
In this light, it's more clearly a candidate for an optimisation that has been *prematurely* applied.

Here are two equivalent type signatures, one making it clear that information has been thrown away:

```fsharp
let hasPermission (userId : int) : bool = ...
```

```fsharp
let hasPermission (userId : int) : Option<unit> = ...
```

And here is where we *don't* throw away that information:

```fsharp
let permission (userId : int) : Option<UserPermissions> = ...
```

The "boolean-equivalent" example has effectively just shoved the result of `permission` through `Option.map ignore`; and `ignore` is a function that should always provoke a *little* unease.

# Good reasons to use booleans

Throwing stuff away is a standard performance technique, and indeed booleans can be good for performance: for example, you might perform some computation over the evidence, rendering the result as a boolean, and then repeatedly refer to the result of that computation.
Like any optimisation, it's often easier to understand if it's constrained in its scope: creating a boolean internally to a function, that doesn't escape, is almost always completely fine and natural.

Sometimes you might want to throw away information for other reasons: perhaps you specifically need not to store that user's identifying information.

Booleans also give you a chance to name some condition explicitly, if that would help: instead of `if fooBar x then ...`, it might be more readable to have `let isFrobnicated = fooBar x; if isFrobnicated then ...`.
There may be other ways to do this that don't throw away as much information, but they're often much more heavyweight.
