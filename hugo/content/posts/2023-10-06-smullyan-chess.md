---
lastmod: "2023-10-06T20:53:00.0000000+01:00"
author: patrick
categories:
- uncategorized
date: "2023-10-06T20:53:00.0000000+01:00"
title: Raymond Smullyan chess problem walkthrough
summary: "The thought process behind solving a particular Raymond Smullyan chess retrograde analysis puzzle."
---

![A chess board. A white bishop is on a4. A black king is on d1, a black rook on b5, and a black bishop on d5.](https://pbs.twimg.com/media/F7wXUNxWgAApBsv?format=png&name=360x360 "Smullyan chess puzzle")

Raymond Smullyan apparently asked: in the above board, there is one piece missing, the white king.
Where is the white king?

# Thought process

## Whose move is it?
This has to be the first question.

If it's white to move, then the black king on d1 can't be in check (there's no way it can legally be your move and you're giving check).
So the white king would have to be on b3 to block the check.
But how could the white king be in check in two different ways, from the rook and bishop?
There is no possible way: either the rook, king, or bishop must have moved last (there are no other black pieces), and none of them could have got to where they are while causing a discovered check (or two discovered checks, if it was the king moving!).

So it's Black to move, and the most recent move was by White.

## Which piece most recently moved?

It's either the white king or the white bishop.

The bishop is very limited in where it could have come from.
The black rook and king prevent it coming from anywhere except b3 or c2.
But if it came from b3 or c2, then it must have been giving check on the board immediately before it moved (there's no way the white king could be in the way), so the board state wasn't legal.

So the most recent move was the white king, and it has just moved so as to give check.

## What was the most recent move?

The white king *must* have been on b3 so as to reveal the check from the bishop (otherwise the white bishop was giving check throughout the duration of white's last move, which isn't legal).
That means it is now on c3 or a3.

## What is surprising about the king being on b3?

It's in check, twice!
That means Black's most recent move was to give check, in *two* different ways.

We've already discussed that the discovered checks can't have been set up by moving the rook or bishop: that same reasoning was how we determined that it's currently Black to move.
So there must have been a third black piece on the board, which was moved most recently.
Moreover, the moving of that third piece must have somehow caused a discovered check both from the black bishop and rook.

## What is the only way that a single piece moving can cause two discovered checks?

To discover checks along both a vertical and a diagonal, it's necessary to move two pieces in one move.

* Castling moves two pieces, but we already know the black king has moved, so it wasn't Black castling.
* A standard capture does move two pieces, but it leaves the capturing piece in the same place as the captured piece, so it can't reveal two checks.
* Moving a piece without capturing moves one piece, and can only reveal one check.
* Promoting a pawn could conceivably have had this effect if this were all happening on the back rank: a pawn promoting to a knight can both discover a check from a bishop and cause check with the new knight. But both the pieces which are giving check are in the middle of the board, with neither on the back rank.

There is exactly one other kind of move in the game: capturing en passant.
This can clear a file and a diagonal at the same time.

## The solution

* Black's most recent move was to capture a white pawn on c4 en passant using the black pawn on b4. This discovered two checks on the white king which was on b3.
* White responded with the move Kxc3+, which is where it is now.

This is deeply cute!
Many thanks to Tim Gowers for retweeting it.
