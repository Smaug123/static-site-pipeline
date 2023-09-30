---
lastmod: "2021-09-12T22:50:36.0000000+01:00"
author: patrick
categories:
- mathematical_summary
comments: true
date: "2016-05-25T00:00:00Z"
math: true
aliases:
- /finitistic-reducibility/
title: Finitistic reducibility
summary: A quick overview of the definition of the mathematical concept of finitistic reducibility.
---

There is a [Hacker News thread][HN] at the moment about [an article on Quanta][quanta]
which describes a paper which claims to prove that Ramsey's theorem for pairs is finitistically reducible.
That thread contains lots of people being a bit confused about what this means.
I wrote a comment which I hope is elucidating; this is that comment.

It is a fact of mathematics that there are some statements which are solely about finite objects,
but to prove them requires reasoning about an infinite object.
The [TREE function]'s well-definedness is one of them.
For a more accessible example than TREE, I think the [Ackermann function] falls into this category.
The Ackermann function \\(A(n+1, m+1) = A(n, A(n+1, m))\\) is well-defined for all \\(n\\) and \\(m\\)
(we prove this by induction over \\(\mathbb{N} \times \mathbb{N}\\)),
but the proof relies on considering the [lexicographic order][lex] on \\(\mathbb{N} \times \mathbb{N}\\)
which is inherently infinite.
(I'm not totally certain that all proofs of Ackermann's well-definedness rely on an infinite object,
but the only proof known to me does.)
Ackermann's function itself is in some sense a "finite" object,
but the proof of its well-definedness is in some sense "infinite".

Whatever the status of my conjecture that "you can't prove that Ackermann's function is well-defined without considering an infinite object",
it is [certainly a fact][ack not primrec] that Ackermann is not [primitive-recursive],
and "primitive-recursive functions" corresponds to the lowest level of the five "mysterious levels" the article talks about.

There are some mathematicians ("finitists") who don't believe that any infinite objects exist.
Such mathematicians will reject any proof that relies on an infinite object,
so their mathematics is necessarily less wide-ranging than the usual version.
Any result that shows that more things are finitistically true is good,
because it means the finitists get to use these facts the rest of us were already happy about.

So the analogy is as follows.
Imagine that we knew of this "infinitary" proof that Ackermann is well-defined,
but we hadn't proved that no "finitary" proof exists.
(So finitists are not happy to use Ackermann, because it might not actually be well-defined according to them:
any known proof requires dealing with an infinite object.)
Now, this paper comes along and proves that actually a finitary proof exists.
Suddenly the finitists are happy to use the Ackermann function.

Similarly, in real life, most mathematicians were quite happy to use \\(R_2^2\\) to reason about finite objects,
but the finitists rejected such proofs.
Now, because of the paper, it turns out that the finitists are allowed to use \\(R_2^2\\) after all,
because there is a purely finitistic reason why \\(R_2^2\\) is true.

The actual definition of TREE is a bit too long for me to explain here,
but it is an example of a function like Ackermann, which is well-defined,
but in fact if you're not allowed to consider infinite objects during the proof then it is provably impossible to prove that TREE is well-defined.
So the statement "TREE is well-defined" is, in some sense, "less constructive" or "more infinitary" than \\(R_2^2\\).


[HN]: https://news.ycombinator.com/item?id=11763080
[quanta]: https://www.quantamagazine.org/mathematicians-bridge-finite-infinite-divide-20160524
[TREE function]: https://en.wikipedia.org/wiki/Kruskal's_tree_theorem
[Ackermann function]: https://en.wikipedia.org/wiki/Ackermann_function
[lex]: https://en.wikipedia.org/wiki/Lexicographical_order
[primitive-recursive]: https://en.wikipedia.org/wiki/Primitive_recursive_function
[ack not primrec]: http://planetmath.org/ackermannfunctionisnotprimitiverecursive
