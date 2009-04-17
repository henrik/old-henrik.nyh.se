--- 
wordpress_id: 185
title: "\"Open Terminal Here\" and lselect (glob select) in Leopard Finder"
tags: 
- OS X
- Design
---
<p class="center"><img src="http://henrik.nyh.se/uploads/finder-leopard-buttons.png" alt="[Screenshot]" class="bordered"></p>

You can drag scripts to the Finder toolbar and later trigger them with a click.

For a while, my Finder toolbar has been home to <a href="http://anoved.net/lselect.html">lselect</a> by Jim DeVona, which allows selecting files by <a href="http://en.wikipedia.org/wiki/Glob_%28programming%29">globs</a>; and <a href="http://www.entropy.ch/software/applescript/">Open Terminal Here</a> by Marc Liyanage, which does just that.

Under Tiger, I hacked together icons that matched the toolbar icon look. I just updated the icons for Leopard. See screenshot above.

Now, icons in OS X are a pain. No matter what I try, they are the wrong size or distorted in one way or the other. What worked best of what I've tried is to replace the <code>.icns</code> file inside each script bundle.

Right-click lselect in the Finder, "Show Package Contents", then save <a href="http://henrik.nyh.se/uploads/lselect-applet.icns">this file</a> over <code>Contents/Resources/applet.icns</code>.

With Open Terminal Here, instead replace <code>Contents/Resources/droplet.icns</code> with <a href="http://henrik.nyh.se/uploads/openterminalhere-droplet.icns">this file</a>.

All done.

As a bonus tip, I just realized I can use lselect to find files by name substring in folders that aren't indexed by Spotlight, e.g. searching for <code>*colloquy*</code> in <code>~/Library/Preferences</code>. Nice.
