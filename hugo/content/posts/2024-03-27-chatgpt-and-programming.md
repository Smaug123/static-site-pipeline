---
lastmod: "2024-03-27T12:01:00.0000000+00:00"
author: patrick
date: "2024-03-27T12:01:00.0000000+00:00"
title: ChatGPT's effect on my programming
summary: "After a decent while programming with ChatGPT, I'm not sure it's even a net positive on my ability."
categories:
- programming
---

For almost a year now, I've had access to ChatGPT 4.
In that time, I've used it pretty extensively, I have some large custom instructions to try and get it to be precise and accurate, and so forth.
After a particularly gruelling weekend [getting my Neovim environment up to scratch](https://github.com/Smaug123/nix-dotfiles/pull/38/files), in which I used ChatGPT for approximately 70 distinct chats (some of which were quite long), I decided to put down some thoughts.

# Where is ChatGPT good?

* Language-to-language translation. Bog-standard line-for-line translation of Vimscript to Lua went pretty much perfectly each time. However, ChatGPT never flagged places where I was doing things that were simply unnecessary or wrong, and a human who understood Neovim would have done. (For example, there are Vim options which make no sense in Neovim and are silently ignored.)
* Fixing syntax, if you don't have a decent language server doing that for you. It's worse than a proper language server, but better than nothing.
* Explaining what code is doing, if you don't want to dig too deep but just want a general gist.

# On using ChatGPT to write code for me

This is where ChatGPT is really pernicious.
It's *so* tempting to use its output without putting in the work of building a mental model, but this *never* works.

I think on balance the presence of ChatGPT might actually have slowed down my Neovim migration, because it allowed me to get 80% of the way there without learning the domain at all.
To get the final 20%, you need to understand the domain, but it takes a great deal of discipline to do so when ChatGPT is ready to give you implementations that almost work without any thought at all.
I don't really have that discipline, and I think I would have been better off simply with a search engine.

(The [Neovim API docs](https://neovim.io/doc/user/api.html) are generally awful.
They'd be adequate if they were documenting an API in a language with a decent type system, but Lua is untyped so the amount of documentation required is at least 3x bigger.
The poor quality of the documentation adds extra friction if you want to learn what you're doing: it's more attractive to just not learn, if learning involves reading large amounts of an unfamiliar language in the guts of the implementation of a system you don't know.
[Looking](https://github.com/dotnet/dotnet-api-docs/pull/9753) [at](https://github.com/dotnet/dotnet-api-docs/pull/9595) [you](https://github.com/dotnet/runtime/pull/95956) [too](https://github.com/dotnet/docs/pull/35171), [.NET](https://github.com/dotnet/dotnet-api-docs/pull/9394).)

I can imagine that ChatGPT 5 would be adequate for writing code for me, but right now I think the time it saves on starting you up (and getting you 80% of the way) is more than eaten up by the amount of learning/fixing/debugging that it makes you do in the future.
There's a really high cost to not having a good mental model of what you're doing, and ChatGPT makes it far too easy to put yourself in that debt.

# What about Opus?

Claude 3 Opus [has had a lot of hype](https://thezvi.substack.com/p/on-claude-30) for its coding abilities, but over the past few days I've been running side-by-side comparisons with ChatGPT and there's simply no contest.
ChatGPT gives better answers: they're more likely to be correct, and they're almost always more useful even when wrong.
I have not yet got a single correct code snippet out of Opus.

# What I actually want from such a system

A really really good search engine, which has consumed all the relevant documentation.
Claude 3 Opus's chat interface won't take more than 16% of the [home-manager documentation](https://nix-community.github.io/home-manager/options.xhtml), and the [POSIX spec](https://pubs.opengroup.org/onlinepubs/9699919799.2018edition/) is orders of magnitude too big.
(Perhaps I need to suck it up and start using the Claude API.)

What I need is to ask "Where precisely in the spec should I look to discover the behaviour in this particular case?", "Under what configuration option does one configure this thing?", "Can you show me some code in the wild where someone is successfully using this?".

