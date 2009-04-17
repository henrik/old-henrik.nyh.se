--- 
wordpress_id: 66
title: View source from Firefox with TextMate
tags: 
- OS X
- TextMate
- Firefox
---
I figured I should briefly write up how to configure Firefox to view a page's HTML source using <a href="http://www.macromates.com">TextMate</a> rather than the built-in Firefox source viewer, since googling it didn't turn up anything useful.

<!--more-->

<h4>Instructions</h4>

Install the <a href="https://addons.mozilla.org/firefox/394/">ViewSourceWith extension</a>.

Restart Firefox to complete the installation.

Open the ViewSourceWith settings by going to <code>Tools &gt; Add-ons</code> and double-clicking ViewSourceWith.

<p class="center"><img src="http://henrik.nyh.se/uploads/viewsourcewithtm-config.png" alt="[ViewSourceWith settings]" /></p>

On the "Main" tab of the settings, by the "Editor list", click "New".

In the pane that appears, input this:

<strong>Editor path:</strong> <code>/usr/bin/open</code>
<strong>Description:</strong> <code>TextMate</code>
<strong>Parameters:</strong> <code>-a "TextMate" $f</code>

<p class="center"><img src="http://henrik.nyh.se/uploads/viewsourcewithtm-configpane2.png" alt="[ViewSourceWith editor pane]" /></p>

If you installed the <code>mate</code> command line utility with TextMate, you could optionally do this instead:

<strong>Editor path:</strong> <code>/usr/bin/mate</code>
<strong>Description:</strong> <code>TextMate</code>
<strong>Parameters:</strong> <code>$f</code>

<p class="center"><img src="http://henrik.nyh.se/uploads/viewsourcewithtm-configpane.png" alt="[ViewSourceWith editor pane]" /></p>

Settting the editor path to <code>/Applications/TextMate.app</code> will, for whatever reason, open a new TextMate in the dock for every sourceview.

Confirm those settings.

If "Use in place of native message/page source menu item" is checked in the "Advanced" part of the settings, TextMate will replace the built-in source viewer. Otherwise, TextMate will be an option in <code>View &gt; Source With</code>. You might need to restart Firefox for changes to this value to kick in. 

<p class="center"><img src="http://henrik.nyh.se/uploads/viewsourcewithtm-advanced.png" alt="[ViewSourceWith advanced settings]" /></p>

All done!
