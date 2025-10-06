---
lastmod: "2025-10-06T22:59:00.0000000+01:00"
author: patrick
categories:
- programming
date: "2025-10-06T22:59:00.0000000+01:00"
title: LLMs sanding off the edges
summary: "I'm a bit concerned about a failure mode that is increasingly arising with LLMs: the divorce between how something looks, and its quality."
---

*This post is in the form of several distinct facts, and then a synthesis of vague creeping unease.*

# A sense of taste may be trained to match style

It used to be the case that you could get some sense of something's quality by seeing whether it "looked OK".
This was certainly not a perfect way to judge something - indeed, proverbially one must not judge a book by its cover - but the years have granted me what I'll call a somewhat idiosyncratic "sense of taste",  and my System 1 feels that things are "tasteful" or not.

System 1 isn't great at thinking about complicated things, so I suspect a lot of what it's picking up on is style; sometimes literally in the sense of "which words were used", but sometimes of the form "this design is composed of primitives that feel a bit grating", and sometimes "there's a bug or inconsistency here which I think you wouldn't have written if you truly understood the platonically correct form of the problem".

# LLMs can translate style

LLMs are excellent at translating between styles.

* "This is how I'd describe to a friend what I want to say; please convert it to [Dangerous Professional](https://x.com/patio11/status/1162561822248992768?lang=en-GB)."
* "Please select your words and phrasing with artistry, using elegant and precise learnèd language, picking the right words for the job assuming the reader has an excellent vocabulary and will understand any cultural or scientific allusions you make."
* "Condense this fluffy blog into three sentences."

# Sonnet 4.5 hits a specific style

The first LLM I've interacted with which really nails the "experienced and competent software engineer" vibe is Sonnet 4.5.
I still don't trust it to write code without supervision - I've not been super happy with its output - but it's the first model which has convincingly and (I think) correctly helped with the architecture of my current side project.
It speaks with a strong air of competence, where previous models spoke with the air of someone trying to project competence; it's actually coming close to a superstimulus for me in that regard (although I have observed it making design errors, so System 2 at least knows I need to keep fact-checking).

# GPT-5 is great at spotting bugs

For a while now at work I've been using a little PR-review bot that basically feeds stuff into GPT-5.
It's really excellent, and I've started using something very similar at home.
I might even say GPT-5 is in the top 5% of code reviewers for the specific sub-slice of code review that is "find the localised non-architectural bugs in this code, and proof-read it for typos, omissions, and documentation inconsistencies".

I do *not* trust GPT-5 to have any design taste (I trust Sonnet 4.5 a little more on that axis).

# "The Most Forbidden Technique"

Zvi Mowshowitz uses the term "The Most Forbidden Technique" to refer to the AI alignment strategy of identifying some signal of misalignment, and then training your model to stop displaying that signal, in the hope that this will train away the misalignment.
(Naturally the expected effect is actually to train the model to hide the misalignment from you, all while greatly improving your "alignment metrics"; hence the "Most Forbidden" name.)

# The ominous synthesis

But I've been getting nervous about using GPT-5 as a reviewer in conjunction with using Claude Code to *write* code.
Naively adopting a loop of "Claude writes some code; GPT-5 reviews it; repeat", you can eventually end up with code that both Claude and GPT-5 are happy with.
But I fear that the act of using GPT-5 to "sand away the rough edges", to catch the obvious bugs, may be effectively resulting in a "style translation", from "original Claude output" to "code that's sanitised to remove any bugs GPT-5 can see".
Since GPT-5 doesn't have good taste, I expect code that has been iteratively mashed into GPT-5's image to be kind of bad: weird designs that don't scale to future features, or whatever.

And the act of removing the bugs that were visible to GPT-5 is the act of *making the code look more plausible*.
I think a loop like this is liable to produce code that's wrong, or badly designed, but that's palatable to my human taste.
Is this loop "Most Forbidden"?
Will it produce good code, or is it instead incrementally iterating towards hiding the badness?

The history of computing has showed us again and again that what we think of as "human intelligence" is actually many properties that correlate in humans but are not intrinsically linked.
(Solving chess, solving differential equations, writing short stories that win competitions - these all used to be correlated skills, but now we solve them all individually with very different systems.)
I am concerned that another set of these properties is becoming apparent where the link is coming adrift: "the code looks plausible" and "the code is correctly designed".
