---
lastmod: "2021-09-12T22:47:44.0000000+01:00"
author: patrick
categories:
- uncategorized
comments: true
date: "2014-04-07T00:00:00Z"
math: true
aliases:
- /uncategorized/useful-conformal-mappings/
- /useful-conformal-mappings/
title: Useful conformal mappings
---
This post is to be a list of conformal mappings, so that I can get better at answering questions like "Find a conformal mapping from \<this domain\> to \<this domain\>". The following Mathematica code is rough-and-ready, but it is designed to demonstrate where a given region goes under a given transformation.

    whereRegionGoes[f_, pred_, xrange_, yrange_] := 

    whereRegionGoes[f, pred, xrange, yrange] = 
     With[{xlist = Join[{x}, xrange], ylist = Join[{y}, yrange]},
      ListPlot[
       Transpose@
        Through[{Re, Im}[
         f /@ (#[[1]] + #[[2]] I & /@ 
          Select[Flatten[Table[{x, y}, xlist, ylist], 1], 
           With[{z = #[[1]] + I #[[2]]}, pred[z]] &])]]]]

*   Möbius maps - these are of the form \\(z \mapsto \dfrac{az+b}{c z+d}\\). They keep circles and lines as circles and lines, so they are extremely useful when mapping a disc to a half-plane. A map is defined entirely by how it acts on any three points: there is a unique Möbius map taking any three points to any three points (and hence any circle/line to circle/line). (Some of the following are Möbius maps.)
*   To take the unit disc to the upper half plane, \\(z \mapsto \dfrac{z-i}{i z-1\\)}
*   To take the upper half plane to the unit disc, \\(z \mapsto \dfrac{z-i}{z+i}\\) (the [Cayley transform][1])
*   To rotate by 90 degrees about the origin, \\(z \mapsto i \\)z
*   To translate by \\(a\\), \\(z \mapsto a+\\)z
*   To scale by factor \\(a \in \mathbb{R}\\) from the origin, \\(z \mapsto a \\)z
*   \\(z \mapsto exp(z)\\) takes a vertical strip to an annulus - but note that it is not bijective, because its domain is simply connected while its range is not.
*   \\(z \mapsto exp(z)\\) takes a horizontal strip, width \\(\pi\\) centred on \\(\mathbb{R}\\) onto the right-half-plane.

## Maps which might not be conformal

These maps are useful but we can only use them when the domain doesn't include a point where \\(f'(z) = 0\\) (as that would stop the map from being conformal).

*   To "broaden" a wedge symmetric about the real axis pointing rightwards, \\(z \mapsto z^\\)2
*   To take a half-strip \\(Re(z) > 0, 0 < Im(z) < \dfrac{\pi}{2}\\) to the top-right quadrant: \\(z \mapsto \sinh(z\\))
*   to take a half-strip \\(Im(z) > 0, -\frac{\pi}{2} < Re(z) < \frac{\pi}{2}\\) to the upper half plane, \\(z \mapsto \sin(z\\))

 [1]: https://en.wikipedia.org/wiki/Cayley_transform#Conformal_map "Cayley transform Wikipedia page"
