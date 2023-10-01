#!/bin/sh

SOURCE_DIR=$(readlink -f "$1")
OUTPUT_DIR=$(readlink -f "$2")

rm -rf "${OUTPUT_DIR:?}/*" &&
  hugo --minify --source "$SOURCE_DIR" --destination "$OUTPUT_DIR"
