--- 
wordpress_id: 188
title: Lift the Leopard download quarantine
tags: 
- OS X
- AppleScript
---
A Vista-esque feature of OS X Leopard is that it tags web downloads (not just from Safari) as such and then warns you about running downloaded apps or scripts. Archived (e.g. zipped) files inherit the tag from their tagged container.

<p class="center"><img src="http://henrik.nyh.se/uploads/unquarantine.png" alt="[Screenshot]" /></p>

This is an annoyance to power users. Luckily, being a power user, I can do something about it. ;)

<!--more-->

Stick <a href="http://henrik.nyh.se/uploads/Unquarantine.scpt">Unquarantine.scpt</a> in <code>~/Library/Scripts/Folder Action Scripts</code>. You'll probably need to create the <code>Scripts</code> directory and its subdirectory, e.g. with <code>mkdir -p ~/Library/Scripts/Folder\ Action\ Scripts</code>.

Go to <code>~/Downloads</code> or wherever your downloads go.

Right-click, <code>More &gt; Configure Folder Actions…</code>. Check "Enable Folder Actions". Attach the "Unquarantine" action to the folder.

<p class="center"><img src="http://henrik.nyh.se/uploads/unquarantine-select.png" alt="[Screenshot]" /></p>

And that should be it.

Note that, quite obviously, the folder action only applies to that folder. If you download a file to a directory without this folder action attached, Leopard is free to nag again.

<h4>The code</h4>

Basically, the script just runs

{% highlight bash %}
xattr -d com.apple.quarantine "downloaded_file.zip"
{% endhighlight %}
Do <code>xattr -h</code> in a terminal for help (just <code>xattr</code> is silent, and there's no <code>man</code> page).

The code:

{% highlight applescript %}
(*
"Unquarantine" by Henrik Nyh <http://henrik.nyh.se/2007/10/lift-the-leopard-download-quarantine>
This Folder Action handler is triggered whenever items are added to the attached folder.
It gets rid of Leopard's annoying "this application was downloaded from the Internet" warnings by stripping the "quarantine" property.
*)

on adding folder items to thisFolder after receiving addedItems
  
  repeat with anItem in addedItems
    set anItem's contents to (quoted form of POSIX path of (anItem as alias))
  end repeat
  
  set AppleScript's text item delimiters to " "
  do shell script "xattr -d com.apple.quarantine " & (addedItems as text)
  
end adding folder items to

{% endhighlight %}
