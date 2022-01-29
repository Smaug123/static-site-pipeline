#!/bin/sh

git remote add -f hugo-remote git@github.com:gohugoio/hugoBasicExample.git
git remote add -f images-remote git@github.com:Smaug123/static-site-images.git
git remote add -f meta-remote git@github.com:Smaug123/static-site-metadata.git
git remote add -f pdfs-remote git@github.com:Smaug123/static-site-pdfs.git

git checkout -b working

git subtree add --prefix hugo hugo-remote master --squash
git subtree add --prefix images images-remote main --squash
git subtree add --prefix pdfs pdfs-remote main --squash
git subtree add --prefix meta meta-remote main --squash
