---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- awodey
comments: true
date: "2015-09-30T00:00:00Z"
math: true
aliases:
- /categorytheory/heyting-algebras/
- /heyting-algebras/
title: Heyting algebras
---

Now that we've had the definition of an exponential, we move on to the Heyting algebra, pages 129 through 131 of Awodey. This is still in the "exponentials" chapter. I stop shortly after the definition of a Heyting algebra, so as to move on to the more general stuff which is more relevant to the Part III course.

The first thing to come is the definition of an exponential \\(b^a\\) in a Boolean algebra \\(B\\) (regarded as a poset category). Without looking at the definition, I draw out a picture. We need to find \\(c^b\\) and \\(\epsilon: c^b \times b \to c\\) such that for all \\(f: a \times b \to c\\) there is \\(\bar{f}: a \to c^b\\) unique with \\(\epsilon \circ (\bar{f} \times 1_b) = f\\).

The first thing to note is that arrows are already unique if they exist, because we are in a poset category, so we don't have to worry about uniqueness of \\(\bar{f}\\). Then note that \\(f: a \times b \to c\\) is nothing more nor less than the statement that \\(a \times b \leq c\\) - that is, that the greatest lower bound of \\(a\\) and \\(b\\) is \\(\leq c\\), or that \\(c\\) is not a lower bound for both \\(a\\) and \\(b\\) simultaneously (assuming \\(a \times b \not = c\\)). The definition of \\(\bar{f}\\) is precisely the statement that \\(a \leq c^b\\), and \\(\epsilon\\) says precisely that the GLB of \\(c^b\\) and \\(b\\) is \\(\leq c\\).

In order to piece this together, we're going to want to know what the product of two arrows looks like. We're in a poset category, so it comes from "propagating the two arrows downwards until they hit a common basepoint, and taking that arrow": it is the arrow between the GLB of the domains and the GLB of the codomains. Therefore the product arrow \\(\bar{f} \times 1_B\\) is the arrow between the GLB of \\(a, b\\) and the GLB of \\(c^b, b\\).

![Product of arrows][arrow product]

Therefore the following picture is justified.

![Exponential in boolean category][exponential]

What could \\(c^b\\) be? If we let \\(f\\) be the arrow \\(\text{GLB}(c^b, b) \to c^b\\), then \\(\bar{f} = f\\), and \\(\bar{f} \times 1_b\\) is the identity arrow on that GLB. I don't know if this is helping, and I'm forced to look at the book.

The book gives \\(c^b\\) as \\((\neg b \vee c)\\), the LUB of \\(\neg b\\) and \\(c\\). This certainly does have an appropriate evaluation arrow and it is an exponential (having worked through the lines in the book), but I really don't see how one could have come up with that.

A Heyting algebra has finite intersections, unions and exponentials (where \\(a \Rightarrow b\\) is defined such that \\(x \leq (a \Rightarrow b)\\) iff \\((x \wedge a) \leq b\\)). What does this exponential really mean? In a Boolean algebra, it's an object which has as its subsets precisely those things which intersect with \\(a\\) to give a subset of \\(b\\). I can draw that in terms of a Venn diagram.

The distributive property holds, as I write out myself given the first line.

Now the definition of a complete poset (which I already know as "all subsets have a least upper bound"). Why is completeness equivalent to cocompleteness? In a Boolean algebra, this is easy because "join" is "complement-meet-complement". Actually, I'm now a bit confused: \\(\omega\\), the first infinite well-ordering, is not complete as a poset, but it certainly looks cocomplete. I check the definition of "complete" again to see if I'm going mad, and I see that it's "all limits exist", not just "\\(\omega\\)-limits exist". But then why does the book say "a poset is complete if it is so as a category - that is, if it has all set-indexed meets"? OK, \\(\omega\\) has a meet - namely \\(0\\) - but for it to have a join, we need \\(a \in \omega\\) such that for any \\(c \in \omega\\), have all elements of \\(\omega\\) are \\(\leq c\\) iff \\(a \leq c\\). Since \\(c+1 \not \leq c\\), we must have \\(a \not \leq c\\): that is, \\(a\\) is bigger than all members of \\(\omega\\). Therefore \\(\omega \subseteq \omega\\) doesn't have a join. Can we find a corresponding subset of \\(\omega\\) without a meet? No: the meet of any subset of a well-ordered set is just the least element. I'm horribly confused, so I've asked on [Stack Exchange]; the reply came that the corresponding meetless subset is \\(\emptyset\\), which I forgot to consider.

OK, let's try again. Suppose our poset has a meetless subset \\((a_i)\\) - that is, one which doesn't have a greatest lower bound. Remember, our poset might not have a terminal object, so actually we might have to change this into a proof by contradiction rather than contrapositive: let's assume all subsets have joins, so in particular there is a terminal object (the empty join). I would love to say "Then the corresponding complement of \\(\{ a_i \}\\) has no join, because its least upper bound is a greatest lower bound for \\(\{ a_i \}\\)", but \\(\{ 1 \} \subset \omega\\) has \\(1\\) as its LUB, but its complement has \\(0\\) as its GLB. However, what I could say is "Let \\(\{ b_i \}\\) be the set of elements which are less than every element of \\(a_i\\). This doesn't have a least upper bound, because that would be a GLB of \\(a_i\\)." That's better.

The power set algebra is certainly a complete Heyting algebra, as I mentioned above with the Venn diagram, or by Awodey's reasoning with the distributive law. The statement that Heyting algebras correspond to intuitionistic propositional calculus (where excluded middle may not apply) is pretty neat, but I'm afraid I'm still a bit lost.

The next section is on propositional calculus, where Awodey provides a set of axioms for intuitionistic logic.

At this point, I was told that exponentials don't really turn up in the Part III course, and since my aim here is to get an advantage in terms of the course, I'm skipping to the next chapter.

[arrow product]: {{< baseurl >}}images/CategoryTheorySketches/ArrowProduct.jpg
[exponential]: {{< baseurl >}}images/CategoryTheorySketches/ExponentialInBooleanAlgebra.jpg
[Stack Exchange]: http://math.stackexchange.com/q/1459373/259262
