---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- awodey
comments: true
date: "2015-08-19T00:00:00Z"
math: true
aliases:
- /categorytheory/what-is-a-category/
- /what-is-a-category/
title: What is a Category?
---

This post will cover the initial "examples" section of [Category Theory]. Because there aren't really very deep concepts in this section, this is probably a less interesting post to read than the others in this series.

The introduction lasts until the bottom of page 4, which is where a *category* is defined. I read the definition in a kind of blank haze, not really taking it in, but I was reassured by the line "we will have plenty of examples very soon". On re-reading the definition, I've summarised it into "objects, arrows which go from object to object, associative compositions of arrows, identity arrows which compose in the obvious way". That's a very general definition, as the text points out, so I'm just going to wait until the examples before trying to understand this properly.

The first example is the category of sets, with arrows being the functions between sets. That destroys my nice idea that "a category can be represented by a [simple (directed) graph][simple graph] together with a single identity arrow on each node": indeed, there are lots and lots of functions between the same two sets, and indeed more than one arrow \\(A \to A\\). I'll relax my mental idea into "directed multigraph".

Then there's the category of finite sets. I'll just check that's a category - oh, it's actually really obvious and there's not really anything to check.

Then the category of sets with injective functions. The "is this a category" check is done in the text.

What about surjective functions? The composition of surjective functions is surjective, and the identity function is surjective, so that does also form a category.

The first exercise in the text is where the arrows are \\(f: A \to B\\) such that \\(f^{-1}(b) \subset A\\) has at most two elements. (A moment of confusion before I realise that this is almost the definition of "injective".) That's clearly not a category: the composition of two of those might fail to satisfy the property. For instance, \\(f: \{0, 1, 2, 3 \} \to \{0, 1\}\\) the "is my input odd" function, and \\(g: \{0, 1\} \to \{0\}\\) the constant function; the composition of these is the constant zero function which is four-to-one.

Now comes the category of posets with monotone functions. Not much comes to mind about that.

The category of sets with binary relations as the arrows is one that is less intuitive for me, mainly because I'm still not used to thinking of relations \\(\sim\\) (such that \\(x \in X\\) may \\(\sim y \in Y\\)) as subsets of \\(X \times Y\\). The identity arrow is easy enough: it's the obvious "equality" relation that \\(a \sim a\\) only. The composition is a little less obvious: \\(a (S \circ R) c\\) iff there is \\(b\\) such that \\(a S b\\) and \\(b R c\\). Can I come up with an example of that? Let \\(S = \ \leq\\) on \\(\mathbb{R}\\), and \\(R = \ \geq\\). Then \\(S \circ R\\) is just the "everything is related" relation, since we may either let \\(b=a\\) or \\(b=c\\) depending on whether \\(a \leq c\\) or \\(a \geq c\\). OK, I'm a bit happier about that. It's easy to show that we have a category.

Then comes a matrices example (which I've simplified from the textual example), where the objects are natural numbers - possibly repeated - and the arrows are integer matrices of the right dimensions that matrix multiplication is defined. I thought that was a pretty neat example.

Finite categories: the book gives the definitions of \\(0\\), \\(1\\), \\(2\\) and \\(3\\). There's an obvious way to extend this to higher natural numbers. The section about "we may specify a finite category by just writing down a directed graph and making sure the arrows work" rings a strong bell with [free group]s, and indeed, the book calls them "free categories".

Now we come to the definition of a "functor", which I immediately parse as a "category homomorphism" and move on. (Questions which come to mind: are any of the above categories related by some functor? I don't care much about that for the moment.)

Preorders form a category which is drawn in almost exactly the same way as the Hasse diagram for a partial order (omitting identity arrows). That's a category in which the arrows are representing relation rather than domain/codomain.

The topological-space example I skipped because I didn't know what a \\(T_0\\) space was. (However, the specialisation ordering I did observe to be trivial on sufficiently separated spaces.)

Example from the category of proofs in a particular deductive system: the identity arrow \\(1_{\phi}\\) should be the trivial deduction \\(\phi\\) from premise \\(\phi\\). Very neat. It rings a bell from what I've heard of the [Curry-Howard isomorphism], and indeed the next example makes me think even more strongly of that.

Discrete category on a set: yep, checks out. I should verify that they are posets, which they are: the poset with order relation "almost nothing is comparable".

Monoids: oh dear, this example looks long. OK, I know what a monoid is ("group without inverses"), but how is it a category? Little mental shift of gear to thinking of elements as arrows, and it all becomes clear. The "free category" relations from earlier, then, correspond to the "free group" relations on the generators. I check that the set of functions \\(X \to X\\) actually a monoid, which it is. It seems easier to view it as a subcategory of the category of sets; and lo and behold the next paragraph points this out. We get to the bit about "monoid homomorphisms" - yes, they are indeed functors, which is not at all unexpected given that my understanding of "functor" is "category homomorphism", and monoids are categories.

## Summary
This is actually the second time I've read this section - the first time was before I had the idea of blogging my progress - and now I think I've got a good feel for what a category is. The next section is titled "Isomorphisms", which should give me a better idea of which categories are "the same". I noticed that the integers (when implemented as categories) seem to form a preorder, and indeed a poset; this corresponds nicely with their implementation as finite ordinals, with \\(3 = \{2\}\\) and so forth. I like seeing things crop up in different implementations all over the place like that.


[Category Theory]: http://ukcatalogue.oup.com/product/9780199237180.do
[simple graph]: https://en.wikipedia.org/wiki/Graph_(mathematics)#Simple_graph
[free group]: https://en.wikipedia.org/wiki/Free_group
[Hasse diagram]: https://en.wikipedia.org/wiki/Hasse_diagram
[Curry-Howard isomorphism]: https://en.wikipedia.org/wiki/Curry%E2%80%93Howard_correspondence
