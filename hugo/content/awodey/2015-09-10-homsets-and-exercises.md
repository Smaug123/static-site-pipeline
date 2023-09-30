---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- awodey
comments: true
date: "2015-09-10T00:00:00Z"
math: true
aliases:
- /categorytheory/homsets-and-exercises/
- /homsets-and-exercises/
title: Hom-sets and exercises
---

This is on pages 48 through 52 of Awodey, covering the hom-sets section and the exercises at the end of Chapter 2. Only eight more chapters after this, and I imagine they'll be more difficult - I should probably step up the speed at which I'm doing this.

Awodey assumes we are working with locally small categories - recall that such categories have "given any two objects, there is a bona fide set of all arrows between those objects". That is, all the hom-sets are really sets.

We see the idea that any arrow induces a function on the hom-sets by composing on the left. Awodey doesn't mention currying here, but that seems to be the same phenomenon. Why is the map \\(\phi(g): g \mapsto (f \mapsto g \circ f)\\) a functor from \\(C\\) to the category of sets? I agree with the step-by-step proof Awodey gives, but I don't really have intuition for it. It feels a bit misleading to me that this is thought of as a functor into the category of sets, because that category contains many many more things than we're actually interested in. It's like saying \\(f: \mathbb{N} \to \mathbb{R}\\) by \\(n \mapsto n\\), when you only ever are interested in the fact that \\(f\\) takes integer values. I'm sure it'll become more natural later when we look at representable functors.

Then an alternative explanation of the product construction, as a way of exploding an arrow \\(X \to P\\) into two child arrows \\(X \to A, X \to B\\). A diagram is a product iff that explosion is always an isomorphism. Then a functor preserves binary products if it… preserves binary products. I had to draw out a diagram to convince myself that \\(F\\) preserves products iff \\(F(A \times B) \cong FA \times FB\\) canonically, but I'm satisfied with it.


# Exercises

Exercises 1 and 2 I've [done already][epis-monos]. The uniqueness of inverses is easy by the usual group-theoretic argument: \\(fg = f g'\\) means \\(gfg = gf g'\\), so \\(g = g'\\) by cancelling the \\(g f = 1\\) term.

The composition of isos is an iso: easy, since \\(f^{-1} \circ g^{-1} = (g \circ f)^{-1}\\). \\(g \circ f\\) monic implies \\(f\\) monic and \\(g\\) epic: follows immediately by just writing out the definitions. The counterexample to "\\(g \circ f\\) monic implies \\(g\\) monic" can be found in the category of sets: we want an injective composition where the second function is not injective. Easy: take \\(\{1 \} \to \mathbb{N}\\) and then \\(\mathbb{N} \to \{ 1 \}\\). The composition is the identity, but the second function is very non-injective.

Exercise 5: a) and d) are equivalent by definition of "iso" and "split mono/epi". Isos are monic and epic, as we've already seen in the text (because we can cancel \\(f\\) in \\(x f = x' f\\), for instance), so we have that a) implies b) and c). If \\(f\\) is a mono and a split epi, then it has a right-inverse \\(g\\) such that \\(fg = 1\\); we claim that \\(g\\) is also a left-inverse. Indeed, \\(f g f = f 1\\) so \\(g f = 1\\) by mono-ness. Therefore b) implies a). Likewise c) implies a).

Exercise 6: Let \\(h: G \to H\\) be a monic graph hom. Let \\(v_1, v_2: 1 \to G\\) be homs from the graph with one vertex and no edges. Then \\(h v_1 = h v_2\\) implies \\(v_1 = v_2\\), so in fact \\(h\\) is injective. Likewise with edges, using the graph with one edge and two vertices, and the graph with one edge and one vertex. Conversely, suppose \\(h: G \to H\\) is not monic. Then there are \\(v_1: F_1 \to G, v_2: F_2 \to G\\) with \\(h v_1 = h v_2\\) but \\(v_1 \not = v_2\\). Since \\(h v_1 = h v_2\\), we must have that "their types match": \\(F_1 = F_2\\). We will denote that by \\(F\\). Then there is some vertex or edge on which \\(v_1\\) and \\(v_2\\) have different effects. If it's a vertex: then \\(v_1(v) \not = v_2(v)\\) for that vertex \\(v\\), but \\(h v_1 (v) = h v_2(v)\\), so \\(h\\) can't be injective. Likewise if it's an edge.

Exercises 7 and 8 I've [done already][epis-monos].

Exercise 9: the epis among posets are the surjections-on-elements. Let \\(f: P \to Q\\) be an epi of posets, so \\(x f = y f\\) implies \\(x = y\\). Suppose \\(f\\) is not surjective, so there is \\(q \in Q\\) it doesn't hit. Then let \\(x, y: Q \to \{ 1, 2 \}\\), disagreeing at \\(q\\). We have \\(x f = y f\\) so \\(x, y\\) must agree at \\(q\\). This is a contradiction. Conversely, any surjection-on-elements is an epi, because if \\(x(q) \not = y(q)\\) then we may write \\(q = f(p)\\) for some \\(p\\), whence \\(x f(p) \not = y f(p)\\). The one-element poset is projective: let \\(s: X \to \{1\}\\) be an epi (surjective), and \\(\phi: P \to \{ 1 \}\\). Then \\(X\\) has an element, \\(u\\) say, since \\(s\\) is surjective. Then we may lift \\(\phi\\) over \\(s\\) by letting \\(\bar{\phi}: p \mapsto u\\), so that the composite \\(s \circ \bar{\phi} = \phi\\). (Quick check in my mind that this works for \\(P\\) the empty poset - it does.)

Exercise 10: Sets (implemented as discrete posets) are projective in the category of posets: the one-element poset is projective, and retracts of projective objects are projective. Let \\(A\\) be an arbitrary discrete poset. Define \\(r: 1 \to A\\) by selecting an element, and \\(s: A \to \{1\}\\). Then \\(A\\) is a retraction of \\(B\\), so is projective. Afterwards, I looked in the solutions, and Awodey's proof is much more concrete than this. I [asked on Stack Exchange][SE question] whether my proof was valid, and the great Qiaochu Yuan himself pointed out that I had mixed up what "retract" meant, and had actually showed that \\(\{1\}\\) was a retract of \\(A\\). Back to the drawing board.

Exercise 10 revisited: Take a discrete poset \\(P\\), and let \\(f: X \to P\\) be an epi - that is, surjection. Let \\(A\\) be a poset and \\(\phi: A \to P\\) an arrow (monotone map). For each \\(a \in A\\) we have \\(\phi(a)\\) appearing in some form in \\(X\\); pick any inverse image \\(x_a\\) such that \\(f(x_a) = \phi(a)\\). I claim that the function \\(a \mapsto x_a\\) is monotone (whence we're done). Indeed, if \\(a \leq b\\) then \\(\phi(a) \leq \phi(b)\\) so \\(f(x_a) \leq f(x_b)\\) so \\(x_a \leq x_b\\) because \\(f, \phi\\) are monotone.

Example of a non-projective poset: let \\(A = P\\) be the poset \\(0 \leq 1 \leq 2\\), and let \\(i:A \to P\\) the inclusion. Let \\(E\\) be the poset \\(0 \leq 2, 1 \leq 2\\), with its obvious inclusion as the epi. Then \\(i\\) doesn't lift across that epi, because \\(0_A\\) must map to \\(0_E\\) and \\(1_A\\) to \\(1_E\\), but \\(0 \leq_A 1\\) and \\(0 \not \leq_E 1\\).

Now, all projective posets are discrete: suppose the comparison \\(a < b\\) exists in the poset \\(P\\), and let \\(X\\) be \\(P\\) but where we break that comparison. Let the epi \\(X \to P\\) be the obvious inclusion. Then the inclusion \\(\text{id}: P \to P\\) doesn't lift across \\(X\\).

Exercise 11: Of course, the first thing is a diagram. An initial object in \\(A-\mathbf{Mon}\\) is \\((I, i)\\) such that there is precisely one arrow from \\((I, i)\\) to any other object: that is, precisely one commutative triangle exists. A free monoid \\(M(A)\\) on \\(A\\) is such that there is \\(j: A \to \vert M(A) \vert\\), and for any function \\(f: A \to \vert N \vert\\) there is a unique monoid hom \\(\bar{f}: M(A) \to N\\) with \\(\vert \bar{f} \vert \circ j = f\\). If \\((I, i)\\) is initial, it is therefore clear that \\(I\\) has the UMP of the free monoid on \\(A\\), just by looking at the diagram. Initial objects are unique up to isomorphism, and free monoids are too, so we automatically have the converse.

Exercise 12 I did in my head to my satisfaction while I was following the text.

Exercise 13: I wrote out several lines for this, amounting to showing that the unique \\(x: (A \times B) \times C \to A \times (B \times C)\\) guaranteed by the UMP of \\(A \times (B \times C)\\) is in fact an iso. The symbol shunting isn't very enlightening, so I won't reproduce it here.

Exercise 14: the UMP for an \\(I\\)-indexed product should be: \\(P\\) with arrows \\(\{ (p_i: P \to A_i) : i \in I \}\\) is a product iff for every object \\(X\\) with collections \\(\{ (x_i: X \to A_i) : i \in I \}\\) of arrows, there is a unique \\(x : X \to P\\) with \\(p_i \circ x = x_i\\) for each \\(i \in I\\). Then in the category of sets, the product of \\(X\\) over \\(i \in I\\) satisfies that for all \\(T\\) with \\( \{ (t_i: T \to X): i \in I \}\\) arrows, there is a unique \\(t: T \to P\\) with \\(p_i \circ t = t_i\\). If we let \\(P = \{ f: I \to X \} = X^I\\), we do get this result: let \\(t(\tau) : i \mapsto t_i(\tau)\\). This works if \\(p_i \circ (\tau \mapsto (i \mapsto t_i(\tau))) = (\tau \mapsto t_i(\tau))\\), so we just need to define the projection \\(p_i: X^I \to X\\) by \\(p_i(i \mapsto x) = x\\). I think that makes sense.

Exercise 15: I first draw a diagram. \\(\mathbb{C}_{A, B}\\) has a terminal object iff there is some \\((X, x_1, x_2)\\) such that for all \\((Y, y_1, y_2)\\), there is precisely one arrow \\((Y, y_1, y_2) \to (X, x_1, x_2)\\). \\(A\\) and \\(B\\) have a product in \\(\mathbb{C}\\) iff there is \\(P\\) and \\(p_1: P \to A, p_2: P \to B\\) such that for every \\(x_1: X \to A, x_2: X \to B\\) there is unique \\(x: X \to P\\) with the appropriate diagram commuting. If we let \\((Y, y_1, y_2) = (P, p_1, p_2)\\) then it becomes clear that if \\(A, B\\) have a product then \\(\mathbb{C}_{A, B}\\) has a terminal object - namely \\((Y, y_1, y_2)\\). Conversely, if \\(\mathbb{C}_{A, B}\\) has a terminal object \\((Y, y_1, y_2)\\), then our unique arrow \\(x: X \to Y\\) in \\(\mathbb{C}_{A, B}\\) corresponds to a unique product arrow in \\(\mathbb{C}\\), so the UMP for products is satisfied.

Exercise 16: Is this really as easy as it looks? The product functor takes \\(a: A, b: B \mapsto \langle a, b \rangle : A \times B\\). Maybe I've misunderstood something, but I can't see that it's any harder than that. There's a functor \\(X \mapsto (A \to X)\\), given by coslicing out by \\(A\\). I've squinted at the answers Awodey supplies, and this isn't an exercise he gives. I'll just shut my eyes and pretend this exercise didn't exist.

Exercise 17: The given morphism is indeed monic, because \\(1_A x = 1_A y\\) implies \\(x = y\\), and \\(\Gamma(f)x = \Gamma(f)y\\) implies \\(1_A x = 1_A y\\) because of the projection we may perform on the pair \\(\langle 1_A, f \rangle\\). \\(\Gamma\\) is a functor from sets to relations, clearly, but we've already done that in Section 1 question 1b).

Exercise 18: It would really help if Awodey had told us what a representable functor was, rather than just giving an example. Is he asking us to show that "the representable functor of Mon is the forgetful functor"? I'm going to hope that I can just drop Mon in for the category C in section 2.7. If we let \\(A\\) be the trivial monoid, then \\(\text{Hom}(A, -)\\) is a functor taking a monad \\(M\\) to its set of underlying elements (each identified with a different hom \\(\{ 1 \} \to M\\)) - but hang on, there's only one such hom, so that line is nonsense. It would work in Sets, but not in Mon. We need \\(\text{Hom}(M, N)\\) to be isomorphic in some way to the set \\(\vert N \vert\\), and I just don't see how that's possible. Infuriatingly, this exercise doesn't have a solution in the answers section. I ended up looking this up, and the trick is to pick \\(M = \mathbb{N}\\). Then the homomorphisms \\(\phi: \mathbb{N} \to N\\) precisely determine elements of \\(N\\), by \\( \phi(1)\\). So that proves the result. Why did I not think of \\(\mathbb{N}\\) instead of \\(\{ 1 \}\\)? Probably just lack of experience.

[epis-monos]: {% post_url 2015-09-02-epis-monos %}
[SE question]: http://math.stackexchange.com/q/1429746/259262
