---
lastmod: "2024-10-25T23:30:00.0000000+01:00"
author: patrick
categories:
- philosophy
date: "2024-10-25T23:30:00.0000000+01:00"
title: Mary's Room
summary: "Last weekend I was in a discussion ostensibly about whether the mind is nonphysical. Much of the discussion ended up as a rather polite shouting match about Mary's Room. Here is what I actually believe about it."
---

[Mary's Room](https://en.wikipedia.org/wiki/Knowledge_argument) is a standard thought experiment purporting to argue that "however much you know about the physical world in a forever-black-and-white environment, you still learn something new when you step out of the room and experience redness for the first time".
I, as a physicalist, do not accept this conclusion.
Here is why.

# A new quale is a new low-level label

If you've been thinking about something for a while, and have come to a detailed understanding of it, you might decide to write down a name for it in your notebook (or even in the dictionary).
That doesn't mean you've *discovered* a new word, or discovered anything new about the world in the act of writing it down.

Similarly, putting your world-simulating engine into a position where it simulates a phenomenon ("redness", traditionally) it's never simulated before doesn't necessarily cause you to "learn" anything new.
It's just that the same existing knowledge has been assigned a first-class primitive in the underlying mental architecture, so it's much easier to access.

Analogously to how you made it easier to think about a concept by giving it a word, your brain made it easier to think about redness by assigning it a primitive as soon as it first encountered something red.
(Or possibly that primitive was already assigned and waiting to be activated; perhaps redness is hard-coded specifically in the brain. If you think redness might be hard-coded, consider the smell of ammonia or similar instead, and substitute that learned quale wherever I talk about redness.) 

That primitive "always existed" in some mathematical sense, latent in the structure of the simulator, but it was previously not accessed or used.

Note that the set of available primitives is not fixed up front; the brain turhs out to have a *very large* supply of available slots!

# Why we have qualia

The new first-class primitive actually makes your reasoning *more sloppy* - things can "seem red" even though they "are not red" (in the sense that they don't emit the right wavelengths of light when irradiated with standard-test-compliant light) - but reasoning with this primitive is *much* faster than reasoning without it.
Thanks to natural selection, your brain's architecture is therefore predisposed to assign a primitive to it instantly on first encounter.

The term "[System 1](https://en.wikipedia.org/wiki/Thinking,_Fast_and_Slow)" is a shorthand for some of the reasoning that takes place using *only* these efficient primitives of the architecture.
It's much faster, because it's much less general: it can only use primitives that are already represented efficiently, and it can't take account of the ways in which those primitives are only approximations of the world (which is why optical illusions still "feel wrong" even when you know how they work).

# Qualia can also be learned the hard way

There are some concepts which *don't* get insta-compiled like redness does: for example, the notion of a group in mathematics is not one we're simply not hard-wired to convert instantly into a compatible form for System 1.
For a fuzzier example, the notion of "prime number" is one that people can *learn* a primitive for: a number can feel "more prime" or "less prime", and the more you work with prime numbers, the more you start "actually feeling" whether a number is prime and the more System 1 starts having opinions about primality.

On the other hand, it was very necessary in the ancestral environment to be able to reason quickly and intuitively about things like "*precisely* what chemicals are around me" or "what vibrations are happening near me"; so natural selection eventually predisposed the brain to go absolutely wild in immediately assigning unique highly-accessible identifiers to smells and sounds.

# Mary is a just-in-time compiler

Mary carefully built up a knowledge of redness through years of study.
She defined a symbolic representation - an [opcode](https://en.wikipedia.org/wiki/Opcode) - and became able to manipulate it through her System 2 reasoning process.

When Mary stepped out of the room, it's a bit like that opcode was suddenly [JIT](https://en.wikipedia.org/wiki/Just-in-time_compilation)-compiled into machine code, making it *extremely* accessible to System 1.
Her brain already came preloaded with a large unused space of appropriate instructions in the machine code architecture; the brain selected one of those instructions (perhaps at random, or perhaps in a way that's common across most humans thanks to common genes coding for precisely the necessary structure).
That JIT didn't happen until her brain actually received the input for the first time.

I have a more speculative claim, which isn't central to the argument but if true would simply refute Mary's Room entirely by showing that the experiment could never be performed: if she were well practised with meditation and dream-control and so forth, I claim she could make this JIT process happen without ever seeing red in the world.
As evidence, I gesture towards the fact that humans can enter the jhanas and find genuinely new experiences this way.
(However, it's possible that the human brain architecturally just can't induce these low-level hacks on itself. My bet is that it can, but if she can't, I think that's a reflection of her bounded access to her own hardware, rather than showing that there were some fundamentally non-physical truths.)

# Inverted spectrum

["Is my red the same as your red?"](https://en.wikipedia.org/wiki/Inverted_spectrum)

I don't know the answer to this empirical question.

* Is the "redness" opcode hardcoded, or is it randomly assigned from the wide available pool of qualia devoted to colour? (We could perhaps prove it to be hardcoded if we were able to identify specific parts of the genome which result in specific nerves carrying the red cones' signals to specific structures within the visual processing centre, and using techniques from mechanistic interpretability to identify that the presence of this structure causes redness to manifest the same way in all humans. Or perhaps it's not hardcoded!)
* Are the reasoning algorithms so perfectly isomorphic between humans that it's even meaningful to say that my quale *is the same as* your quale? (Again partly an empirical question; we could probably show this to be *false* if we could trace the execution of two brains finely enough and their representations turned out to be wildly divergent!) Perhaps two humans can simply have architectures which so fundamentally differ in how they model the world that it's *not* meaningful to say that they are "experiencing the same thing" when exposed to the same input. (Is the `ADD` instruction "the same" in aarch64 vs x86-64: do the two processors experience "the same operation", or does the wildly differing architecture make that a meaningless or false statement? Does it even matter, since they have the same result?)
