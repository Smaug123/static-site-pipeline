---
lastmod: "2025-06-21T00:00:00.0000000+01:00"
author: patrick
categories:
- programming
date: "2025-06-21T00:00:00.0000000+01:00"
title: Some Python surprises
summary: "I am forever astonished that people describe Python as a simple language. Here are some of the things I found very surprising about it."
---

# An assertion that can pass

The following code can succeed without throwing, although it's structurally very unintuitive why:

```python
try:
  with Foo():
    result = blah
except ValueError:
  result.baz()
else:
  assert False
```

This is an entry in the "you need to know how everything is implemented before you can understand it" registry: desugaring this makes it clear how it could pass (if the `__exit__` method on the context manager `Foo` throws `ValueError`), but the syntax is practically purpose-built to make it hard to see that it can.

# You can't monkey-patch `__add__` on an instance

Special methods like `__add__` are looked up on the *class*, not the instance.
(See [Special method lookup](https://docs.python.org/3/reference/datamodel.html#special-lookup).)

Again, `a + b` *looks* simple, but is in fact weirdly complex and its semantics are highly unintuitive.

# Integers are sometimes ref-equal and sometimes not

```python
a = 10000  # big enough to escape the small integer cache
b = 10000
a is b  # False
10000 is 10000  # True
```

We're seeing a cpython optimisation in the `10000 is 10000` check: instances of literals in the same statement may be reused within that statement.

Personally I expected some amount of referential transparency around the `is` statement, but it turns out not!

# Dataclasses are implemented with strings and `eval`

I was astonished - it's literally [just weaving some strings together](https://github.com/python/cpython/blob/4eab9da960d6944546baa76e3eed56b809ea8ec0/Lib/dataclasses.py#L496) and [calling `exec`](https://github.com/python/cpython/blob/4eab9da960d6944546baa76e3eed56b809ea8ec0/Lib/dataclasses.py#L498)!
I don't know it to be *incorrect*, but the sheer bluntness of the instrument amazed me.

# The six builtins

There are [six builtins in Python](https://docs.python.org/3/library/constants.html).
`True`, `False`, and `None` are unsurprising; `__debug__` is a bit odd to be one of the six privileged constants, but fine, I guess.

`NotImplemented` is bizarre and suggests whole areas that you should ignore to maintain your sanity.

Then there's `Ellipsis`, which is the object for which `...` is sugar.
It can, for some reason, be reassigned (when `True` etc can't)?
(This reassignment doesn't actually have an effect, because the syntax `...` somehow manages to evaluate to `Ellipsis` even when the name `Ellipsis` itself is being used for a global. I still don't really understand what's happening here.)

# Multiprocessing

Oh *lord* the number of problems I've seen with the passing of objects across `multiprocessing` boundaries.

# Annoying wart: violation of Liskov substitution principle with keyword args

When overriding a method on a class, you can't rename the arguments - even to underscores - because argument names are part of a method's usable API surface.
(Pyright warns about this.)
The safe way to mark a variable as unused in an overridden method is to have the first line of the method be a useless assignment, e.g. `_ = arg_name`.
