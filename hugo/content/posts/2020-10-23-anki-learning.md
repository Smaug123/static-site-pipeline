---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- g-research
- hacker-news
comments: true
date: "2020-10-23T00:00:00Z"
math: true
aliases:
- /anki-learning-superpower-computer-science/
title: Anki as Learning Superpower
summary: "Some techniques to help you get more out of Anki."
---

# Anki as Learning Superpower: computer science edition

*Cross-posted at the [G-Research official blog](https://www.gresearch.co.uk/article/anki-as-learning-superpower-computer-science-edition/); comments at [Hacker News](https://news.ycombinator.com/item?id=24878171).*

TL;DR: If you aren't using [Anki] or one of its siblings to remember what you learn, you are missing out on literal superpowers.
There are specific techniques which I've found helpful for using it to learn maths and computer science in particular.

This post will discuss extremely briefly what Anki is, but is mainly aimed at helping the student of maths or computer science to squeeze out some extra droplets of productivity from it.
If you aren't already familiar with Anki, go and read Michael Nielsen's post [Augmenting Long-Term Memory] as well or instead of this one; if you're short of time, the main value of the post to someone new to Anki is in the first one-eighth or so, up to but not including "Using Anki to thoroughly read a research paper in an unfamiliar field".
That essay gives a broad-strokes motivation for why one might want to use Anki at all. (Spoiler: it gives you a superhuman memory!)

## What is Anki?

[Anki] is a [spaced repetition system](https://en.wikipedia.org/wiki/Spaced_repetition): essentially a program that shows you flashcards at intervals tailored to help you remember their contents.
Such systems are based on the observation that while you can't stop memories from decaying, repeated exposure makes the decay exponentially slower.
So while you need to rehearse a fact frequently when you first come to learn it, reviews can become very sparse very quickly without losing much of your hard-won memory.

Anki is only one such system; other implementations such as SuperMemo and Mnemosyne exist.
There are also applications using the same principles for more specific goals; for example, Memrise is designed for language learning.
This post is phrased in terms of Anki, because for historical reasons that's the one I use.

# Acknowledgements and further reading

I've placed this section at the start, because I believe that spaced repetition is genuinely a superpower that anyone can acquire.
If I can't hold your interest in this post, I encourage you to glance over these other resources in the hope that one of them does the trick!

* [Augmenting Long-Term Memory] - a brief introduction to various memory systems with a particular focus on Anki. The money quote: "Anki makes memory a choice". If you choose to remember something, you can.

* [Quantum Country](https://quantum.country) - an introduction to quantum computation with integrated spaced-repetition flashcards, which comes with emailed reminders to use the site at intervals.
Even if you have no interest in quantum computation, I recommend skimming at least the first bits of the site, so that you can see what really good flashcards based on a text can look like. (Note that some of its cards are not ideal; the site does sometimes fall into the "yes/no" pattern, with flashcards whose answer is a bald "yes" or "no". Cards of this form aren't as good as cards which get you to reproduce actually content-based parts of a fact.)

* [The Twenty Rules of Formulating Knowledge in Learning](https://www.supermemo.com/en/archives1990-2015/articles/20rules) - the creator of the spaced-repetition system SuperMemo discusses how to formulate knowledge so that it sticks.
Again, even if you don't use spaced repetition, definitely read this; the advice is absolutely foundational to my understanding of how to learn.
A nontrivial amount of this very blog post is essentially specialising some of these rules to the case of maths and computer science.

* [Reddit: Medical School Anki](https://www.reddit.com/r/medicalschoolanki/), a subreddit with almost 55,000 subscribers at the time of writing. This link is here just to demonstrate that there are fields (such as medicine) in which Anki is very popular and nowhere near as niche as it is in most areas.

# General guidance: break things up, then break them up more

Absolutely crucial to the effective use of Anki for even a moderate collection of cards is that answering a card should be a single mental motion.

What does this mean?
We'll demonstrate with some positive and negative examples.

* "What is the capital of France?" is probably answered with a single mental motion: it's just "Paris", obtained by a simple lookup in your memory.
* "What is 367 times 399?" is many mental motions unless you are really unusually good at mental arithmetic. Almost everyone has to carry out some algorithm to get an answer to this question.
* "What is the composition of air?" is probably many mental motions: for example, a lookup of "which gases are in air?" and a number of motions like "what proportion of air is this specific gas?". Or it could be the various mental motions of "Which gas is the nth common in air, and what is its proportion in air?" as n varies.
* "What is the most common gas in air, and what is its proportion?" is very possibly a single mental motion despite the multiple components in its answer. For me, the knowledge that "nitrogen is the most common gas in air" is intimately bound up with "78% of air is nitrogen"; to answer one question is to access the same mental lump of storage as is required to answer the other question. Of course, for someone else, this may be two distinct facts and two distinct memory lookups.

A card that is answered with one mental motion may be multiple motions for someone else; and a question answered with many mental motions may become one motion after you learn some additional fact or part of the model that ties the facts together.
So it's helpful if you personally keep track of what you're doing to answer a given card, so that you can recognise some of this structure in your own mind.

Any card which is multiple mental motions should be broken down into smaller chunks.

If you're doing too much work to answer a card, it's important to notice, so that you can break the card down.
And don't worry that you might "break down a card too much"; if the cards are easy, Anki will exponentially decrease how often it shows them to you.
The cost of creating a card that's too easy is almost entirely in the time it takes you to create the card in the first place;
a card that's too difficult will sap your time and energy again and again.

# Specific guidance for maths: conditions on statements

As an example, recall the [ratio test for convergence], likely to be covered in any first course in analysis:

> Let \\(\sum_{n=1}^{\infty} a_n\\) be a complex series, with each \\(a_i\\) nonzero.
> Suppose that there is \\(a\\) such that \\(\vert \frac{a_{n+1}}{a_n}\vert \to a\\).
> Then, if \\(a < 1\\) then the series converges absolutely; if \\(a > 1\\) then the series diverges.

(We'll discuss its proof in a later section.)

This statement has a number of moving parts, and is definitely much too large to appear as a single card.
(Remember the rule of thumb: answering a single card should be a single mental motion.)
How could we formulate this statement in an Anki-friendly way?

My own personal Anki collection contains the following cards.
(Anki does allow LaTeX, though I often optimise for speed of card creation and just use plain text, however ugly it ends up.
As long as it's easily legible, it doesn't need to be pretty.)

* What conditions exist on the ratio test? (answer: nonzero, sequence of ratios has a limit)
* When does the ratio test let us conclude something? (answer: successive ratios converge to something not equal to 1)
* Which cases exist on the ratio test? (answer: ratios converge to less than, or greater than, 1)
* What can we say from the ratio test if the ratios converge to something less than 1? (answer: converges absolutely)
* What can we say from the ratio test if the ratios converge to something greater than 1? (answer: diverges)
* What can we say from the ratio test if the ratios converge to 1? (answer: nothing)
* Give an example where the ratio test is inconclusive. (answer: [harmonic series])

All these cards are very simple; perhaps they might look laughably simple.
This is fine! Remember that Anki will rapidly stop showing you cards you already know.
Crucially each card is really a single mental motion to answer.

Note also that information is duplicated between cards.
For example, there are two cards saying in slightly different ways that the ratio test talks about when successive ratios converge to something not equal to 1.
Again, it's fine to repeat information, because cards are cheap.
Here, the information is duplicated to better facilitate the links between the cards: one card is a general "when can we conclude anything", and one card is the same information rephrased as "which cases do I need to consider to produce more information here".
Without the additional rephrasing, there's more of a risk of developing "isolated" clusters of cards; the aim is that given just the prompt "ratio test", I can reproduce the *entire* cluster without thinking any further.

And don't forget to store key examples and counterexamples!

# Specific guidance for maths/computer science: conditions as part of definitions

Remembering a definition is rather like remembering the statement of a theorem.
Without further ado, here is my definition of a [red-black tree]:

* What, imprecisely, are the colouring rules on a red-black tree? ("global; local; base-case")
* What are the leaves of a red-black tree? ("null, black")
* What is the base-case colouring rule of a red-black tree? ("leaves are black")
* What is the local colouring rule of a red-black tree? ("red node => black children")
* What is the global colouring rule of a red-black tree? ("black depth is well defined")
* What is the black depth of a node in a red-black tree? ("the number of black nodes encountered on a path from that node down to a leaf")

Again, there is some duplication (two cards note that the leaves of a red-black tree are coloured black), and all the cards are extremely simple.
The point is to make sure both that the actual *content* is remembered, but also that the content is interlinked enough that you can reproduce the entire definition from the single prompt "red-black tree".
Moreover, one card is explicitly structural and carries no actual content as such: the card that lists the three types of colouring rule.
This card is there solely to allow me to remember which *cards* are relevant.

Naively, one might create instead a single card, "what is a red-black tree?".
But in my experience, this is too big.
If you're reviewing even 30 cards a day, and they're all as big as "what is a red-black tree?", you may very well get bored or start spending too long on reviews.
I personally review about 85 cards per day, all of them small; whenever I have a couple of minutes spare, I'll do a few cards.
If many of your cards are big, reviewing becomes an awful chore and it becomes very hard to make yourself put in even the small amount of time that's necessary to stay on top of it.

# Specific guidance for maths: remember waypoints, not proofs

It *is* possible to rote-learn text using Anki.
For example, I've learnt the first four chapters of the [Tao Te Ching] as 90 cards, each having the same structure: the front face is line 43 of the text, say, and the back face is line 44.
However, this is a task for which human memory is quite poorly suited: almost everyone learns best through association, creating large networks of interrelated facts that together form a coherent world-model, each fact boosting the memory of the others.

> To learn anything at all, it is better first to understand it, however vaguely.
> Don't jump straight to memorisation without first having the skeleton of a model on which to hang the facts you're memorising.

For much, much more on the nature of understanding proofs and how to use Anki, see the excellent blog post [Seeing Through a Piece of Mathematics](http://cognitivemedium.com/srs-mathematics) by Michael Nielsen.
Nielsen walks through a simple problem and discusses the possible ways one might understand it, and how one might use Anki to encode one's understanding.

So let's say you've understood a proof, and you now want to use Anki to immortalise the proof in your memory.
It may feel quite natural to try and rote-learn the proof; but this is a big waste of energy, since unstructured text does not play to the mind's strengths.
Instead, construct a map through the proof, placing waypoints as you go, then learn the waypoints.
Remember also that you can use cards which encode *structure* rather than *content*, if necessary, as discussed in the "what is a red-black tree?" example.

## Simple example: the ratio test

We defined the ratio test above; let's see how we might formulate its proof in an Anki-friendly way.

Here is one proof of the ratio test, copied almost verbatim from my university lecture notes.
It's not important to understand this fully, or even in any detail at all; I'm using it only as an example, for conversion into Anki cards.

> There are two cases: the sequence \\(\vert \frac{a_{n+1}}{a_n}\vert \\) tends to \\(a < 1\\) as \\(n \to \infty\\), or to \\(a > 1\\).
>
> Suppose first that \\(a > 1\\). Then there is some \\(M\\) such that beyond \\(a_M\\), all \\(a_{n+1}\\) are greater in absolute value than their \\(a_n\\). Therefore the sequence cannot tend to \\(0\\), so the series cannot converge.
>
> Suppose therefore that \\(a < 1\\). Pick any \\(r\\) between \\(a\\) and \\(1\\); then there is some \\(M\\) such that beyond \\(a_M\\), all \\(\vert \frac{a_{n+1}}{a_n}\vert  < r\\). So beyond \\(a_M\\), all \\(\vert a_n\vert \\) are less than \\(r^{n-M} \vert a_M\vert \\); but \\(\sum_{n=M}^{\infty} \vert a_M\vert  r^{n-M}\\) is a geometric series which converges, and so by the comparison test, \\(\sum_{n=M}^{\infty} \vert a_n\vert \\) converges. Since initial terms do not affect convergence, \\(\sum_{n=1}^{\infty} a_n\\) must converge absolutely. This completes the proof.

For me, the cards are as follows:

* What is the first step of the proof of the ratio test? (split into \\(a < 1\\) and \\(a > 1\\))
* What is the key idea in the proof of the ratio test, \\(a > 1\\)? (terms don't tend to 0)
* What is the key idea in the proof of the ratio test, \\(a < 1\\)? (pick \\(a < r < 1\\), comparison test after two adjustments)
* What is the first adjustment we make in the proof of the ratio test, \\(a < 1\\)? (ignore initial terms so all ratios < r)
* What is the second adjustment we make in the proof of the ratio test, \\(a < 1\\)? (divide out first term so all terms < r^n)
* What do we compare against in the proof of the ratio test, \\(a < 1\\)? (\\(r^n\\))

Using this, I can construct the following proof, which is in a little less detail than the original but which I could easily flesh out if required.

> Let the absolute value of the limit of \\(\frac{a_{n+1}}{a_n}\\) be \\(a\\). We split into two cases: \\(a < 1\\) and \\(a > 1\\).
>
> If \\(a > 1\\), the series is a summation of terms which do not tend to \\(0\\) (indeed, beyond a certain point the terms become strictly increasing in modulus), so it cannot converge.
>
> If \\(a < 1\\), select \\(r\\) between \\(a\\) and \\(1\\). Then because initial terms don't affect convergence, we can omit initial terms so that without loss of generality all \\(\frac{a_{n+1}}{a_n}\\) are less than \\(r\\) in modulus. Then we may divide out by \\(a_1\\) so that without loss of generality every \\(\vert a_n\vert  \leq r^n\\). Finally, the comparison test gives the required result.

Perhaps there are better ways to formulate these cards; it's never ideal to have to remember rather arbitrary lists such as "what is the first adjustment" and "what is the second adjustment".
But the "first and second adjustments" cards are safe for me to remember, because I remember them together spatially:
the first is a feeling of motion, translating the series to the left, and the second is a feeling of shrinking/squashing, dividing out the first term.
Possibly different people will find different and more personally effective ways to factor out the various components.

Notice that these cards encode hints rather than formal proof.
The aim is to set up the right structure, rather than to rehearse a proof verbatim.
Even if you're studying for an exam, you still should trust yourself to be able to do things without having explicitly memorised them!

# General guidance: prioritise ruthlessly, learn to recognise bad cards

The usual rule of thumb is that you spend 50% of your time on the hardest 5% of your flashcards.
A spaced repetition system will show you easy cards at exponentially decreasing frequency, so you'll rapidly stop reviewing your easiest cards.
But some cards just stubbornly refuse to be learned, so Anki will show them to you again and again in the hope that you'll get it this time (until eventually it gives up, marking the card automatically as a "leech", and stops ever showing it to you).

There will be cards that behave this way; that's just life.
Do keep an eye out for them; try and learn to recognise the mental state that is "urrgh, not this card again".
When you find a card that is showing up repeatedly, or that it's consistently an unpleasant effort to answer, or which you keep getting wrong:

1. Ditch the card! Do you really need to learn this fact anyway? There are so many other things out there to learn; do you have a good reason to spend your time on this one? Or might you be able to derive the contents of this card if necessary without even trying to memorise it?
2. Split up the card. Is it too big? Can you reduce the mental effort required to learn the card?
3. Make better mnemonics. Do you need to construct a different mental scene describing the card, or some clever phrase that sticks in your mind, or set something to music?
4. Revisit the basics. Are you getting this card wrong because your mental model for the entire subject is not sufficiently well-founded?

# Conclusion

I've left it to other people to persuade you to *use* Anki, but this was a whip around a few things to keep in mind so that you can get a bit more out of your Anki usage, especially when it comes to learning more complex technical concepts where it's not so obvious how to create the cards.
The art of Anki is easiest to learn by example; hopefully this has provided a couple more demonstrations to help fill out the arsenal.

[harmonic series]: https://en.wikipedia.org/wiki/Harmonic_series_(mathematics)
[red-black tree]: https://en.wikipedia.org/wiki/Red-black_tree
[Tao Te Ching]: https://en.wikipedia.org/wiki/Tao_Te_Ching
[ratio test for convergence]: https://en.wikipedia.org/wiki/Ratio_test
[Anki]: https://apps.ankiweb.net
[Augmenting Long-Term Memory]: http://augmentingcognition.com/ltm.html
