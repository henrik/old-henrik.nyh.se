--- 
wordpress_id: 61
title: Associate commenters with comments on Feber.se
tags: 
- Firefox
- CSS
- Userstyles
---
I made my first userstyle: <a href="http://userstyles.org/style/show/996">Feber.se associate commenters with comments</a>.

Userstyles are like userscripts (Greasemonkey scripts) but for CSS rather than JavaScript. You can modify CSS with userscripts as well, but I assume a userstyle will have less overhead.

The point of this particular userstyle is to make it obvious who commented on what, on the various <a href="http://www.feber.se">Feber.se</a> sites.

<!--more-->

Before applying the style, a commenter's name appears closer to the body of the previous comment than to its own comment text, causing confusion. After, whitespace is adjusted (according to Gestalt laws of proximity) and a colon inserted (suggesting that the name is associated with whatever follows):

<h5>Before:</h5>
<img src="http://henrik.nyh.se/uploads/css-feber-before.png" alt="[Before]" />

<h5>After:</h5>
<img src="http://henrik.nyh.se/uploads/css-feber-after.png" alt="[After]" />
