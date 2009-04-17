--- 
wordpress_id: 13
title: Navigate anything like Bloglines
tags: 
- Greasemonkey
- JavaScript
- Firefox
---
The online service <a href="http://www.bloglines.com">Bloglines</a> is my RSS reader of choice. I recently discovered and came to like their keyboard shortcuts. When reading entries, hitting the "j" key will scroll to the next entry; "k" will scroll to the previous entry.

I thought it'd be nice to have the same functionality on forums and blogs, so I wrote a Greasemonkey script: <a href="http://userscripts.org/scripts/show/4886">Navigate anything like Bloglines</a>.


<!--more-->

By default, the script works for a handful of sites. It's easily extended to work for pretty much any site, if you know XPath and basic regular expressions.

Scrolling smoothly rather than jumping in a single step is not, by the way, bells and whistles but rather makes it comfortably clear that you are sent where you intended without skipping any entries.

The script was obviously inspired by Bloglines and uses some code derived from theirs. The smooth scrolling is due to <a href="http://ecmanaut.blogspot.com/2005/10/smooth-scrolling-between-anchors.html">Johan Sundström</a>.
