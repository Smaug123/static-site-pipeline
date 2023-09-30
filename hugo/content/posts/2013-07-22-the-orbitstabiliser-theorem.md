---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
comments: true
date: "2013-07-22T00:00:00Z"
math: true
aliases:
- /mathematical_summary/the-orbitstabiliser-theorem/
- /the-orbitstabiliser-theorem/
title: The Orbit/Stabiliser Theorem
---
The Orbit/Stabiliser Theorem is a simple theorem in group theory. Thanks to [Tim Gowers](https://gowers.wordpress.com/2011/11/09/group-actions-ii-the-orbit-stabilizer-theorem/) for the proof I outline here - I find it much more intuitive than the proof that was presented in lectures, and it involves equivalence relations (which I think are wonderful things).

Theorem: \\(\vert \{g(x), g \in G\} \vert \times \vert \{g \in G: g(x) = x\} \vert = \vert G \vert\\).

Proof: We fix an element \\(x \in G\\), and define two equivalence relations: \\(g \sim h\\) iff \\(g(x) = h(x)\\), and \\(g \cdot h\\) if \\(h^{-1} g \in \text{Stab}_G(x)\\), where \\(\text{Stab}_G(k) = \{g \in G: g(k) = k\}\\).

Now, these are the same relation (we will check that they are indeed equivalence relations - don't worry!). This is because \\(g \sim h \iff g(x) = h(x) \iff h^{-1}g(x) = x \iff h^{-1}g \in \text{Stab}_G(x) \iff g \cdot h\\).

And \\(\sim\\) is an equivalence relation, almost trivially: it is reflexive since \\(g \sim g \iff g(x) = g(x)\\) is obviously true; it is symmetric, since \\(g \sim h \iff g(x) = h(x) \iff h(x) = g(x) \iff h \sim g\\); it is transitive similarly.

Now, it is clear that the number of equivalence classes of \\(\sim\\) is just the size of the orbit \\(\{g(x), g \in G \}\\), because for each equivalence class there is one member of the orbit (with \\([g]\\) representing \\(g(x)\\)), and for each member of the orbit there is one equivalence class (with \\(g(x)\\) being represented solely by \\([g]\\)).

It is also clear that the size of the stabiliser \\(\text{Stab}_G(x)\\) is just the size of an equivalence class \\([g]\\) of \\(\cdot\\), since for each member \\(s\\) of the stabiliser, we have that \\(g \cdot (g s)\\) so \\(\vert [g] \vert \geq  \vert \text{Stab}_G(x) \vert"\\), while for each for each member \\(h\\) of \\([g]\\) we have that \\(h^{-1}g \in \text{Stab}_G(x)\\) by definition of \\(\cdot\\) - but all these \\(h^{-1}g\\) are different (because otherwise we could cancel a \\(g\\)) so \\(\vert [g] \vert \leq \vert \text{Stab}_G(x) \vert\\).

And the equivalence classes of \\(\sim \ = \cdot\\) partition the set \\(G\\), so (size of equivalence class) times (number of equivalence classes) is just \\( \vert G \vert\\) - but this is exactly what we required.
