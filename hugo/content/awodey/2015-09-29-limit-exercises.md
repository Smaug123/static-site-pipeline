---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- awodey
comments: true
date: "2015-09-29T00:00:00Z"
math: true
aliases:
- /categorytheory/limit-exercises/
- /limit-exercises/
title: Limits exercises
---

These are located on pages 114 through 118 of Awodey.

Exercise 1 follows by just drawing out the diagrams for the product and the pullback: they end up being the same diagram and the same UMP.

Exercise 2 a): \\(m\\) is monic iff \\(mx = my \Rightarrow x=y\\); the diagram is a pullback iff for all \\(x: A \to M\\) and \\(y: A \to M\\) with \\(m x = m y\\), have \\(z: A \to M\\) such that \\(my = mz = mz = mx\\).

Exercise 2 b): We can draw the cube line by line, checking that each pullback arrow exists, and ending up with a diagram.

![Pullback cube][pullback]

We still need the pullback of the pullback square to be a pullback square. If we can prove that \\(P\\) forms a pullback of \\(f \circ f^{-1}(\alpha), \beta\\) then we're done by the two-pullbacks lemma using the square with downward-arrow \\(f^{-1}(\beta): f^{-1}(B) \to Y\\). But it is: if we pull back the "diagonal square" \\(A \times_X B \to X\\) and \\(f\\), then we do get \\(P\\), and so all the commutative properties hold.

Exercise 2 c): this follows by drawing out the diagram. We pull back the "\\(m\\) is monic" square along \\(f\\) to obtain the "\\(m'\\) is monic" square; this is a pullback because of the "\\(f, m\\) pull back to \\(m'\\)" square.

Exercise 3: Let \\(x', y': R \to M'\\) with \\(m' x' = m' y'\\). Then \\(f m' x' = f m' y'\\); while labelling the unlabelled arrow in Awodey's diagram \\(\alpha\\), have \\(m \alpha x' = m \alpha y'\\) because the diagram commutes. But by monicness of \\(m\\), have \\(\alpha x' = \alpha y'\\). By the UMP of the pullback, there is a unique arrow \\(r\\) which arises \\(R \to M\\) such that \\(\alpha r = \alpha x'\\) and \\(m' r = m' x'\\), and so \\(r=x\\). Likewise \\(r=y\\) (since \\(\alpha y' = \alpha x'\\) and \\(m' x' = m' y'\\)). Hence \\(x=y\\).

Exercise 4: One direction is easy. Suppose \\(z \in_A M \Rightarrow z \in_A N\\). Let \\(z = m: M \to A\\). Then \\(M \in_A N\\) so \\(M \subseteq N\\).

Conversely, suppose \\(M \subseteq N\\) by means of \\(f: M \to N\\), and \\(z: Z \to A\\) gives \\(Z \in_A M\\). Then \\(z\\) lifts to \\(fz: Z \to N\\), and the entire diagram commutes as required.

Exercise 5 is apparently a duplicate of Exercise 4.

Exercise 6 is very similar in shape to some things we've already proved. Let \\(z: Z \to A\\) be such that \\(fz = gz\\). We need to find \\(\bar{z}: Z \to E\\) such that \\(e \bar{z} = z\\). Since \\(fz = gz\\), the arrow \\(Z \to B \times B\\) by \\(\langle f, g \rangle \circ z\\) is equal to the arrow \\(Z \to B \times B\\) given by \\(\langle 1_B, 1_B \rangle \circ f \circ z\\); so by the UMP of the pullback, there is \\(\bar{z}: Z \to E\\) with \\(e\bar{z} = z\\). That's all we needed.

Exercise 7: we need to show that \\(\text{Hom}_{\mathbf{C}}(C, L)\\) is a limit for \\(\text{Hom}_{\mathbf{C}}(C, \cdot) \circ D = \text{Hom}_{\mathbf{C}}(C, D): \mathbf{J} \to \mathbf{Sets}\\). Equivalently, we need to show that the representable functor preserves products and equalisers, so let \\(p_1: P \to A, p_2: P \to B\\) be a product in \\(\mathbf{C}\\). I claim that \\(p_1' : \text{Hom}_{\mathbf{C}}(C, P) \to \text{Hom}_{\mathbf{C}}(C, A)\\) by \\(p_1': f \mapsto p_1 f\\), and likewise \\(p_2': f \mapsto p_2 f\\), form a product. Indeed, let \\(x_1: X \to \text{Hom}_{\mathbf{C}}(C, A)\\) and \\(x_2: X \to \text{Hom}_{\mathbf{C}}(C, B)\\). Then \\(\langle x_1(z), x_2(z) \rangle\\) is of the form \\(\langle C \to A, C \to B \rangle\\) for all \\(z \in X\\), so there is a unique corresponding \\(C \to P\\) for each \\(z \in X\\). This therefore constructs a product.

Now the equalisers part. Let \\(e: E \to A\\) equalise \\(f, g: A \to B\\), and write \\(f^*, g^*\\) for the images of \\(f, g\\) under the representable functor. Let \\(x: X \to \text{Hom}_{\mathbf{C}}(C, A)\\) be such that \\(f^* x = g^* x\\). We need to lift \\(x\\) over \\(e^*\\). For each \\(z \in X\\), we have \\(x(z): C \to A\\) an arrow in \\(\mathbf{C}\\); this has \\(f \circ x(z) = g \circ x(z)\\), so \\(x(z)\\) lifts to unique \\(\overline{x(z)}: C \to E\\). This specifies a unique morphism \\(X \to \text{Hom}_{\mathbf{C}}(C, E)\\) as required.

Exercise 8: It seems intuitive that partial maps should define a category. However, let's go for it. There is an identity arrow - namely, the pair \\((\vert id_A \vert, A)\\). This does behave as the identity, because the pullback of the identity with anything gives that anything. The composition of arrows is evidently an arrow (because the composition of monos is monic). We just need associativity of composition, which comes out of drawing the diagrams of what happens when we do the triple composition in the two available ways. We can complete each of the two diagrams using the two pullbacks lemma, as in the picture.

![Partial maps associative][partial]

The map \\(\mathbf{C} \to \mathbf{Par}(\mathbf{C})\\) given by \\((f: A \to B) \mapsto (\vert f \vert, A)\\) is a functor: it respects the identity arrow by inspection, while composition is respected by just looking at the diagram. It is clearly the identity on objects, by definition of the partial-maps category.

![Partial maps functor is a functor][Partial maps functor]

Exercise 9: Diagrams is a category: identity arrows are just identity arrows from the parent category; the composition of commutative squares is itself a commutative square (well, rectangle); composing with the identity arrow doesn't change anything. Taking the vertex objects of limits does determine a functor: it takes the identity arrows to identity arrows because taking a diagram to itself means taking its unique limit vertex to itself. It respects domains/codomains, because… well, it just does: if \\(f: D_1 \to D_2\\) in Diagrams, then \\(\lim f\\) is uniquely specified to go from limit-vertex 1 to limit-vertex 2. (By the way, the intuition for what an arrow in this category is, is the placing of one diagram above another with linking arrows between the objects.) Better justification: there is a unique morphism between the limit vertices, because we can use the arrow to determine a collection of morphisms from one limit vertex to the other making \\(D_1\\) into a cone for \\(D_2\\).

The last part follows because \\(\mathbf{Diagrams}(I, \mathbf{Sets})\\) is isomorphic to \\(\mathbf{Sets}^I\\). Sets has all limits, so the theorem holds, and hence there is a product functor. This seems a little nonrigorous, but I can't put my finger on why.

Exercise 10: we've already seen this. I'll state it anyway. The copullback of arrows \\(f: A \to B\\) and \\(g: A \to C\\) is the universal \\(P\\) and arrows \\(p_1: B \to P, p_2: C \to P\\) such that for any \\(b: B \to Z, c: C \to Z\\) with \\(cg = bf\\), there is a unique \\(p: P \to Z\\) with \\(p p_1 = b, p p_2 = c\\), as in the diagram.

![Definition of a pushout][pushout]

The construction of a pushout with coequalisers and coproducts is done by taking the coproduct of \\(B\\) and \\(C\\), and coequalising the two sides of the square.

Exercise 11: To show that the diagram is an equaliser, we need to show that any \\(z: Z \to \mathbb{P}(X)\\), which causes the two \\(\mathbb{P}(r_i): \mathbb{P}(X) \to \mathbb{P}(R)\\) to be equal, factors through \\(\mathbb{P}(q): \mathbb{P}(Q) \to \mathbb{P}(X)\\). Any \\(z: Z \to \mathbb{P}(X)\\) is a selection of subsets of \\(X\\) for each element of \\(Z\\); the condition that it equalises \\(\mathbb{P}(r_1), \mathbb{P}(r_2)\\) is exactly the same as saying that if we take the \\(r_1\\)-inverse image and the \\(r_2\\)-inverse image of the result, then we get the same subset of \\(R\\). Can we make it assign an indicator function on \\(Q\\)? We're going to have to prove that \\(z: Z \to \mathbb{P}(X)\\) maps only into unions of equivalence classes, and then the map will descend. 

OK, we have "for each element of \\(Z\\), we pick out a subset of \\(X\\) which has the property that finding everything which that subset twiddles on the left, we get the same set as everything which that subset twiddles on the right". Suppose an element \\(a\\) is in the image of \\(z \in Z\\). Then we must have the entire equivalence class of \\(a\\) in the image set, because \\(\mathbb{P}(r_1)(\{ a \}) = \{ (a, x) \mid x \sim a \}\\) but \\(\mathbb{P}(r_2)(\{ a \}) = \{ (x, a) \mid x \sim a \}\\). These can't be equal unless the only thing in the equivalence class is \\(a\\). The reasoning generalises for when more than one thing is in the image set, by taking appropriate unions. Therefore the map does descend.

Exercise 12: the limit is such that for any cone, there is a unique way to factor the cone through the limit. What is a cone? It's a way of identifying a subshape of every element of the sequence, such that all other subshapes also appear in this limit subshape. But the only shape in \\([0]\\) is \\([0]\\), so the limit must be isomorphic to \\([0]\\).

The colimit must be \\(\omega\\). Indeed, a cocone is precisely an identification of a subset which contains an \\(\omega\\)-wellordered subset, and the colimit is the smallest \\(\omega\\)-well-ordered subset.

Exercise 13 a): The limit of \\(M_0 \to M_1 \to \dots\\) is just \\(M_0\\) - same reasoning as Exercise 12 - so it's an abelian group. It seems like the colimit should also be abelian. Let \\(C\\) be the colimit, and let \\(x, y \in C\\). I claim that there is some \\(n\\) such that \\(x, y \in M_n\\), whence we're done because \\(M_n\\) is abelian. (Strictly, I claim that there is \\(n\\) and \\(\alpha, \beta\\) such that \\(i_n(\alpha) = x, i_n(\beta) = y\\), where \\(i_n\\) is the inclusion.) It's enough to show that there is \\(m\\) and \\(n\\) such that \\(x \in M_m, y \in M_n\\), because then the maximum of \\(m, n\\) would do. If there weren't such an \\(m\\) for \\(x\\), we could take the cocone \\(C \setminus \{ x \}\\), and this would fail to factor through \\(C\\).

I then had a clever but sadly bogus idea: the second diagram is the same as the first but in the opposite category. Therefore by duality, we have that colimits <-> limits, so the limits and colimits are indeed abelian. This is bogus because the opposite category of Monoids is not Monoids, so we're not working the right category any more.

Let's go back to the beginning. The colimit is \\(N_0\\) by the same reasoning that made the limit of the \\(M_i\\) sequence be \\(M_0\\). That means it's an abelian group. Taking the limit of \\(N_0 \gets N_1 \gets \dots\\): our limit is a shape \\(L\\) which is in \\(N_0\\), which is itself an image of \\(N_1\\), which… This is a kind of generalised intersection, and the (infinite) intersection of abelian groups is an abelian group, so the intuition should be that the limit is also an abelian group.

Some on Stack Exchange [gave a cunning way to continue][SE], considering involutions \\(x \mapsto x^{-1}\\). I don't know if I'd ever have come up with that.

Exercise 13 b): now they are all finite groups. The limit of the \\(M_i\\) is \\(M_0\\), so this certainly has the "all elements have orders" property. The colimit of the \\(N_i\\) is \\(N_0\\), so likewise. The colimit \\(M\\) of the \\(M_i\\): every element \\(x\\) appears in some \\(M_x\\) (and all later ones) as above, and it must have an order in those groups, so it has an order in \\(M\\) too (indeed, each \\(M_i\\) is a subgroup of \\(M\\)). The limit of the \\(N_i\\): what about \\(C_2 \gets C_2^2 \gets C_2^3 \gets \dots\\), each arrow being the quotient by the first coordinate? No, the limit of that is \\(C_2^{\mathbb{N}}\\) in which every element has order 2. If we use \\(C_{n!}\\) instead? Ugh, I'm confused. I'll leave this for the moment and try to press on. If it becomes vital to understand limits in great detail in the time left before my course starts, I'll come back to this.

[pullback]: /images/CategoryTheorySketches/PullbackCube.jpg
[Partial maps functor]: /images/CategoryTheorySketches/PartialMapsFunctor.jpg
[partial]: /images/CategoryTheorySketches/PartialMapAssociative.jpg
[pushout]: /images/CategoryTheorySketches/PushoutDefinition.jpg
[SE]: https://math.stackexchange.com/a/1454266/259262
