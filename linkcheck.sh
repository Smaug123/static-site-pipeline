#!/bin/bash

bad=0

LYNX=$1

evaluate_file() {
  target=$1
  links=$("$LYNX" -dump --listonly -image_links --nonumbers -hiddenlinks=listonly "$target" | awk '
/Visible links/ {
found=1
next
}
found { print }
' | grep 'file:' | grep -v 'localhost' | cut -d '/' -f 3- | grep -v '#')

  # hurr durrr accidentally quadratic
  for link in $links; do
    filename=".$link"
    if [ -d "$filename" ]; then
      filename="$filename/index.html"
    fi

    if ! [ -e "$filename" ]; then
      echo "File does not exist, while parsing '$target': $filename" >&2
      bad=1
    fi
  done
}

while IFS= read -d '' -u3 -r file; do
  evaluate_file "$file"
done 3< <(find . -type f -name '*.html' -print0)

if [ $bad -eq 1 ]; then
  exit $bad
fi
