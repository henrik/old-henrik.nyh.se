--- 
wordpress_id: 216
title: jQuery "more"/"less" HTML truncate
tags: 
- JavaScript
- jQuery
---
I previously made a <a href="http://henrik.nyh.se/2008/01/rails-truncate-html-helper">truncate helper for Rails</a> that handles HTML gracefully: doesn't split inside HTML entities, doesn't orphan end-tags and so on.

Truncating like this on the server-side is great in contexts where you don't want to show the full text as well, such as in an index of items.

Another common case for truncation is "more"/"less" links: you want to show the full text, such as a user's presentation, but for layout reasons a truncated snippet should be shown first, with a "more" link to disclose the rest. A "less" link gives you the snippet again.

In this case, doing it server-side isn't a great idea. Doing it unobtrusively with JavaScript is a better fit: the "hard" HTML source only needs to contain the full text.

I found myself wanting such a piece of JavaScript, but I couldn't find one that handled markup well. There is <a href="http://www.reindel.com/truncate/">Truncate</a>, but it's broken at the time of writing (as evidenced by its own <a href="http://www.reindel.com/truncate/#examples">example 3</a>).

So I rolled my own truncator, inspired by my Rails helper. It's a <a href="http://jquery.com/">jQuery</a> plugin.

I'm a bit short on time, so I'll just hook you up with <a href="http://henrik.nyh.se/examples/truncator">the jQuery HTML Truncator example page</a>. That page includes <a href="http://henrik.nyh.se/examples/truncator/jquery.truncator.js">the plugin itself</a>.

Enjoy, and please report bugs/improvements. Some parts could definitely do with prettying up.
