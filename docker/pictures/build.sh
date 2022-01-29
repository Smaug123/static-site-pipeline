#!/bin/sh

TO_SCAN="$1"

SHELL="/bin/sh"

# For some reason, using $0 instead of `sh` makes Shellcheck warn about the single-quotes not expanding expressions
# shellcheck disable=SC2016
find "$TO_SCAN" -type f ! -name '*-thumb.jpg' -name '*.jpg' -exec "$SHELL" -c '
  if [ -f "${@%.*}-thumb.jpg" ]; then exit 0; fi;
  echo "$@"
  convert "$@" -thumbnail 100x100^ -gravity center -extent 100x100 "${1%.*}-thumb.jpg"
' -- {} \; || exit 1
