---
lastmod: "2023-07-14T20:00:00.0000000+01:00"
author: patrick
categories:
- uncategorized
date: "2023-07-12T00:00:00Z"
title: Questions I had about transformers
summary: "Some basic questions I had about transformers, and their possible answers."
math: true
---

I was learning about transformers, variously through [Neel Nanda's video on transformers](https://www.youtube.com/watch?v=bOYE6E8JrtU) and his [video about A Mathematical Framework for Transformer Circuits](https://www.youtube.com/watch?v=KV5gbOmHbjU).
Here are several questions I had throughout.

## Prediction of previous tokens

In a decoder-only transformer applied to a stream of text, the final output (after all layers have been computed) is a vector of logits, one for each element of the context window, and the "prediction" of the transformer is the token indicated by the logit that is at the final place of the context window.
Does that mean its "prediction" for the *previous* elements of the context window is always a trivial "this particular token, with extremely high probability", because that particular element of the context window was already in the stream before we started to predict?

ChatGPT4 did me wrong and said that this was correct.
In fact, it is not: this is what the *masked* part of "masked self-attention" is for, to prevent predictions earlier in the sequence from using information from later in the sequence.
The prediction at any given token is the prediction using all information available up to immediately before the point of that token, but no further.

## Ordering

What gives the residual stream any ordering properties?
Why can we view it as being somehow ordered, when interactions with it are all linear?

Answer: positional encoding.
(This is also answered during the "A Mathematical Framework" video.)

## Strong reliance on specific paths

Neel said:

> An important property of the transformer is that the model functionality arises as a sum of paths through the residual stream.
> This is important because we should expect a lot of the model's behaviour to be localised: there will be some path through the model, going through some heads and some MLPs to the output, and we might predict that in general some paths matter but most paths don't.
> And in practice this seems to be basically true."

But I don't see why we should predict that.
Why shouldn't the model's behaviour arise through a roughly-equally-weighted combination of all the paths?

Answer: there's no inherent reason why this should be true, but in practice the model tends to learn better by having individual heads focusing on specific features and compositions thereof.
(I suspect this is also related to the problem that superposition solves: there's only a limited amount of information you're able to extract at once from the residual stream, because the stream relies heavily on superposition to fit the data in. So your features are inherently limited to operating on "single cross-sections" of the superposed data at once.)

## Attention is limited

Why do attention heads learn to attend only to specific parts of the input, rather than as much of the input as is available at once?

Answer: specialisation is just more efficient in practice, and also each head is kind of small and can't attend to everything at once, even if it can in principle access most of the data to some degree.

## Dimensions

In GPT2-small, the residual stream is of width 768.
Does that mean the residual stream is essentially a tensor, with first dimension 768 and second dimension about 50,000 (i.e. the size of the token dictionary)?

Answer: no.
The initial embedding layer converts the input token stream (that is, a collection of 50,000-length vectors) into the residual stream (that is, a collection of context-window-many vectors of size model-width=768).
The number 50,000 then has no further part in things until the projection back into token-space at the very end.

## Is the "context window" the same as the "sequence length"?

Answer: yes.

## Adjusting the context window

Do we have to fix the context size up front, or is it easy to adjust after the main body of training?
The release of "increased context window" versions of the GPT models suggests that it's cheap to adjust, but I don't see how.

Answer: I was really confused about this, and my best answer was "no, you really can't adjust this, they're just training new models".
ChatGPT4 said that that was correct, but I am reliably informed that it was lying.
I am assured that the answer to this question will be very obvious once I grok what an attention head is.

## Why not concatenate things to the residual stream?

Surely if the residual stream is under immense compression pressure (leading to superposition), we could do massively better by just making the residual stream even slightly higher-dimensional?
What considerations go into picking the size of the residual stream?

Relatedly, Neel Nanda said we elementwise-add rather than concat positional information to the input "because the residual stream is shared memory and likely under significant superposition".
Is that a response to "why don't we have a specific dedicated area for position that never changes" (i.e. "because it's inefficient, the model wants to use any space available so it's inefficient to carve out some space which can't change")?

## Why do the same prediction problem at every position?

Is there some structural reason why we predict text *at each position*, rather than doing something else and only caring about the prediction at the last token?

Answer (I think): I had a longer explanation of this question, but I think I answered it in the process of writing it.
The loss function we use for text generation is "perplexity", which structurally does mean "how far is each predicted token from what actually happened".

## Why can't an MLP layer move information between tokens?

"An attention head is the only part of a transformer which can move information between positions."
But why can't an MLP layer do this?

## Hold on, the attention pattern is an activation and not a parameter?

Don't we learn up front how much attention a head is going to pay to each component of the input?

Answer: I think this was bad exposition on Neel's part.
The attention pattern \\(A\\) is computed by converting \\(x \mapsto x^T W x\\) to a probability distribution with softmax.
That is, it is an activation (because it depends on \\(x\\)), but it is learned (because it contains a parameter \\(W\\)).

## Is an "attention-only" model one which doesn't even have any MLP layers, just attention heads?

## Why "Q-K" at all?

It just collapses to one matrix, doesn't it?
So why do we separate "keys" from "queries" at all?