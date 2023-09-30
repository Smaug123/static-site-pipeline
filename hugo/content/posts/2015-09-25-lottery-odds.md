---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
comments: true
date: "2015-09-25T00:00:00Z"
redirect-from:
- /mathematical_summary/lottery-odds/
- /lottery-odds/
title: Lottery odds
summary:
    It has been proposed to me that if one is to play the National Lottery, one should be sure to select one's own numbers instead of allowing the machine to select them for you. This is not an optimal strategy.
---

It has been proposed to me that if one is to play the National Lottery, one should be sure to select one's own numbers instead of allowing the machine to select them for you.

To summarise and slightly simplify the Lottery: at some point during the week, the entrant picks six distinct numbers from 1 to 49 inclusive, and buys a ticket with those numbers on. There is also the option to let the ticket vending machine choose numbers at random, instead of having you choose them. Then on Wednesday evening, six numbers are selected from 1 to 49 on live TV by a process which is as near to true random as we can get while still retaining drama. If all six of your numbers match all six of the prize numbers, you win a prize. (In the actual game, there are also smaller prizes for matching fewer numbers, and so on.)

The argument goes as follows: if you let the vending machine decide your numbers, you have the square of the probability of winning. (That is, a much smaller chance.) Indeed, in order to win, the vending machine first needs to select the winning numbers, and then the TV machine also does.

This is, of course, a confusion of the probability of A given B, and the probability of A and B. What was calculated was the probability that the vending machine picks the six given numbers and the TV picks the six given numbers. What is actually required is the probability that the TV picks the six given numbers given that the vending machine also did.

By the way, "A and B" is definitely distinct from "A given B": in a population, the probability that a person is both Albert Einstein and a man is rather low, but the probability that a given person is a man given that they are Albert Einstein is 1.

The first way to make the lottery more intuitive is to note that we could have conducted the lottery so that we already drew the TV's winning numbers, in secret, before you bought your ticket. Only on buying it do you find out whether you've won or not. Now we are simply trying to match six specific numbers by buying our ticket (although we do not know what they are in advance, we do know they are fixed), and the vending machine can guess exactly as well as I can. By analogy: the TV person flips a coin, and then tells you that you will win if you can guess what the outcome of the coin flip was. It's obvious that you'll win half the time if you pick heads, and half the time if you pick tails, and you won't do any better than the vending machine if you guess. Now, instead, let's say that you pick your heads/tails option first, and then the TV person flips a coin. Nothing has changed except the order in which we do things, and the machine will still do just as well as you. (Analogy, of course, is that selecting the six numbers you want to win is the same as selecting the head/tail option you want to win.)

That is, the bogus argument of the third paragraph is not time independent. If you simply shuffle some of the stages of the lottery around, even though this should have no effect on the outcome, the bogus argument says the outcome should be different.

The second way is let's say I'm in competition with you to win most money on the lottery. I'm going to pick the "vending machine" option. You claim I'm thirteen million times less likely to win when the vending machine has picked my numbers, so you surely won't object if I change the lottery slightly so that if I choose the "vending machine" option, it picks two sets of six numbers and enters me for them both simultaneously. That doubles my winning chance, but it's still a damn sight worse than the penalty of thirteen million times I incurred by picking the "vending machine" option. You likewise won't mind if I change the lottery so that the "vending machine" chance picks ten sets of numbers. A hundred. Thirteen million, which brings me into parity with your lottery: according to you, we're now equally likely to win. But wait - now them machine has picked every combination. I win if any combination wins! And I'm still… just as likely as you to win? Come back to me when you're winning every time and we can rethink.

The third way to make the distinction more intuitive is to make everything much smaller. Let's say I just need to pick one number, and the TV picks one number, each out of 3 instead of 50. Now, the cases in which I win are precisely {(1,1), (2,2), (3,3)}, where (a,b) means "I picked number a, and the machine picked number b". The cases in which I do not win are precisely {(1,2), (1,3), (2,1), (2,3), (3,1), (3,2)}. All of these are equally likely - (1,1) is exactly as likely as (1,2), because if I sneakily relabeled the TV's lottery balls by swapping 1 for 2 then that should have no effect on the outcomes - so my chance of winning is 3/9, or 1/3. This is independent of the means I used to pick my choice, because there is exactly one winning outcome for each of my possible choices. The situation is completely symmetrical: relabelling all the choices doesn't change anything. If it helps, we could think of the option "let the vending machine decide" as "I choose the number 1. Now I let the vending machine apply some scrambling operation I don't know, and it will spit out the number I'll end up using." This doesn't change any of the probabilities, because the statement of the problem is completely independent of what labels appear on the choices (as long as they're all different).

I fear that my third way might require more maths than most people have - the idea of symmetry isn't exactly common.

Anyway, everyone should agree that the lottery is a bad investment if your intention is only to gain money out of it. (Aside from anything else, if you stood to gain anything from playing the lottery, then by symmetry so must everyone else, so the lottery itself must stand to lose. There's simply nowhere else the gain could come from. The lottery would be closed down immediately if it made a loss.)
