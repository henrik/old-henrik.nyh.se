--- 
wordpress_id: 231
title: iPhoto Library Manager shortcuts with drag-and-drop importing
tags: 
- OS X
- AppleScript
- iPhoto
---
<p class="center"><img src="http://henrik.nyh.se/uploads/iphoto-libraries.png" alt="" class="bordered" /></a></p>

<a href="http://johannaost.com">My girlfriend</a> is now on OS X.

Being an artist, she's very visual. Her digital picture collection – fashion photography, interior design, animals, David Duchovny etc – contains over 9 000 pictures.

She also has some 7 000 photos of her own – of herself, family and friends.

I've looked at a bunch of apps for organizing pictures, and I think iPhoto with <a href="http://www.bullstorm.se/KeywordManager.php">Keyword Manager</a> is the best fit.

We use two iPhoto libraries for the two sets of pictures (collection and personal). iPhoto has basic support for multiple libraries, but it's hard to use without something like <a href="http://www.fatcatsoftware.com/iplm/">iPhoto Library Manager</a>.

iPhoto Library Manager lets you (at least if you've registered) create library shortcut files that you can put in the dock (on the right-hand side where files, as opposed to apps, go).

I wanted to make the experience a bit smoother still, though, so I whipped up <a href="http://pastie.textmate.org/202713">this small AppleScript</a>.

Modify it with the right library name, then save it in Script Editor as an application (I keep them in <code>~/Library/Scripts</code>), then stick it in the dock (the left part, where apps go). Create one for each library.

Clicking the app will switch to that library (if not already the active library). Dragging files or folders to the app will switch to that library and then import those files and folders into it. Since OS X is clever about drag-and-drop, you can even drag photos straight from Photo Booth.

<h4>Bonus feature</h4>

The <a href="http://softbend.free.fr/mimifoto/index.html">mimiFoto</a> app can create iPhoto icons with your custom photo, as seen at the top of this post.

mimiFoto will assign the icon to iPhoto, but you can <a href="http://docs.info.apple.com/article.html?artnum=304735">copy it across</a> to the script and then reset the iPhoto icon (select and delete the icon in the Info window).
