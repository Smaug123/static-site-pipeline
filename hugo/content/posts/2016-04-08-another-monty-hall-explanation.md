---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mathematical_summary
comments: true
date: "2016-04-08T00:00:00Z"
aliases:
- /another-monty-hall-explanation/
title: Another Monty Hall explanation
---

Recall the [Monty Hall problem]: the host, Monty Hall, shows you three doors, named A, B and C.
You are assured that behind one of the doors is a car, and behind the two others there is a goat each.
You want the car.
You pick a door, and Monty Hall opens one of the two doors you didn't pick that he knows contains a goat.
He offers you the chance to switch guesses from the door you first picked to the one remaining door.
Should you switch or stick?

I'll slightly reframe the problem: let's pretend you are playing cooperatively with Monty Hall, where he
knows the layouts and he is trying to open two goat-doors, and you're trying for the car; you're not allowed to communicate.
The game is (noting the distinction between "picking" a door - i.e. announcing your intention to open it - and opening it):

* You pick a door;
* Monty Hall opens a door you didn't pick;
* You open a door Monty Hall didn't just pick;
* Monty Hall opens the remaining door.

(The problem is the same: in standard Monty Hall, you win if and only if you open the car door and Monty Hall opens two goat doors.
Let's say Monty Hall really likes goats, and not inquire further.)

You pick a door, B say. Monty Hall now opens a goat-door, C say,
because he knows the layouts and can pick one with a goat behind.

At this point, you know Monty Hall *decided not to open* door A.
Why would he not have chosen door A?
It's either because he chose randomly between his available goaty options A and C,
or because he knew A had a car behind so he was choosing the only goat door available to him.
(Remember, Monty Hall wants to find goats.)

If he chose randomly, you're better off sticking, because that means you have the car.
But if he *actively refused* door A (which can only happen because it had a car behind), that means you need to switch to door A.

He chose randomly with probability 1/3 (because he chose randomly if, and only if, you originally picked the car).
He actively refused door A with probability 2/3, therefore.

So with 2/3 probability, you're in the case that means you guarantee yourself a car if you switch.
With 1/3 probability, you're in the case that means you guarantee yourself a car if you stick.

So you should switch.

[Monty Hall problem]: {{< ref "2013-12-22-three-explanations-of-the-monty-hall-problem" >}}
