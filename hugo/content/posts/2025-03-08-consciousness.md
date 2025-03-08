---
lastmod: "2025-03-08T13:30:00.0000000+00:00"
author: patrick
categories:
- philosophy
date: "2025-03-08T13:30:00.0000000+00:00"
title: A Bitcoin analogy for Multiple Drafts theory of consciousness
summary: "I've never actually seen anyone write down precisely the way I think about consciousness, so here it is: it's (gasp!) like a blockchain."
---

*This is basically Dennett's Multiple Drafts theory of consciousness as laid out in _Consciousness Explained_, Metzinger's self-model theory that the perception of a "self" is just another part of a model of the world, and Andy Clark's predictive processing theory; but with an additional trendy analogy to indicate a real-world proof-of-concept that Multiple Drafts systems can exist. Epistemic status: it's all vibes, bro. I think Claude thinks this post is bad.*

## Headline

There's no inherent single thread of consciousness; instead, it emerges as a best-effort attempt to record after-the-fact a coherent thread out of a much more confused jumble.
This coherent thread actually models *what you were* pretty well in a behavioural sense, though, so as a simplifying assumption it's reasonable to say that it's functionally "real", and we call it your "consciousness".
It's not a precise record of what you were experiencing, because it's only formed after the fact by discarding a great deal of information, but it's close enough that it's intuitive and useful to keep around in your memory.

## Background: Multiple Drafts, self-models, and predictive processing

The brain is a powerful prediction engine, with a single job: to model the world faithfully, [subject to certain constraints](https://en.wikipedia.org/wiki/Free_energy_principle) hard-wired by natural selection.
For example, the prediction that "my body is experiencing pain" is hard-wired to have low probability, with the result that the prediction engine's connections to the body cause the body's machinery to take actions that reduce the pain.
([One person's modus ponens is another person's modus tollens](https://gwern.net/modus): a strong prediction that the body is in a different place can cause the body to move to a different place, as the machinery which provides the evidence of location adjusts itself to validate the strong prediction coming in from the brain.)
This is Clark's predictive processing explanation for how a "mere" prediction engine can take actions in the world.

One of the things that's present in the world, and therefore within the purview of the brain, is the brain itself, and the body that it's located in.
Very early in development, or possibly in a move hard-coded by natural selection, the brain discovers that a pretty parsimonious explanation for what this brain and body tend to do is "this is an agent with desires", so the brain adopts that explanation pending strong evidence to the contrary.
(I have no opinion on where this "agents exist" modelling simplification/assumption comes from; I think it would be aesthetically neater for the new brain to learn from scratch that agents are a good model of the world, but when has natural selection ever chosen the neat answer? Claude says "Research by Meltzoff and others suggests that infants begin with innate mechanisms for social cognition rather than discovering agency". Anyway, this point is not central to my argument; I'm sure
the field of developmental psychology has an actual answer.)
This is basically part of Metzinger's self-model theory, that the existence of a "self" is something that is natural to derive simply by looking at the world and asking how to explain the data you receive from the world.

To model accurately an agent with desires, it's necessary to model that agent's desires and reasoning processes.
Any attempt to model *anything*, though, is subject to revision in the light of new incoming evidence, and in particular the brain's model of its own reasoning is constantly in flux.
Some of its models will prove to be pretty accurate, and some will not; the ones which are not are discarded, and the ones which are accurate get enshrined in memory.
These models are the "multiple drafts" of Dennett.

Importantly, the brain has no single one-true-model of itself at the time that it's making predictions; there are *only* the many models arising within the prediction engine, competing as all explanations do to explain the data.
Most of the models agree in many ways, because the brain is pretty good at its job, and those things get committed to memory quickly and confidently.
There are also many fringe parts of the predictions where the models disagree (because there's less evidence that would prove or refute noncentral parts of the model), and the memory system doesn't commit those quickly or at all.

The intuition of a single thread of personhood arises from the "intersection of all the models" being committed to memory: those features of the competing models of oneself which agree and explain the behaviour of this fictional "agent that exists in the world" that is you.
But this intersection is itself just the memory subsystem's best attempt to record a consistent model; there are many other possible such records, in principle, and it's down to simple accident which one gets "written down".
Moreover, memory is mutable, so even the one which got written down is constantly changing (usually only in little ways, but sometimes in huge ways).

## Speculative aside

*Epistemic status: Claude believes this section is false, because "research by Tore Nielsen and others on micro-awakenings and thought formation during sleep transitions (Nielsen, 2000, in Behavioral and Brain Sciences) suggests that the phenomenology of losing thoughts during sleep onset relates to reduced activity in the prefrontal cortex and default mode network, not to failures of memory commitment per se". This appears to be referencing
[A review of mentation in REM and NREM sleep: “Covert” REM sleep as a possible reconciliation of two opposing models](https://www.dreamscience.ca/en/documents/publications/_2000_Nielsen_BBS_23_851-866_c-rem.pdf). Perplexity believes that the paper does not support Claude's objection. The paper is pretty lengthy and dense, and I wanted to get this post out.*

You can sometimes actually feel the negative space when you *fail* to commit a memory, when you're falling asleep.
If you've had a train of thought which you simply lose because you're falling asleep, that's what it feels like when the intersection of some of these drafts fails to be committed.
You feel that there *was* a coherent self (the memory subsystem would normally have committed a record of what the simulated agent that is "you" was doing, and if it had done so, it would have become the basis of the coherent future "you"), but you have completely lost access to what that self was (the memory subsystem did not in fact commit anything).
This is probably a good thing, because pre-sleep thoughts can get pretty weird (i.e. contradictory with the usual self), and you probably don't want them to become foundational parts of yourself!

## The blockchain analogy

There's actually a Multiple Drafts system operating in the wild!
Perhaps by musing on what it might feel like to "be the blockchain", we can intuitively feel Multiple Drafts in action.

There is no single necessary consciousness, just as there is no single necessary history of the Bitcoin blockchain.
In the case of Bitcoin, a coherent history arises from the many validator nodes collectively agreeing on that history; but on short time horizons as the transactions are taking place, there is *no* coherent history.
Instead, there are leaves of the Merkle tree constantly springing into being (one for every validator node) and being discarded (when the node becomes convinced that it has lost the race to commit its suggestion of what the history should be).
These ephemeral leaves are equally "valid" as branches of history, but most of them are simply forgotten due to quirks of the distributed consensus algorithm: the nodes decide that *other* nodes are likely going to reject their attempts at history, so they abandon them quickly.

Similarly, in the brain there are many models of the world being postulated to explain current sense data, and in particular there are many models of the engine that is doing the prediction; and some of these models successfully continue predicting the world over short horizons, while some do not (and are discarded).
The memory subsystem tries to collect a coherent intersection of the successful models, and records this history, because it's valuable evidence about what the prediction engine (the self) is going to do in the future.
But there's no specific time when this happens; some detail gets cemented into history when the memory subsystem is confident in it, but this can be mutated years later, when you replay the memory and reconstruct what you think you must have been feeling at the time.
The models which the memory subsystem believes aren't correctly cohering with the "self" get discarded, just as the failed leaves of the Merkle tree are forgotten.

The brain is probably not as neat as the blockchain: we don't end up with (say) a thousand clearly-delineated models which are then filtered based on how well they predict incoming evidence, and explicitly chosen or rejected.
But I find this a compelling proof-of-concept that a coherent "history of the self" can arise from a wild cacophony of competing attempts to commit predictions of the self.

Is that history "real" despite being "merely emergent"?
Sure, if you like, although it's certainly very mutable.
For a start, there's the possibility of a "hard fork" (e.g. if you suddenly achieve religion and reinterpret your entire self).
But more commonly, because your memory isn't perfect, you have to rerun your model of yourself to some extent when replaying a memory, to fill in the gaps; and your model of yourself *now* is a bit different to your model of yourself *then*, so the replay isn't quite faithful (this is the "false memory" phenomenon studied by Elizabeth Loftus, where rehearsing history rewrites history).
That's not something that happens with the blockchain, of course, so in some sense the blockchain is "more real" as a persistent object than my consciousness is: the blockchain won't mutate its history as I try and study it.
