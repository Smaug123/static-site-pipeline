---
lastmod: "2022-07-31T20:16:44.0000000+01:00"
title: About this website
author: patrick
layout: page
---

This website has been around in one form or another since June 26th, 2013.

The website is hosted on [DigitalOcean] and is served statically by [NGINX].
[Cloudflare] is sitting between my DigitalOcean droplet and you.
Your HTTPS connection is secure to Cloudflare, and secure from Cloudflare to the droplet.

The rendering engines are [Hugo] for the site, [pdftex] for PDFs, and [ImageMagick] to create image thumbnails.
The Hugo theme is [Anatole] with a variety of modifications, most notably to remove most uses of JavaScript and to incorporate [Danila Fedore's sidenotes](https://danilafe.com/blog/sidenotes/) ([archive](https://web.archive.org/web/20210116232126/https://danilafe.com/blog/sidenotes/)).
Mathematical notation in HTML is rendered by [KaTeX].

You can access the TeX source of any PDFs I authored in TeX, by replacing the ".pdf" extension with ".tex".

The infrastructure for this website is defined and managed by [Pulumi]; you can see it [on GitHub](https://github.com/Smaug123/PulumiConfig/).
That repository also specifies the [Nix] configuration for the server.

 [static]: https://en.wikipedia.org/wiki/Static_web_page
 [GitHub Pages]: https://pages.github.com
 [Hugo]: https://gohugo.io/
 [Wordpress]: https://wordpress.org
 [Anatole]: https://themes.gohugo.io/anatole/
 [CloudFlare]: https://www.cloudflare.com
 [DigitalOcean]: https://www.digitalocean.com
 [NGINX]: https://www.nginx.com/
 [pdftex]: https://www.tug.org/applications/pdftex/
 [ImageMagick]: https://imagemagick.org/index.php
 [KaTeX]: https://katex.org/
 [Pulumi]: https://www.pulumi.com
 [Nix]: https://nixos.org/
