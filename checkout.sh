#!/bin/sh

get_remote() {
    url_name="$1"
    url_remote="$2"
    git remote get-url "$url_name" 2>/dev/null 1>/dev/null || git remote add -f "$url_name" "$url_remote"
}

get_remote hugo-remote git@github.com:gohugoio/hugoBasicExample.git
get_remote images-remote git@github.com:Smaug123/static-site-images.git
get_remote meta-remote git@github.com:Smaug123/static-site-metadata.git
get_remote pdfs-remote git@github.com:Smaug123/static-site-pdfs.git

git checkout -b working

git subtree add --prefix hugo hugo-remote master --squash
git subtree add --prefix images images-remote main --squash
git subtree add --prefix pdfs pdfs-remote main --squash
git subtree add --prefix meta meta-remote main --squash
