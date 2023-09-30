---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
comments: true
date: "2016-04-13T00:00:00Z"
math: true
aliases:
- /independence-of-choice/
title: Independence of the Axiom of Choice (for programmers)
summary: So you've heard that the Axiom of Choice is magical and special and unprovable and independent of set theory, and you're here to work out what that means.
---

So you've heard that the Axiom of Choice is magical and special and unprovable and independent of set theory,
and you're here to work out what that means.
Let's not get too hung up on what the Axiom of Choice (or "AC") actually is, because you probably don't care.
Let's instead discuss what it means for something to be "independent".

Often I hear the layperson say things like "AC is unprovable".
This is true in a sense, but it's misleading.

Take an object \\(n\\) of the type "integer" - so \\(5\\), \\(-100\\), that kind of thing.
Here is what I will call the Positivity Hypothesis (or "PH"):

> \\(n\\) is (strictly) greater than \\(0\\).

Of course, depending on how we chose \\(n\\), PH might be true or it might be false, although it can't be both.
So, while maths might let us prove which of PH or not-PH holds for our given \\(n\\),
maths will emphatically not let us prove that PH is always true, and it will not let us prove that PH is always false.
(Maths would be stupid if it did that, because PH is neither always true nor always false.
The integers \\(5\\) and \\(-100\\) witness that PH can be true and can be false respectively.)

Therefore PH is independent of integer theory.
It's not magic: there is no god-given reason why PH mysteriously resists all efforts to prove it.
It's simply not always true, but it's not always false either.

Let's go back to the Axiom of Choice.

The usual system of set theory (which is used as a foundation for all of maths) is a collection of nine axioms,
together comprising what is known as ZF.
(If we add Choice to that collection as a tenth axiom, we obtain the set theory called ZFC.)
In the "integers" analogy above, "the integer type" plays the role of ZF.

Now, just as we may pick an object of type "integer", we may pick a set-theory of type "ZF".
A "set theory of type ZF" is my informal phrasing for what is usually called "a model of ZF".
(I'm eliding the question of the consistency of ZF, and I'll just assume it's consistent.)
In the "integers" analogy, the number \\(5\\) plays the role of one of these set theories,
as does the number \\(-100\\).
We can ask of this set theory whether it obeys AC (for which we substituted PH in the analogy).

And it turns out that for some models of set theory, AC holds, and for some models, it doesn't.
It's quite hard to describe models of set theory, because set theory supports so much complexity;
the integers are much easier to specify.
However, if you want the names of two models: in the model which contains precisely the "constructible sets", AC holds, while in Solovay's model, AC fails.

That's all there is to it.
Maths won't let us prove AC, because it's not true of every set theory of the type "ZF".
Maths won't let us prove AC is false, because there are some set theories of the type "ZF" in which it is true.
