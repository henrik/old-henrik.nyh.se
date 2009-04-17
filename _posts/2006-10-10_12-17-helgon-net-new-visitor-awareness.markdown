--- 
wordpress_id: 68
title: Helgon.net new visitor awareness
tags: 
- Greasemonkey
- JavaScript
- Firefox
---
I wrote another Greasemonkey script for Helgon.net: <a href="http://userscripts.org/scripts/show/5919">Helgon.net new visitor awareness</a>.

<p class="center"><img src="http://henrik.nyh.se/uploads/gmhelgonvisitorawareness.png" alt="[Screenshot]" /></p>

<!--more-->

The script adds a count of <em>new</em> visitors next to the count of total visitors, and also highlights them on the page listing most recent visitors.

Every time you visit your own user presentation page, the total visitor count is retrieved and stored. The next time you visit the page listing your most recent visitors, that total visitor count is stored as the "seen visitors" count. The difference between the total visitor count and the seen visitors count is the number of new visitors.

One shortcoming of this solution is that since the total visitor count is only updated when visiting your presentation page, you have to access the recent visitors page through it in order to get accurate highlighting. I might code around this at some point in the future, but it's low priority as it's not a fatal error, probably rather tricky to solve, and only an issue if you've weird usage patterns.

By default old visitors are decreased in opacity in the visitor listing. The script adds certain CSS classes to every old visitor, every new visitor, the first new visitor and the last new visitor, respectively, so changing the highlighting style only takes CSS knowledge.
