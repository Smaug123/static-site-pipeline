---
lastmod: "2024-08-26T12:26:00.0000000+00:00"
author: patrick
categories:
- uncategorized
date: "2024-08-26T12:26:00.0000000+00:00"
title: WoofWare.Myriad.Plugins learns to parse args
summary: "My F# source generators have some new features, including an argument parser."
---

This post is about [WoofWare.Myriad.Plugins](https://github.com/Smaug123/WoofWare.Myriad), a set of [F#](https://en.wikipedia.org/wiki/F_Sharp_(programming_language)) source generators ([see it on NuGet](https://www.nuget.org/packages/WoofWare.Myriad.Plugins)).
Go and read [the README on GitHub](https://github.com/Smaug123/WoofWare.Myriad/blob/main/README.md) if you're interested.

They are particularly intended for `PublishAot` [ahead-of-time compilation](https://learn.microsoft.com/en-us/dotnet/core/deploying/native-aot/) contexts, in which reflection is heavily restricted, but also for anyone who doesn't want reflection for whatever reason (e.g. "to obtain the ability to step through code in a debugger", or "for more predictable speed").

Since [my last post], I've implemented the following:

* `[<JsonSerialize>]` (to stamp out `toJsonNode : 'T -> JsonNode` methods)
* `[<CreateCatamorphism>]` (to build a non-stack-overflowing [catamorphism](https://fsharpforfunandprofit.com/posts/recursive-types-and-folds/) for an algebraic data type)
* `[<ArgParser>]` (to stamp out an argument parser).

## `ArgParser`

Example:

```fsharp
[<ArgParser>]
type Foo =
    {
        [<ArgumentHelpText "Enable the frobnicator">]
        SomeFlag : bool
        A : int option
        [<ArgumentDefaultFunction>]
        B : Choice<int, int>
        [<ArgumentDefaultEnvironmentVariable "MY_ENV_VAR">]
        BWithEnv : Choice<int, int>
        C : float list
        // optionally:
        [<PositionalArgs>]
        Rest : string list // or e.g. `int list` if you want them parsed into a type too
    }
    static member DefaultB () = 4
```

Features:

* Optional arguments of type `'a option`.
* `[<ArgumentDefaultFunction>]` and `[<ArgumentDefaultEnvironmentVariable>]` to auto-populate default arguments which are not supplied. Default values are modelled as `Choice<'a, 'a>`, with `Choice1Of2` meaning "the user gave me this", and `Choice2Of2` meaning "this was populated from a default source".
* Help text with `[<ArgumentHelpText>]`, summoned with `--help` in any position where the parser is expecting an argument, and also summoned during certain failures to parse.
* Detailed control over `TimeSpan` parsing with `[<ParseExact>]` (and `[<InvariantCulture>]` if desired).
* Accumulation of arguments supplied repeatedly: for example, `Path : FileInfo list` is populated with `--path /foo/bar --path /baz/quux`.
* Handling of `--foo=bar` and `--foo bar` equivalently.
* Booleans have arity 1 or 0, whichever leads to a successful parse: `--flag` and `--flag=true` and `--flag true` are equivalent.
* Positional arguments can appear anywhere, although if they start with a `--` then it is best to put them after a trailing `--` separator: `--named-arg=blah -- --pos-arg1 pos-arg2 --pos-arg3`.

[my last post]: {{< ref "2023-12-31-woofware-myriad-plugins" >}}
