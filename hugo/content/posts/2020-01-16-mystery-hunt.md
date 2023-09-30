---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- mystery-hunt
- programming
comments: true
date: "2020-01-16T00:00:00Z"
title: MIT Mystery Hunt 2020 answers
summary: "A couple of solution documents I made during the progress of the 2020 MIT Mystery Hunt."
---

# Turtle

The [Turtle](https://www.mit.edu/~puzzle/2020/puzzle/turtle/) puzzle was a collection of Logo programs which ultimately spelled out words.
See [turtle.nb] for a Mathematica notebook, or [turtle.pdf] for a statically rendered pdf.

# Best Song Ever

The [Best Song Ever](https://www.mit.edu/~puzzle/2020/puzzle/best_song/) puzzle was a .wav file of a recording of Disney's "It's A Small World".
Its data segment encoded a .jpg file which suggested how to proceed.
See [BestSongEver.nb] for a Mathematica notebook which processed the data segment (it depends on [tiny_planet.wav]), or [BestSongEver.pdf] for a statically rendered PDF; see [out.jpg] for the extracted JPG.

# Story

The [Story](https://www.mit.edu/~puzzle/2020/puzzle/story/) puzzle was a collection of rather incoherent paragraphs.
Embedded in the page source was also a collection of very large integers, which turned out to have binary expansions that were of exactly the same length as their corresponding paragraph.
Selecting the letters from the paragraph corresponding to 0-valued bits of the integers yielded a message which told us how to proceed.

See [Story.nb] for a Mathematica notebook which performs that extraction, or [Story.pdf] for a statically rendered PDF.

# Nauseator

The [Nauseator](https://www.mit.edu/~puzzle/2020/puzzle/nauseator/) puzzle started with a coloured nonogram.
See [Nauseator.nb] for a Mathematica notebook to parse out the data into structured form and shell out to `z3` to solve it, or [Nauseator.pdf] for a statically rendered PDF.
(The PDF has a very blurry image at the end, for some reason; see [the actual image] for full resolution.)
The input spreadsheet is [nauseator.xlsx].

The notebook relies on [Z3Interop.wl] (static: [Z3Interop.pdf]), an extremely janky DSL to express SAT problems to send to the [Z3] SAT solver.
See the application to Sudoku and to nonograms, at [Z3Interop.nb] (static: [Z3Interop.pdf]).

[turtle.nb]: /MysteryHunt2020/turtle.nb
[turtle.pdf]: /MysteryHunt2020/turtle.pdf
[BestSongEver.nb]: /MysteryHunt2020/BestSongEver.nb
[BestSongEver.pdf]: /MysteryHunt2020/BestSongEver.pdf
[tiny_planet.wav]: https://puzzles.mit.edu/2020/puzzle/best_song/tiny_planet.wav
[out.jpg]: /images/MysteryHunt2020/out.jpg
[Story.nb]: /MysteryHunt2020/Story.nb
[Story.pdf]: /MysteryHunt2020/Story.pdf
[Nauseator.nb]: /MysteryHunt2020/nauseator.nb
[Nauseator.pdf]: /MysteryHunt2020/nauseator.pdf
[Nauseator.xlsx]: /MysteryHunt2020/nauseator.xlsx
[the actual image]: /MysteryHunt2020/nauseator.svg
[Z3Interop.wl]: /MysteryHunt2020/Z3Interop.wl
[Z3Interop.nb]: /MysteryHunt2020/z3interop.nb
[Z3Interop.pdf]: /MysteryHunt2020/z3interop.pdf
[Z3]: https://github.com/Z3Prover/z3
