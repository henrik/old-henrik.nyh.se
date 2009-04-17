--- 
wordpress_id: 192
title: Hide Leopard stack overlays in Finder
tags: 
- OS X
- AppleScript
---
A tumblelog named XD had <a href="http://t.ecksdee.org/post/19001860">a post on adding nice half-icon overlays to Leopard stacks</a> (the below image is from that post).

<p class="center"><img src="http://henrik.nyh.se/uploads/xd-stacks.jpg" class="bordered" alt="[Screenshot]" /></p>

The log does not allow comments, so I'm blogging some minor improvements to this technique:

<h4>Handle any sorting</h4>

I want my <code>Downloads</code> stack to be sorted by date added, not date modified as in that post. Just change the <code>m</code> to an <code>a</code>:

{% highlight text %}
touch -at 202001010101.01 " Icon"
{% endhighlight %}
Note that I've named the icon " Icon" with an initial space. This is so that I can use the same naming scheme with stacks that I sort by name (in my case, my home folder). The reason for using a consistent naming scheme is revealed below.

<h4>Hide the overlay icon in Finder</h4>

A necessary evil to the overlay trick is that you need to keep an icon file sorted at the top of the stack. To my knowledge, you can't hide it from the expanded stack – well, you can (by renaming it to something starting with a <code>.</code>, like <code>.Icon</code>) but then it's not overlayed…

<!--more-->

You <em>can</em>, however, hide it from the Finder by toggling the file's invisible bit. It will still display in the expanded stack (alas) and as an icon overlay (w00t). You can do

{% highlight text %}
chflags hidden " Icon"
{% endhighlight %}
If you want to unhide it, do

{% highlight text %}
chflags nohidden " Icon"
{% endhighlight %}

However, it turns out that the next time the stack refreshes – that is, the next time a file is added, renamed or removed – it will notice that the file is hidden, and you lose the overlay.

Now, this is a bit too kludgy even for me, but I couldn't resist. I made a folder action that is triggered when a file is added, renamed or removed, and that will show the icon, force a stack refresh, and then hide the action again. What this amounts to is that when the stack changes, you'll only see a short flash of non-overlayness, and then the overlay is re-applied, and does not appear in Finder.

I didn't particularly mind seeing the overlay icon my <code>Downloads</code> folder, but the " Icon" file next to the folders in my home directory was quite annoying.

The folder action is here: <a href="http://henrik.nyh.se/uploads/Peekaboo%20Stack%20Overlay.scpt">Peekaboo Stack Overlay.scpt</a>

See <a href="http://henrik.nyh.se/2007/10/lift-the-leopard-download-quarantine">this post</a> for how to apply it.

This folder action explains why I used the " Icons" (with an initial space) name in the <code>Downloads</code> stack as well – the same folder action, with a hard-coded icon name, can be used for multiple stacks.

<h4>The code</h4>

{% highlight applescript %}
(*
"Peekaboo Stack Overlay" by Henrik Nyh <http://henrik.nyh.se/2007/11/hide-leopard-stack-overlays-in-finder>
This Folder Action handler is triggered whenever items are added to or removed from the attached folder (and indirectly when they're renamed).
When that happens, it will juggle visible bits and temp files to make the stack reload while the icon is non-hidden, and then hides it again. The end result is that you can keep the icon file hidden in the Finder but still see it overlayed on the stack (and in the expanded stack, alas).
This script assumes an icon named " Icon" (with the space, so it sorts first in alphabetical stacks).
*)

on adding folder items to thisFolder
  reapplyStackOverlay(thisFolder)
end adding folder items to

on removing folder items from thisFolder
  reapplyStackOverlay(thisFolder)
end removing folder items from

on reapplyStackOverlay(thisFolder)
  -- Something happened to reload the stack.
  set folderPath to (POSIX path of (thisFolder as alias))
  set iconPath to folderPath & "/" & " Icon"
  set triggerFile to folderPath & "/" & ".force_stack_reload"
  -- Unhide icon
  do shell script "chflags nohidden " & (quoted form of iconPath)
  -- Force stack to reload
  do shell script "touch " & (quoted form of triggerFile)
  do shell script "rm -f " & (quoted form of triggerFile)
  -- Hide icon
  do shell script "chflags hidden " & (quoted form of iconPath)
end reapplyStackOverlay
{% endhighlight %}
