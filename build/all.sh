#!/bin/bash

pdfs=$1
images=$2
ankiDecks=$3
buildHugo=$4
katex=$5
extraContent=$6

echo "Linking PDFs: $PDF_FOLDER/pdf-targets.txt"
while IFS= read -r texfile || [[ -n "$r" ]]
do
    DIR=$(dirname "$texfile")
    TEXFILE_BASE=$(basename "$texfile")
    if [ -z "${TEXFILE_BASE}" ]; then
      echo "Skipping empty line"
    else
      PDFFILE=$(basename "$texfile" .tex).pdf
      mkdir -p "$DIR"
      echo "$TEXFILE_BASE"
      echo "$PDFFILE"
      cp "${pdfs}/$TEXFILE_BASE" "$texfile"
      cp "${pdfs}/$PDFFILE" "$DIR/"
    fi
done < "${pdfs}/pdf-targets.txt"

echo "Linking thumbnails."
while IFS= read -r d || [[ -n "$d" ]]
do
    if [ -n "${d}" ]; then
      DIR=$(dirname "$d")
      mkdir -p "$DIR" || exit 1
      DESIRED_LOCATION=$(basename "$d")
      echo "$d -> $DESIRED_LOCATION"
      cp -r "${images}/$DESIRED_LOCATION" "$d"
    fi
done < "${images}/image-targets.txt"

echo "Linking Anki decks."
mkdir static/AnkiDecks && cp -R "${ankiDecks}/." static/AnkiDecks

echo "Building site."

mkdir -p "themes/anatole/assets"
cp -r "$katex"/dist/fonts themes/anatole/assets/fonts
cp -r "$katex/dist/contrib" themes/anatole/assets/contrib
cp "$katex"/dist/*.js themes/anatole/assets/
cp "$katex"/dist/*.css themes/anatole/assets/

while IFS= read -r file_to_copy
do
    echo "$file_to_copy"
    sourcefile=$(echo "$file_to_copy" | cut -d ' ' -f 1)
    destfile=$(echo "$file_to_copy" | cut -d ' ' -f 2-)
    cp "$extraContent/$sourcefile" "$destfile"
done < "$extraContent/map.txt"

/bin/sh "${buildHugo}/run.sh" . ./output
