---
lastmod: "2025-06-20T00:00:00.0000000+01:00"
author: patrick
categories:
- programming
date: "2025-06-20T00:00:00.0000000+01:00"
title: Things I've learned about the .NET runtime
summary: "While writing an MSIL interpreter, I discovered a bunch of unexpected things about the .NET runtime."
---

# The JIT is actually required

(Or, in NativeAOT, other mechanisms that aren't just what's in System.Private.CoreLib.)

Some methods are JIT intrinsics, but I had previously thought the JIT was just an optimisation.
This is false!
For example, [Type.TypeHandle throws](https://github.com/dotnet/runtime/blob/ec11903827fc28847d775ba17e0cd1ff56cfbc2e/src/libraries/System.Private.CoreLib/src/System/Type.cs#L467-L471) and *must* be swapped out by the JIT.
I don't know how this works on NativeAOT.

# `Console.WriteLine` is *incredibly* complicated

`Console.WriteLine` exercises at least the following:

* [Locking](https://github.com/dotnet/runtime/blob/4314ca34f3c620c180ef8f7fc28973af7ff47ad4/src/libraries/System.Private.CoreLib/src/System/SR.cs#L52)
* [`Ldtoken` and type lookup](https://github.com/dotnet/runtime/blob/4314ca34f3c620c180ef8f7fc28973af7ff47ad4/src/libraries/System.Private.CoreLib/src/System/SR.cs#L84)
* [Exception handling](https://github.com/dotnet/runtime/blob/4314ca34f3c620c180ef8f7fc28973af7ff47ad4/src/libraries/System.Private.CoreLib/src/System/SR.cs#L50)
* [Byrefs](https://github.com/dotnet/runtime/blob/4314ca34f3c620c180ef8f7fc28973af7ff47ad4/src/coreclr/System.Private.CoreLib/src/System/Runtime/CompilerServices/RuntimeHelpers.CoreCLR.cs#L174)
* [Delegates](https://github.com/dotnet/runtime/blob/4314ca34f3c620c180ef8f7fc28973af7ff47ad4/src/libraries/System.Private.CoreLib/src/System/Type.cs#L737)

# Top-level no-exception-handler behaviour change in net9

In earlier versions of .NET, `finally` blocks and `Dispose` methods were liable not to run when an unhandled exception terminates program execution.
This was documented as implementation-defined behaviour [in the C# language spec](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/exceptions#214-how-exceptions-are-handled), though it doesn't appear to be documented elsewhere.

That implementation-defined behaviour means my programs basically all contain this boilerplate:

```fsharp
let reallyMain argv =
    0

let main argv =
    try
        reallyMain argv
    with
    | _ -> reraise ()
```

However, in .NET 9 (I think) this behaviour appears to have been changed, and now the .NET runtime does the obvious thing - `Dispose` methods run and `finally` blocks execute even when an exception causes shutdown!

# The .NET runtime doesn't actually model uint32

Neither [on the eval stack](https://github.com/Smaug123/WoofWare.PawPrint/blob/c747d6eb3a2d138debce9c6cca763287bb21a7a9/WoofWare.PawPrint/EvalStack.fs#L60) nor [as a CLI intrinsic type](https://github.com/Smaug123/WoofWare.PawPrint/blob/c747d6eb3a2d138debce9c6cca763287bb21a7a9/WoofWare.PawPrint/BasicCliType.fs#L39) are `uint32` or `uint64` modelled; they're stored as `int32` and `int64` with two's complement.
