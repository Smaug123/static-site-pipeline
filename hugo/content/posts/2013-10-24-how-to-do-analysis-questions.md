---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
- proof_discovery
comments: true
date: "2013-10-24T00:00:00Z"
math: true
aliases:
- /mathematical_summary/how-to-do-analysis-questions/
- /how-to-do-analysis-questions/
title: How to do Analysis questions
---
This post is for posterity, made shortly after [Dr Paul Russell][1] lectured Analysis II in Part IB of the Maths Tripos at Cambridge. In particular, he demonstrated a way of doing certain basic questions. It may be useful to people who are only just starting the study of analysis and/or who are doing example sheets in it.

The first example sheet of an Analysis course will usually be full of questions designed to get you up and running with the basic definitions. For instance, one question from the first example sheet of Analysis II this year is as follows:

> Show that if \\((f_n)\\) is a sequence of uniformly continuous real functions on \\(\mathbb{R}\\), and if \\(f_n \to f\\) uniformly, then \\(f\\) is uniformly continuous.

This is one of those questions which only exists to make sure that you know what "uniformly continuous" and "converges uniformly" mean.

How do we solve this question? The key with a definitions-question is to avoid employing the brain wherever possible. So the first step is to define \\((f_n)\\) and \\(f\\), and to write down everything we know about them:

*   Let \\((f_n)\\) be a sequence of uniformly continuous real functions on \\(\mathbb{R}\\), and \\(f\\) a real function on \\(\mathbb{R}\\), such that \\(f_n \to f\\) uniformly.
*   Since each \\(f_n\\) is uniformly continuous, we have that for all \\(n\\), we have for every \\(\epsilon\\) there is a \\(\delta\\) such that for all \\(x,y\\) with \\(\vert y-x \vert < \delta\\), it is true that \\(\vert f_n(y)-f_n(x) \vert < \epsilon\\).
*   Since \\(f_n \to f\\) uniformly, we have that for all \\(\epsilon\\), there exists \\(N\\) such that for all \\(n \geq N\\), for every \\(x\\) we have \\(\vert f_n(x)-f(x) \vert < \epsilon\\).

Now, what do we want to prove?

*   [Don't write this down yet - this line goes at the end of the proof!] Therefore, for every \\(\epsilon\\) there is a \\(\delta\\) such that for all \\(x,y\\) with \\(\vert x-y  < \delta\\), \\(\vert f(y)-f(x) \vert < \epsilon\\). Hence \\(f\\) is uniformly continuous.

So what can we get from what we know? Everything we know is about "for all \\(\epsilon\\)". So we fix an arbitrary \\(\epsilon\\). If we can prove something that is true for this \\(\epsilon\\), with no further assumptions, then we are done for all \\(\epsilon\\).

*   Fix arbitrary \\(\epsilon\\) greater than \\(0\\).

Now what do we know?

*   Since each \\(f_n\\) is uniformly continuous, we have that for all \\(n\\), there is a \\(\delta\\) such that for all \\(x,y\\) with \\(\vert y-x \vert < \delta\\), it is true that \\(\vert f_n(y)-f_n(x) \vert < \epsilon\\).
*   Since \\(f_n \to f\\) uniformly, we have that there exists \\(N\\) such that for all \\(n \geq N\\), for every \\(x\\) we have \\(\vert f_n(x)-f(x)\vert < \epsilon\\).
*   \\(\epsilon > 0\\).

Aha! Now we have a definite something existing (namely, the \\(N\\) in the second condition). Let's fix it into existence.

*   Let \\(N\\) be such that for all \\(n \geq N\\), for every \\(x\\) we have \\(\vert f_n(x)-f(x)\vert < \epsilon\\).

What do we know?

*   Since each \\(f_n\\) is uniformly continuous, we have that for all \\(n\\), there is a \\(\delta\\) such that for all \\(x,y\\) with \\(\vert y-x \vert < \delta\\), it is true that \\(\vert f_n(y)-f_n(x)\vert < \epsilon\\).
*   Since \\(f_n \to f\\) uniformly, we have that for all \\(n \geq N\\), for every \\(x\\) we have \\(\vert f_n(x)-f(x)\vert < \epsilon\\).
*   \\(\epsilon > 0\\), and \\(N\\) is an integer.

Now, we have two "for all"s competing with each other. The more specific is the second one, so we'll fix that into existence.

*   Fix arbitrary \\(n\\) greater than or equal to \\(N\\).

What do we know?

*   Since each \\(f_n\\) is uniformly continuous, we have that for all \\(n\\), there is a \\(\delta\\) such that for all \\(x,y\\) with \\(\vert y-x \vert < \delta\\), it is true that \\(\vert f_n(y)-f_n(x)\vert < \epsilon\\).
*   Since \\(f_n \to f\\) uniformly, we have that for every \\(x\\), \\(\vert f_n(x)-f(x)\vert < \epsilon\\).
*   \\(\epsilon > 0\\), and \\(N\\) is an integer, and \\(n \geq N\\).

Now we have a choice of "for all"s again, but this time they aren't "talking about the same thing" (last time, both were integers referring to which \\(f_n\\) we were talking about; this time, one is an integer and one is an arbitrary real). However, now we have \\(n \geq N\\) which we can talk about; let's wring more information out of it, by using the "uniformly continuous" bit.

*   Since each \\(f_n\\) is uniformly continuous, there is a \\(\delta\\) such that for all \\(x,y\\) with \\(\vert y-x\vert < \delta\\), it is true that \\(\vert f_n(y)-f_n(x)\vert < \epsilon\\).
*   Since \\(f_n \to f\\) uniformly, we have that for every \\(x\\), \\(\vert f_n(x)-f(x)\vert < \epsilon\\).
*   \\(\epsilon > 0\\), and \\(N\\) is an integer, and \\(n \geq N\\).

Aha - another "there exists" condition (on \\(\delta\\)). Let's fix it.

*   Fix \\(\delta\\) such that for all \\(x,y\\) with \\(\vert y-x\vert < \delta\\), it is true that \\(\vert f_n(y)-f_n(x)\vert < \epsilon\\).

What do we know?

*   Since each \\(f_n\\) is uniformly continuous, for all \\(x,y\\) with \\(\vert y-x\vert < \delta\\), it is true that \\(\vert f_n(y)-f_n(x) \vert < \epsilon\\).
*   Since \\(f_n \to f\\) uniformly, we have that for every \\(x\\), \\(\vert f_n(x)-f(x)\vert < \epsilon\\).
*   \\(\epsilon > 0\\), and \\(N\\) is an integer, and \\(n \geq N\\), and \\(\delta > 0\\).

Two more "for all" conditions. Let's fix them into existence:

*   Let \\(x\\) be an arbitrary real, and let \\(y\\) be such that \\(\vert y-x\vert < \delta\\).

What do we know?

*   Since each \\(f_n\\) is uniformly continuous, \\(\vert f_n(y)-f_n(x) \vert < \epsilon\\).
*   Since \\(f_n \to f\\) uniformly, we have that \\(\vert f_n(x)-f(x) \vert < \epsilon\\).
*   \\(\epsilon > 0\\), and \\(N\\) is an integer, and \\(n \geq N\\), and \\(\delta > 0\\), and \\(x\\) is real, and \\(\vert y-x\vert < \delta\\).

Now the conditions are really small things. It's kind of unclear how to proceed from here, so let's look at what we wanted to prove again:

> For every \\(\epsilon\\) there is a \\(\delta\\) such that for all \\(x,y\\) with \\(\vert x-y\vert < \delta\\), \\(\vert f(y)-f(x)\vert < \epsilon\\).

Applying what we know, this becomes:

*   [to be proved] For all \\(y\\) with \\(\vert x-y\vert < \delta\\), \\(\vert f(y)-f(x)\vert < \epsilon\\).

Aha! We have already got something to do with \\(y\\) (namely that \\(\vert f_n(y)-f_n(x)\vert < \epsilon\\)), and we have something to do with \\(f(x)\\) (namely that \\(\vert f_n(x)-f(x)\vert < \epsilon\\)). Hence \\(\vert f_n(y)-f_n(x)\vert + \vert f_n(x)-f(x)\vert < 2\epsilon\\), and the triangle inequality gives us that \\(\vert f_n(y)-f(x)\vert < 2\epsilon\\). Eek - we need to turn that \\(f_n(y)\\) into an \\(f(y)\\). We have no way of doing that, so we must have missed out some information somewhere. Backtracking, the nearest-to-the-end bit of missed out information was when we fixed \\(x, y\\). We threw away information in "for every \\(x\\), \\(\vert f_n(x)-f(x)\vert < \epsilon\\)" when we fixed \\(x\\) - it applies to \\(y\\) too. So we'll add a new statement to the "what do we know?" list:

*   \\(\vert f_n(y)-f(x)\vert < 2\epsilo\\)n
*   \\(\vert f_n(y)-f(y)\vert < \epsilon\\).
*   \\(\epsilon > 0\\), and \\(N\\) is an integer, and \\(n \geq N\\), and \\(\delta > 0\\), and \\(x\\) is real, and \\(\vert y-x \vert < \delta\\).

And now it just drops out of the triangle inequality that \\( \vert f(y)-f(x) \vert < 3 \epsilon\\).

Now, \\(\epsilon\\) was arbitrary, \\(N\\) was dictated by the conditions, \\(n \geq N\\) was arbitrary, \\(\delta\\) was dictated by the conditions, \\(x\\) was arbitrary, \\(y\\) was arbitrary subject to \\(\vert y-x \vert < \delta\\).

Hence we have proved that for every \\(\epsilon\\) there exists \\(N\\) such that for all \\(n \geq N\\) there is a \\(\delta\\) such that for all \\(x\\), for all \\(y\\) with \\(\vert y-x\vert  < \delta\\), \\(\vert f(y)-f(x)\vert  < 3\epsilon\\).

We can clean this statement up. Notice that neither \\(n\\) nor \\(N\\) was involved in the final expression, so we can simply get rid of them to obtain:

> For every \\(\epsilon\\) there is a \\(\delta\\) such that for all \\(x\\), for all \\(y\\) with \\(\vert y-x\vert  < \delta\\), \\(\vert f(y)-f(x) \vert < 3\epsilon\\).

From this, it is easy to obtain the required result. We want to turn \\(3 \epsilon\\) into \\(\epsilon\\) - but that's fine, because the expression holds for every \\(\epsilon\\), so in particular if we fix \\(\epsilon\\) then it holds for \\(\dfrac{\epsilon}{3}\\). We'll just use the \\(\delta\\) from that \\(\dfrac{\epsilon}{3}\\) instead. This gives us that \\(f\\) is uniformly continuous, as required, and without actually engaging the brain except to carry out the algorithm of "write down what we know; if there exists something, fix it, and repeat; if for all something, then fix an arbitrary one, and repeat; if we're stuck, go back through, looking to see if we missed out any information during a fixing-arbitrary-for-all phase" and to carry out the algorithm of "when the information we have is simple enough, compare terms from what we know with the expression that we want to show; use the triangle inequality to get them in there".

 [1]: https://www.dpmms.cam.ac.uk/~par31 "Paul Russell"
