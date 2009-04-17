--- 
wordpress_id: 189
title: Making Leopard toolbar buttons
tags: 
- OS X
- Design
---
I recently blogged about toolbar buttons for Leopard's Finder (<a href="http://henrik.nyh.se/2007/10/open-in-textmate-from-leopard-finder">for opening in TextMate</a> and <a href="http://henrik.nyh.se/2007/10/open-terminal-here-and-glob-select-in-leopard-finder">some other useful scripts</a>).

Today, I spent some more time fiddling with the buttons. I added the brighter line below the buttons and made the corners transparent, so the buttons look better when depressed and inactivated (as they will be in Time Machine). They don't match the "real" toolbar icons fully: e.g. the brighter line, not just the icon proper, will darken when depressed and inactivated, but I don't think you can get around that. The built-in toolbar icons are likely something else than <code>.icns</code> files.

I updated the previous posts with the slightly improved icons. I also figured I would share the template I made, in case someone wants to make their own.

<!--more-->

Photoshop file: <a href="http://henrik.nyh.se/uploads/leopard-toolbar-button.psd">leopard-toolbar-button.psd</a>.

Note that the text layer has an outer glow layer effect, to approximate the etched look. (I'm sure someone can improve upon this. Please do share.)

Edit that file, then Save For Web as PNG-24 with transparency.

Open <code>/Developer/Applications/Utilities/Icon Composer.app</code>. Icon Composer comes with the Developer Tools on your Leopard disk. Install if you didn't already. The entire set of Developer Tools amounts to several gigabytes, but hopefully you can pick-and-choose if you don't want the rest.

<p class="center"><img src="http://henrik.nyh.se/uploads/icon-composer-toolbar.png" alt="[Screenshot]" /></p>

Drag your icon to the "32" (32 * 32 pixels) field. Select "Use for this size only" when prompted.

Now, just save and you'll have an icon.

See <a href="http://henrik.nyh.se/2007/10/open-terminal-here-and-glob-select-in-leopard-finder">my earlier post</a> for how to get the icon in your script's belly.
