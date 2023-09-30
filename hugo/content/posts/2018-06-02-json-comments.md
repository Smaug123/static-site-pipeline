---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- hacker-news
- programming
comments: true
date: "2018-06-02T00:00:00Z"
title: JSON comments (a note from Hacker News)
summary: "A quick note from Hacker News about why the comment-handling situation in JSON is bad."
---

In response to [a linkpost](https://news.ycombinator.com/item?id=17358103) to [an article about how YAML isn't perfect](https://arp242.net/weblog/yaml_probably_not_so_great_after_all.html), [user jiveturkey](https://news.ycombinator.com/user?id=jiveturkey) [commented with confusion](https://news.ycombinator.com/item?id=17359727):

> > JSON doesn't support comments

> eh?
>
> `{ "firstName": "John", "lastName": "Smith", "comment": "foo", }`
>
> I know it isn't the same as `#comments`, but who cares really.

[I replied](https://news.ycombinator.com/item?id=17359800):

> The trouble there is that your comments come in-band. What if you're trying to serialise something and you don't have the power to insist that it's not a dictionary with "comment" as a key?
