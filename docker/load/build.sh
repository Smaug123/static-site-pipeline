#!/bin/sh

rm -f /sentinels/load.txt

rm -rf -- /output/*
cp -Rf /git/. /output || exit 1

chmod -R a+rw /output || exit 1

touch /sentinels/load.txt