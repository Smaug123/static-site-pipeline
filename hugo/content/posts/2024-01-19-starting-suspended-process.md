---
lastmod: "2024-01-19T18:51:00.0000000+00:00"
author: patrick
categories:
- programming
date: "2024-01-19T18:51:00.0000000+00:00"
title: Starting a suspended process
summary: "How to start a process into a suspended state on Linux"
---

(This is not fancy and is probably common knowledge, but I only learned how to do it today.)

Say you want to start a process, then log its PID, then allow it to run (so that if it starts logging to the console, you're guaranteed to have done all your logging before it starts polluting stdout).

This is easy on Windows: [`CreateProcess` accepts `CREATE_SUSPENDED`](https://learn.microsoft.com/en-us/windows/win32/procthread/process-creation-flags).
But on Linux, it's not obvious.

1. The parent sets up a signal handler for SIGUSR1 (say), so that it can know when the child is ready.
1. The parent forks, then waits for SIGUSR1.
1. The child sets up a signal handler for SIGUSR2, so that it can know when the parent is ready.
1. The child sends SIGUSR1 to its parent to signal readiness, then waits for SIGUSR2.
1. The parent does whatever it wants to do with the now-running child process (whose PID it now knows).
1. The parent sends SIGUSR2 to the child.
1. The child `exec`s into the process that it actually wanted to start all along.
1. The parent unregisters the SIGUSR1 handler.

Note that [forked processes have the same signal handlers](https://man7.org/linux/man-pages/man7/signal.7.html) as the parent, but those signal handlers are blatted by an `exec`.

(Good lord is this not investment advice. It's hard to express just how much of a novice I am at signal handling.)