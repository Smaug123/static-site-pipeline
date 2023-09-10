#!/bin/sh

rm -rf public
mkdir public || exit 1

DOCKERUSER="$(id -u):$(id -g)"
export DOCKERUSER
IMAGES="$(pwd)/images"
export IMAGES
PDFS="$(pwd)/pdfs"
export PDFS
HUGO="$(pwd)/hugo"
export HUGO
OUTPUT="$(pwd)/public"
export OUTPUT

docker build docker/hadolint -t build-hadolint || exit 1
docker run --user "$(id -u):$(id -g)" -v "$(pwd):/work" build-hadolint sh -c "/build.sh" || exit 1

docker build docker/shellcheck -t build-shellcheck || exit 1
docker run --user "$(id -u):$(id -g)" -v "$(pwd):/work" build-shellcheck sh -c "/build.sh /work" || exit 1

docker build docker/latex -t build-latex || exit 1
docker build docker/pictures -t build-pictures || exit 1
docker build docker/hugo -t build-hugo || exit 1

echo Building thumbnails.
docker run --user "$(id -u):$(id -g)" -v "$IMAGES:/output" build-pictures sh -c "/build.sh /output" || exit 1
while read -r d
do
    mkdir -p "$HUGO/$d" || exit 1
    DESIRED_LOCATION=$(basename "$d")
    DEST=$(dirname "$d")
    cp -r "$IMAGES/$DESIRED_LOCATION" "$HUGO/$DEST"
done < "$IMAGES/image-targets.txt"

echo Building LaTeX.
docker run --user "$(id -u):$(id -g)" -v "$PDFS:/inputs" build-latex sh -c "/build.sh /inputs" || exit 1
while read -r texfile
do
    DIR="$HUGO"/$(dirname "$texfile")
    TEXFILE_BASE=$(basename "$texfile")
    PDFFILE=$(basename "$texfile" .tex).pdf
    mkdir -p "$DIR"
    cp "$PDFS/$TEXFILE_BASE" "$DIR/"
    cp "$PDFS/$PDFFILE" "$DIR/"
done < "$PDFS/pdf-targets.txt"

echo Building site.
docker run --user "$(id -u):$(id -g)" -v "$HUGO:/hugo" -v "$OUTPUT:/output" build-hugo sh -c "/build.sh /hugo /output" || exit 1

echo Done.
