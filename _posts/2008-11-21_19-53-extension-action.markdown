--- 
wordpress_id: 258
title: AppleScript Folder Action to add missing image extensions on download
tags: 
- OS X
- AppleScript
---
My girlfriend saves a lot of pictures off the web, daily.

She uses the <a href="https://addons.mozilla.org/en-US/firefox/addon/6639">Easy DragToGo</a> Firefox extension so she can just drag the image to save it to <code>~/Downloads</code>. She has a <a href="http://www.apple.com/macosx/features/desktop.html">stack</a> of that folder in the dock, so she can immediately see that it saved successfully.

But sometimes, an image will have an incorrect extension ("foo.php") or no extension ("foo"), and OS X will not show the thumbnail in the stack or in Finder, and won't know how to open the file.

Renaming manually is a bother, especially when you don't know what file type it's supposed to be. So I made an AppleScript <a href="http://www.simplehelp.net/2007/01/30/folder-actions-for-os-x-explained-with-real-world-examples/">Folder Action</a> that does this automatically.

When a new file appears in the folder, by being saved or moved there, the script uses the <code>file</code> command to get the file type (try <code>man file</code> for more info on how that works). Then, if the file type is JPG, PNG or GIF, and the filename extension does not match that file type, the correct extension is added.

The script is here: <a href="http://gist.github.com/27558">http://gist.github.com/27558</a>
