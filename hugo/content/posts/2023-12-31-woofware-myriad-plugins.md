---
lastmod: "2023-12-31T13:42:00.0000000+00:00"
author: patrick
categories:
- uncategorized
date: "2023-12-31T13:42:00.0000000+00:00"
title: Announcing WoofWare.Myriad.Plugins
summary: "Some F# source generators to solve common problems I have."
---

This is a linkpost for [WoofWare.Myriad.Plugins](https://github.com/Smaug123/WoofWare.Myriad), a set of [F#](https://en.wikipedia.org/wiki/F_Sharp_(programming_language)) source generators ([see it on NuGet](https://www.nuget.org/packages/WoofWare.Myriad.Plugins)).
Go and read [the README on GitHub](https://github.com/Smaug123/WoofWare.Myriad/blob/main/README.md) if you're interested.
As of this writing, the following are implemented:

* `[<JsonParse>]` (to stamp out `jsonParse : JsonNode -> 'T` methods)
* `[<RemoveOptions>]` (to strip `option` modifiers from a type)
* `[<HttpClient>]` (to stamp out a [RestEase](https://github.com/canton7/RestEase)-style HTTP client)
* `[<GenerateMock>]` (to stamp out a record type corresponding to an interface, for easy record-update syntax when [mocking](https://en.wikipedia.org/wiki/Mock_object)).

They are particularly intended for `PublishAot` [ahead-of-time compilation](https://learn.microsoft.com/en-us/dotnet/core/deploying/native-aot/) contexts, in which reflection is heavily restricted, but also for anyone who doesn't want reflection for whatever reason (e.g. "to obtain the ability to step through code in a debugger", or "for more predictable speed").