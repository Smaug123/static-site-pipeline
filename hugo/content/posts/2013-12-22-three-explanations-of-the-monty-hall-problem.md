---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
comments: true
date: "2013-12-22T00:00:00Z"
aliases:
- /mathematical_summary/three-explanations-of-the-monty-hall-problem/
- /three-explanations-of-the-monty-hall-problem/
title: Three explanations of the Monty Hall Problem
---
Earlier today, I had a rather depressing conversation with several people, in which it was revealed to me that many people will attempt to argue against the dictates of mathematical and empirical fact in the instance of the [Monty Hall Problem][1]. I present a version of the problem which is slightly simpler than the usual statement (I have replaced goats with empty rooms).

> Monty Hall is a game show presenter. He shows you three doors; behind one of the three is a car, and the other two hide empty rooms. You have a free choice: you pick one of the doors. Monty Hall then opens a door which you did not pick, which he knows is an empty-room door. Then he gives you the choice: out of the two doors remaining, you may switch your choice to the other door, or stick with the one you first picked. You will get whatever is behind the door you end up with. You want to pick the car; do you stick with your first choice, or do you switch to the other door?

The solution is that you should switch. I present three explanations for why this is true, each of which makes it obvious to me in a different way. They may not help.

# Different worlds

Imagine three possible worlds: you pick a door, and the car is behind the first, second or third door. These choices are equally likely: the position of the car is randomly chosen by Monty Hall beforehand. Hence there are three possible worlds that I could find myself in. Let's suppose I picked door 1; it doesn't matter.

*   In the "I pick door 1, car in 1" world, if I switch my door, I lose; if I keep my door, I win.
*   In the "I pick door 1, car in 2" world, if I switch my door, I win; if I keep my door, I lose.

The "I pick door 1, car in 3" world is identical to the previous one.

That is, in two cases out of three, switching wins for me. That means switching is better than sticking: I win in two-thirds of the worlds if I switch, and I only win in a third of the worlds if I stick. (This is the brute-force approach to understanding the problem.)

# Extra information

Let's suppose we pick a door, and then Monty Hall reveals a false door. Of course, when I picked my door, I had a 1/3 chance of having picked the car, and that probability is unchanged when Monty reveals the false door. However, if I switch, only then am I given a chance to use the information that Monty has provided to me. Only if I switch am I able to use the fact that only two doors remain (one of them hiding nothing, and one of them hiding a car) - that makes my chance of winning a car 1/2 if I switch (actually, it's 2/3 if we condition correctly, but that's not instantly obvious and this is an informal explanation), but only 1/3 if I stick. This means it's better for me to switch. Essentially, I'm restarting the game if I switch, because nothing was special about my original choice so I can discard it without changing anything. If I switch, I discard my original choice, changing nothing, and re-pick from the improved game with one fewer door. (This is the information-theoretic approach of incorporating new information.)

The same idea can be seen if we think of the question in a slightly different way. Once you've picked a door, and before Monty Hall opens any door, Monty asks you, "Would you like to look behind the door you picked, or behind the two doors you didn't pick?" If you reply "my door, please", that's the same as sticking with your original choice: Monty opens an empty-room door (changing nothing; after all, you know Monty will do this before you even start the game) and then your original door. If you reply "the other two, please", Monty opens an empty-room door and then the other door. (That's the same as switching choices.) Essentially, Monty is giving you a choice of two doors in the second case, and only one door in the first. The reason that his opening an empty-room door changes something in this case, is because we might as well consider it as "Monty opens the other two doors simultaneously": you get a 2-in-3 chance this time, since Monty's opening two of the three doors.

# Extreme problem

Consider the phrasing of the problem as "You pick a door. If you picked the car, Monty Hall opens every door except the one you picked, and one random empty-room door. If you picked an empty room, Monty Hall opens every door except the one you picked, and the car." Now, this exactly reflects the original problem, but is amenable to extension in the following way. Instead of having one car and two empty rooms, have one car and a hundred empty rooms. Now, when you pick, Monty Hall opens every door except for the one you picked, and one other. You started with a one-in-101 chance of having picked the car. At the end, Monty Hall has left only two doors. The probability that you originally picked the car is very low (1 in 101). But if we switch, we suddenly see that Monty Hall has removed almost all of the chaff that caused us to have only a 1 in 101 chance originally. Now it's just obvious that we have a 1 in 2 chance of picking the car if we re-pick from the game in its new state. The only way we have of re-picking is to switch doors.

 [1]: https://en.wikipedia.org/wiki/Monty_hall_problem "Monty Hall problem Wikipedia page"
