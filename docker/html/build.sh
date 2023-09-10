#!/bin/sh

find result/ -type f -name '*.html' -print0 | xargs -0 -n1 /nix/store/p7adf8zk6akdbjr60vb98fajxp5aaa7i-html-tidy-5.8.0/bin/tidy 2>/dev/null
