---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- programming
comments: true
date: "2014-08-26T00:00:00Z"
aliases:
- /uncategorized/python-script-shadowing/
title: Python, script shadowing
---

*A very brief post about the solution to a problem I came across in Python.*

In the course of my work on [Sextant] (specifically the project to add support for accessing a [Neo4j] instance by SSH), I ran into a problem whose nature is explained [here][Name shadowing trap] as the Name Shadowing Trap. Essentially, in a project whose root directory contains a `bin/executable.py` script, which is intended as a thin wrapper to the module `executable`, you can't `import executable`, because the `bin/executable.py` shadows the module `executable`.

The particular example I had was a wrapper called `sextant.py`, which needed to `import sextant` somewhere in the code. There was no guarantee that the wrapper script would be located in a predictable place relative to the module, because `pip` has a lot of liberty about where it puts various files during a package installation. I really didn't want to mess with the PythonPath if at all possible; a maybe-workable solution might have been to alter the PythonPath to put the module `sextant` at the front temporarily, so that its import would take precedence over that of `sextant.py`, but it seemed like a dirty way to do it.

No workaround was listed, other than to rename the script. A brief Google didn't give me anything more useful. Eventually, I asked someone in person, and ey told me to get rid of the `.py` from the end of the script name. That stops Python from recognising it as a script (for the purposes of `import`). As long as you have the right [shebang] at the top of the script, though, and its permissions are set to be executable, you can still run it.

(Keywords in the hope that Google might direct people to this page if they have the same problem: Python shadow module script same name.)

[Sextant]: https://launchpad.net/ensoft-sextant
[Neo4j]: https://neo4j.com
[Name shadowing trap]: http://python-notes.curiousefficiency.org/en/latest/python_concepts/import_traps.html
[shebang]: https://en.wikipedia.org/wiki/Shebang_(Unix)
