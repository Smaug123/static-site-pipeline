---
lastmod: "2025-06-17T00:00:00.0000000+01:00"
author: patrick
categories:
- programming
date: "2025-06-17T00:00:00.0000000+01:00"
title: Announcing WoofWare.Expect
summary: "A basic but functional expect-testing framework for F#."
---

This is a linkpost for [WoofWare.Expect](https://github.com/Smaug123/WoofWare.Expect), which implements [expect testing](https://blog.janestreet.com/the-joy-of-expect-tests/) in an F# [computation expression](https://learn.microsoft.com/en-us/dotnet/fsharp/language-reference/computation-expressions).
Go and read [the README on GitHub](https://github.com/Smaug123/WoofWare.Expect/blob/main/README.md) if you're interested.

As of this writing, the following are implemented:

* Comparison with existing inline snapshot
* Custom formatting of the snapshot (fully general `'T -> string` to override the default `.ToString()`)
* Specific support for JSON snapshotting using [FSharp.SystemTextJson](https://github.com/Tarmil/FSharp.SystemTextJson), including overriding the default ser/de settings
* "Bulk update" mode for mass regenerating snapshots in a test fixture (which is only slightly unwieldy).
