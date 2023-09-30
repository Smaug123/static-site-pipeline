---
lastmod: "2021-06-05T13:10:16.0000000+01:00"
author: patrick
categories:
- programming
comments: true
date: "2021-01-18T00:00:00Z"
title: Find the Bug, C# edition
summary: "A cute little exercise in bug-spotting."
---

Thanks to [Joe Roberts](https://github.com/Joey9801/) for showing me the code which I've rendered below as an exercise in bug-spotting.

The following C# defines a class with a private nullable int field `_data`, initialised to `null`, and a public int property `Data`, which assumes the value of `_data` if `_data` has a value, or sets `_data` to `3` and returns `3` otherwise.

```csharp
class Foo {
  private int? _data = null;
  public int Data => _data ??= 3;
}

Foo f;
// more code here...
Console.WriteLine(f.Data);
```

It is very likely that this code contains a bug. What is the probable bug?

# Hint, which you will certainly need

C# compiles down to Microsoft Intermediate Language ("IL") bytecode.
The example above compiles to essentially the following:

```
int32 local0;
local0 = this._data.GetValueOrDefault();
if (this._data.HasValue)
    goto label1;
local0 = 3;
this._data = new Nullable<int32>(local0);
stack.push(local0);
goto label2;

label1:
    stack.push(local0);
label2:
    return stack.pop();
```

# Hint 2
In [ROT13](https://rot13.com/):

Gurer'f n enpr pbaqvgvba - jung unccraf va n zhygv-guernqrq pbagrkg?

# Answer
In ROT13:

Rkrphgvba ortvaf, naq gur ybpny inevnoyr vf nffvtarq gur qrsnhyg inyhr mreb. Gur guernq vf fhfcraqrq. N arj guernq nfxf sbe gur inyhr bs Qngn, naq pbeerpgyl trgf gur inyhr guerr. Rkrphgvba bs gur bevtvany guernq erfhzrf; qngn abj unf n inyhr, fb jr whzc gb gur svefg ynory, naq erghea gur qrsnhyg inyhr bs na vag, anzryl mreb.
