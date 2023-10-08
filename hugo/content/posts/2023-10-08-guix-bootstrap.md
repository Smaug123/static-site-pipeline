---
lastmod: "2023-10-08T11:43:00.0000000+01:00"
author: patrick
categories:
- programming
date: "2023-10-18T11:43:00.0000000+01:00"
title: The GUIX bootstrap
summary: "Notes for a talk I gave at work on the GUIX bootstrap."
---

This is simply an outline, with no actual content.

# Why bootstrap?

* Auditing and security
  * Seminal paper: [Reflections on Trusting Trust](https://www.cs.cmu.edu/~rdriley/487/papers/Thompson_1984_ReflectionsonTrustingTrust.pdf)

# How is a system normally installed?

* Massive binary blob (250MB of gcc, binutils etc) to start a bootstrap
* Or an even massiver blob (Windows installer)

# Necessary tools

* A C compiler e.g. [TCC](https://bellard.org/tcc/)
* Text manipulation e.g. `sed`

# GUIX Full-Source Bootstrap

[Official docs](https://guix.gnu.org/en/manual/devel/en/html_node/Full_002dSource-Bootstrap.html).

## Stage-0

[Main repo](https://github.com/oriansj/stage0-posix); [kaemfile](https://github.com/oriansj/stage0-posix-x86/blob/e86bf7d304bae5ce5ccc88454bb60cf0837e941f/mescc-tools-mini-kaem.kaem#L97).

The kernel is trusted; eventually they would like to make no syscalls at all and run on bare metal.
(GNU Guix bootstrap kernel is still 25MB.)

* Base: a [tiny self-hosted assembler](https://github.com/oriansj/bootstrap-seeds/blob/master/POSIX/x86/hex0_x86.hex0) of 357 bytes, incredibly strict language, human-verifiable
* [hex1](https://github.com/oriansj/stage0-posix-x86/blob/e86bf7d304bae5ce5ccc88454bb60cf0837e941f/hex1_x86.hex0): a slightly more powerful assembler, better hex parsing, single-character labels and some jumps
* [hex2](https://github.com/oriansj/stage0-posix-x86/blob/e86bf7d304bae5ce5ccc88454bb60cf0837e941f/hex2_x86.hex1): an assembler with labels and absolute memory addresses
* [catm](https://github.com/oriansj/stage0-posix-x86/blob/e86bf7d304bae5ce5ccc88454bb60cf0837e941f/catm_x86.hex2): an implementation of `cat`
* [M0](https://github.com/oriansj/stage0-posix-x86/blob/e86bf7d304bae5ce5ccc88454bb60cf0837e941f/M0_x86.hex2): a C-style preprocessor and a bona-fide assembler which recognises a language you might recognise
* [cc-x86](https://github.com/oriansj/stage0-posix-x86/blob/e86bf7d304bae5ce5ccc88454bb60cf0837e941f/cc_x86.M1): a C compiler! (only a subset of C though)
* M2-Planet: a slightly better C compiler
* [blood-elf-0](https://github.com/oriansj/mescc-tools/blob/master/blood-elf.c): writes [DWARF](https://en.wikipedia.org/wiki/DWARF) stubs for debug tables (but no actual implementation of those stubs)
* M1: a better C compiler which is debuggable and implements some optimisations (TODO: example?)
* Rebuild earlier inputs now that we have an optimising compiler
* blood-elf again: provides implementations for the stubs `blood-elf-0` wrote (TODO: is that true? Understand the nature of the stubs and implementation)
* A variety of nice things like `sha256sum`, `mkdir`, `untar`, primitive `cp`, `chmod`
* [kaem](https://github.com/oriansj/kaem/tree/master): a tiny build system (anagram of `make`)

## GNU Mes

[Mes](https://www.gnu.org/software/mes/) is an intertwined pair of a C compiler and Scheme interpreter; its source is mirrored [on GitHub](https://github.com/gnu-mirror-unofficial/mes).
It can be built with `kaem`, and the resulting C compiler can build [TCC](https://bellard.org/tcc/), which can then build early GCC, which can bootstrap later GCCs and hence support for other languages and architectures.

As of a few years ago, they were experimenting with using the Mes Scheme compiler to compile [Gash](https://savannah.nongnu.org/projects/gash), an interpreted Scheme POSIX shell which could replace some of the binary blob.
