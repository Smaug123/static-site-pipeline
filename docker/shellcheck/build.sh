#!/bin/sh

find "$1" -type f -name '*.*sh' -print0 | xargs -0 -n1 shellcheck
