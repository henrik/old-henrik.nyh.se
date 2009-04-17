--- 
wordpress_id: 102
title: YouTube thumbnail animator
tags: 
- Greasemonkey
- JavaScript
- Firefox
---
The <a href="http://www.37signals.com/svn/">Signal vs. Noise blog</a> had an <a href="http://www.37signals.com/svn/posts/266-using-small-multiples-to-get-to-aha">interesting post</a> about using flipbook-style image sets to visualize things like dance moves and movie clips in a scannable way.

This inspired me to poke around on <a href="http://www.youtube.com">YouTube</a>. To my surprise, I found that they actually provide three stills from each movie, with predictable URLs (thumbnail URLs end with <code>/2.jpg</code>; the other frames are <code>/1.jpg</code> and <code>/3.jpg</code>). However, YouTube only displays a single still, as the thumbnail.

So I wrote a Greasemonkey script that flips thumbnails between all three images at very short intervals, essentially animating them: <a href="http://userscripts.org/scripts/show/7504">YouTube thumbnail animator</a>.

<p class="center"><img src="http://henrik.nyh.se/filer/youtubethumbanim.gif" alt="" class="bordered" /></p>

Now, this isn't really the scannable sequential imagery of the Signal vs. Noise post, but it's still cool and rather useful. Perhaps a bit CPU-greedy.
