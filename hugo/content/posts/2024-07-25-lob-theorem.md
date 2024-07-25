---
lastmod: "2024-07-25T19:48:00.0000000+01:00"
author: patrick
date: "2024-07-25T19:48:00.0000000+01:00"
title: Learning plan for "Program Equilibrium in the Prisoner's Dilemma"
summary: The questions whose answers I don't know, and the things I intend to learn, on the way to understanding a paper.
---

## Resources
The paper is [Program Equilibrium in the Prisoner's Dilemma](https://intelligence.org/files/ProgramEquilibrium.pdf).

A prerequisite is [Löb's theorem](https://en.wikipedia.org/wiki/L%C3%B6b's_theorem), for which Yudkowsky has a [cartoon guide](https://www.lesswrong.com/posts/ALCnqX6Xx8bpFMZq3/the-cartoon-guide-to-loeb-s-theorem).

One of the foundational papers is by Smullyan: [Logicians who reason about themselves](https://dl.acm.org/doi/pdf/10.5555/1029786.1029818).

## Questions I intend to answer

* Why can't we similarly prove that we're going to defect? "If it's provable that we defect, then we defect"?
* I had [an objection about "parametric bounded Löb"](/misc/ParametricBoundedLoeb2016/ParametricBoundedLoeb2016.pdf) ages and ages ago; do I still believe it?
* The paper currently works relative to a provability oracle; is it possible in principle for us to precompute and hand over proofs along with our source code? What would such a proof look like?
* Understand the [diagonal lemma](https://en.wikipedia.org/wiki/Diagonal_lemma).
* Understand Löb's theorem.
* Why does Wikipedia say that Smullyan refers to an agent as "modest" when 'such a reasoner can never believe "my belief in P would imply that P is true", without also believing that P is true'? Why that word?
* Can I get an intuition for what it would actually feel like to be an ideal agent going through the thought process of FairBot? (Or what it would mean to *be* PA computing the truth of a statement via Löb?)
* Fully and precisely write out the definition of FairBot and of PrudentBot in some pseudocode (permitting calls to `is_provable(expr)`).
* Comprehend the sentence: It is important that we look for proofs of `X(DB) = D` in a stronger formal system than we use for proving `X(PB) = C`; if we do otherwise, the resulting variant of PrudentBot would lose the ability to cooperate with itself.
* Are there any stronger conditions that will let us do somehow "better", by successfully defecting against more opponents, than PrudentBot? (Does this come down to tradeoffs about how easy it is for opponents to prove that you're going to cooperate with them?)
* Understand the scope of [MIRI's implementation](https://github.com/machine-intelligence/provability).
