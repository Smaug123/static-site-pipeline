---
lastmod: "2023-10-05T20:00:00.0000000+01:00"
author: patrick
categories:
- programming
- g-research
date: "2023-10-05T20:00:00.0000000+01:00"
title: Nix fireside chat outline
summary: "A talk I gave at work about the Nix build system."
---

This is simply an outline, with no actual content.

# Why Nix

* "Works on my machine"
* Rollbacks and deletion
* Multiple simultaneous installations of things
* Deduplicate precisely what can be deduplicated

# Basic ideas

* Every package describes its build- and run-time dependencies precisely
* Cryptographic hashing to identify dependencies
  * A package is identified by a hash which encompasses itself and all its dependencies
  * Can find uses of a dependencies by dumb search for hash strings! This… actually works in practice!
  * Lots of rewriting of e.g. hashbangs, library loads, etc
    * Can dynamically link, but you must know at build time precisely what you'll be dynamically linking
* Atomic changes
* The *Nix store* holds every package
  * So you can't just assume something will be in `/usr/bin`
  * Dynamic linker is intentionally crippled
  * Notionally read-only and contains the entire world (garbage-collector required)
* Reproducible builds
  * Can cache build results centrally and then download them, rather than rebuilding from source
  * Upcoming feature: content-addressed Nix store

# NixOS (and Guix)

* Key insight: an operating system is just another package
  * Kernel
  * Bootloader
  * Systemd jobs
  * Shell
* All symlinks into the Nix store
* Benefits:
  * Trivial rollback
  * Can create the new version during normal operation, and then atomically switch to it by flipping a symlink when it's ready
    * (asterisk: systemd restarts etc)
    * Same for user environments: `$PATH` is set to a single symlink, and then the target of that symlink is atomically changed for each update
* Very unlike most other Linuxes!

# How a Nix installation works

* Daemon controls the store, you ask it to build stuff
* 

# How a package is built

* Write a Nix "derivation"
* Realise that derivation into the store
* Build that realisation
