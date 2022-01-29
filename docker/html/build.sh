#!/bin/sh

find /public -type f -name '*.html' -print0 | xargs -0 -n1 /vnu-runtime-image/bin/vnu -Werror