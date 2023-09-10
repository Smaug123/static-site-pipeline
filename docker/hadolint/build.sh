#!/bin/sh

find /work -type f -name 'Dockerfile' -print0 | xargs -0 -n1 hadolint