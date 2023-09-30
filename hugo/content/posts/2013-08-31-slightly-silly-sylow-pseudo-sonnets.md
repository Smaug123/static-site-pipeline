---
lastmod: "2022-01-01T22:20:19.0000000+00:00"
author: patrick
categories:
- creative
- mathematical_summary
comments: true
date: "2013-08-31T00:00:00Z"
math: true
aliases:
- /wordpress/archives/379/index.html
- /creative/mathematical_summary/slightly-silly-sylow-pseudo-sonnets/index.html
- /slightly-silly-sylow-pseudo-sonnets/index.html
title: Slightly silly Sylow pseudo-sonnets
---
This is a collection of poems which together prove the [Sylow theorems][1].

# Notes on pronunciation

* Pronounce \\( \vert P \vert \\) as "mod P", \\(a/b\\) or \\(\dfrac{a}{b}\\) as "a on b", and \\(=\\) as "equals".
* \\(a^b\\) for positive integer \\(b\\) is pronounced "a to the b".
* \\(g^{-1}\\) is pronounced "gee inverse".
* "Sylow" is pronounced "see-lov", for the purposes of these poems.
* \\(p\\) and \\(P\\) and \\(n_p\\) are different entities, so they're allowed to rhyme.

# [Monorhymic][4] Motivation [^notsonnet]

Suppose we have a finite group called \\(G\\).  
This group has size \\(m\\) times a power of \\(p\\).  
We choose \\(m\\) to have coprimality:  
the power of \\(p\\)'s the biggest we can see.  
Then One: a subgroup of that size do we  
assert exists. And Two: such subgroups be  
all conjugate. And \\(m\\)'s nought mod \\(n_p\\),  
while \\(n_p = 1 \pmod{p}\\); that's Three.

# Theorem One

## Little [Lemmarick][5]

*Subtitle: "The size of the normaliser \\(N\\) of a maximal \\(p\\)-subgroup \\(P\\) has \\(N/P\\) coprime to \\(p\\)"*

There was a \\(p\\)-subgroup of \\(G\\)  
(by Cauchy). The largest was \\(P\\).  
Let \\(N\\) normalise,  
Take \\(\dfrac{N}{P}\\)'s size,  
Suppose that it's zero mod \\(p\\).

---

Now \\(\dfrac{N}{P}\\) also has some  
p-subgroup (by Cauchy); take one.  
Take it un-projected,  
\\(P\\)'s most big? Corrected!  
We've found one sized \\(p \vert P \vert \\): done.

## Introductory Interlude (to the tune of "[Jerusalem](https://en.wikipedia.org/wiki/Jerusalem_%28hymn%29)")

*Subtitle: "\\(\{P\}\\) is an orbit of size \\(1\\) under the conjugation action of \\(P\\) on the set of \\(G\\)-conjugates of \\(P\\)"*

Let \\(X\\) be \\(P\\)'s orbit under \\(G\\)  
Acting by conjuga-ti-on.  
Mod \\(G\\) o'er \\(N\\)'s the size of \\(X\\)  
The Orbit/Stabiliser's done.  
And in its turn, \\(P\\) acts on \\(X\\)  
By conjugating, as before,  
Then \\(P\\) is certainly all alone:  
Its orbit is itself, no more.  

---

Let \\(gPg^{-1}\\) be alone,  
\\(P\\) stabilises it, and hence  
\\(pgPg^{-1}p^{-1}\\)  
Is \\(gPg^{-1}\\) - from whence  
We conjugate by \\(g^{-1}\\):  
\\(g^{-1}Pg\\) fixes \\(P\\).  
\\(g^{-1}Pg\\) is in \\(N\\),  
so \\(\pi\\) applies. From this, we'll see:

## [Cinquain][6] Claim [^cinquain]

*Subtitle: "\\(\{P\}\\) is the only orbit of size \\(1\\)"*

A claim:  
\\(\pi(g^{-1}Pg)\\) is \\({1}\\).  
Call it \\(K\\). If false, \\(p\\)  
divides \\( \vert K \vert \\),  
as \\(\pi\\)  
a hom [^hom].  
Also, \\( \vert K \vert \\)  
divides \\( \vert N/P \vert \\)  
(Lagrange). Then Lemmarick proves: \\(K\\)  
Is \\({1}\\).

## [Trochaic Tetrameter][7] Tying Together [^rhyme]

*Subtitle: "\\(\{P\}\\) is Sylow, since \\(G/N\\) has size coprime to \\(p\\)"*

\\(\pi\\) has kernel \\(P\\) - but also  
\\(K\\) is \\({1}\\), so lies inside it.  
\\(P\\) contains \\(g^{-1}Pg\\);  
Both have size \\(p^a\\). So
since they're finite, they're the same set.  
Any set alone in orbit  
must be \\(P\\). The class equation  
Tells us \\( \vert G \vert / \vert N \vert \\) is  
Just precisely \\(1 \pmod{p}\\). Then  
\\( \vert G \vert / \vert P \vert \\) is not a  
multiple of \\(p\\) because it's  
\\( \vert \dfrac{N}{P} \vert \\) multiplied by  
\\(\dfrac{ \vert G \vert }{ \vert N \vert }\\) and \\(p\\) can't  
possibly divide those two. So  
Maximal the power of \\(p\\) is:  
\\(P\\)'s a Sylow \\(p\\)-subgroup.  

# Theorem Two - Quad-[quatrain][8] [^quatrain]

A Sylow \\(p\\)-subgroup let \\(Q\\) be:  
a subgroup, size \\(p^a\\).  
Because it's the same size as was \\(P\\),  
it acts on \\(X\\) in the same way.

---

Mod \\(p\\), we have \\( \vert X \vert \\) is \\(1\\) -  
the orbits of \\(Q\\) will divide it;  
Now invoke the class equation:  
an orbit, size \\(1\\), lies inside it.  

---

We dub this one \\(gPg^{-1}\\),  
then \\(g^{-1}Qg\\)'s in \\(N\\).  
Projection works just as well in verse:  
\\(\pi(g^{-1}Qg)\\) is \\({1}\\).

---

The previous poem's our saviour:  
\\(g^{-1}Qg\\) is in \\(P\\).  
The Pigeonhole tells its behaviour:  
that \\(P\\) is \\(g^{-1}Qg\\).

# Theorem Three - Hindmost [Haiku][9] [^haiku]

\\( \vert X \vert \\): \\(1 \pmod{p}\\)  
Orbit \\(X\\) divides \\(G\\)'s size:  
We have proved the Third.

[^notsonnet]: This is not a sonnet - it is six lines too short, and is monorhymic rather than following a more varied rhyme scheme. I started out intending it to be a sonnet, but all the rhymes for "p", "G" and so forth were irresistible. "Power" is a monosyllable.

[^cinquain]: I use a form of reverse cinquain, with syllable count 2,8,6,4,2,2,4,6,8,2.

[^hom]: "Hom", of course, is short for "homomorphism". Imre Leader used it all the time, so I took it to be legitimate.

[^rhyme]: This section is unrhymed; although Shakespeare rhymes his tetrameter, Longfellow doesn't. The strong iambic nature of English makes enjambement very natural to write when you're constrained to trochees, so I have just gone with the flow.

[^quatrain]: Quatrains have a variety of allowable rhyme schemes, but I plumped for ABAB for the sake of variety. Yes, "N" rhymes with "one". For the purposes of scansion, pronounce each line as the first line of a limerick, with an optional weak syllable at the end if necessary.

[^haiku]: I know that a haiku should mention a season, etc - but that is a constraint I am willing to relax. Gareth pointed out that if "sum" and "size" were synonymous, then " \|X\| : 1 (mod p)/Orbit X divides G's sum/A proof of the Third" would mention the season "sum-A".

 [1]: {{< ref "2013-06-26-sylow-theorems" >}}
 [2]: http://tartarus.org/gareth/
 [3]: http://mmeblair.tumblr.com/post/61532912275/carnival-of-mathematics-102-my-summation-of-other
 [4]: https://en.wikipedia.org/wiki/Monorhyme
 [5]: https://en.wikipedia.org/wiki/Limerick_%28poetry%29
 [6]: https://en.wikipedia.org/wiki/Cinquain
 [7]: https://en.wikipedia.org/wiki/Trochaic_tetrameter
 [8]: https://en.wikipedia.org/wiki/Quatrain
 [9]: https://en.wikipedia.org/wiki/Haiku
