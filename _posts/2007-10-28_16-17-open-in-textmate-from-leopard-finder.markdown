--- 
wordpress_id: 186
title: "\"Open in TextMate\" from Leopard Finder"
tags: 
- OS X
- TextMate
- AppleScript
- Design
---
<p class="center"><img src="http://henrik.nyh.se/uploads/finder-leopard-tm.png" class="bordered" alt="[Screenshot]" /></p>

By <a href="http://henrik.nyh.se/2007/10/open-terminal-here-and-glob-select-in-leopard-finder#comment-57404">request</a>, I did an "Open In TextMate" Finder toolbar icon for Leopard.

I also took the opportunity to write a new script, based on <a href="http://snippets.dzone.com/posts/show/1037">Simon Dorfman's</a>. Clicking the toolbar icon now opens the selected file or files if there is a selection; otherwise it opens the current directory. You can also drag-and-drop files to the icon to open those.

Behind the scenes, the script is all AppleScript, without dropping into the shell. Feels a bit more robust.

A single TextMate window will open, containing all selected or dropped items in a project.

I put my icon inside the bundle, so it should appear with no extra effort. I also toggled a flag in the bundle so you don't see the script appear and disappear in the dock when triggered.

Download <a href="http://henrik.nyh.se/uploads/OpenInTextMate.zip">OpenInTextMate.zip</a>, extract the file somewhere (I keep it in <code>/Applications/Scripts</code>), then drag it onto the Finder toolbar. You'll need to wiggle it a bit for the toolbar to catch on.

If you like your toolbar all grayscale, feel free to use <a href="http://henrik.nyh.se/uploads/openintextmate-droplet.icns"><img src="http://henrik.nyh.se/uploads/openintextmate-droplet.png" alt="[tm]" /></a> (save the linked icon file, <em>not</em> the displayed PNG image)  instead, and copy it into the script as <a href="http://henrik.nyh.se/2007/10/open-terminal-here-and-glob-select-in-leopard-finder">described here</a>.

The code:

<!--more-->

{% highlight applescript %}
-- Opens the currently selected Finder files, or else the current Finder window, in TextMate. Also handles dropped files and folders.

-- By Henrik Nyh <http://henrik.nyh.se>
-- Based loosely on http://snippets.dzone.com/posts/show/1037

-- script was clicked
on run
  tell application "Finder"
    if selection is {} then
      set finderSelection to folder of the front window as string
    else
      set finderSelection to selection as alias list
    end if
  end tell
  
  tm(finderSelection)
end run

-- script was drag-and-dropped onto
on open(theList)
  tm(theList)
end open

-- open in TextMate
on tm(listOfAliases)
  tell application "TextMate"
    open listOfAliases
    activate
  end tell
end tm

{% endhighlight %}
