#!/bin/sh

OUTPUT="$(pwd)/public"
export OUTPUT

docker build docker/html -t build-html || exit 1

echo Validating HTML.
docker run --user "$(id -u):$(id -g)" -v "$OUTPUT:/public" build-html sh -c "/build.sh" || exit 1
