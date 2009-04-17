--- 
wordpress_id: 224
title: MacBook Air volume icon
tags: 
- OS X
- MacBook Air
---
I finally got a nice volume icon working for my Air:

<p class="center"><img src="http://henrik.nyh.se/uploads/air-icon.png" alt="[Air icon]" class="bordered" /></p>

Since this was slightly convoluted, I thought I'd do a quick write-up.

<!--more-->

The icon itself is <code>/System/Library/CoreServices/CoreTypes.bundle/ Contents/Resources/com.apple.macbookair.icns</code> (discovered <a href="http://macthemes2.net/forum/viewtopic.php?pid=225040">here</a>).

Assigning icons can be tricky in OS X, as I described in <a href="http://henrik.nyh.se/2007/08/os-x-icons">an earlier post</a>. I had no luck with <a href="http://www.icons.cx/goodies/">icns2icon</a> this time, even when I tried very liberal permissions, so I went with the kludge described in that post (sticking the icon in an app bundle) instead.

I was then able to copy-and-paste the icon as the icon of the <code>icns</code> file itself, but for some reason I was still unable to make it the icon of my system volume.

<a href="http://henrik.nyh.se/uploads/air.icns.zip">Here</a> is the icon file with itself as its icon, to save you some work. The download is an archive since the icon wouldn't stick otherwise.

I ended up having to use <a href="http://www.panic.com/candybar/">CandyBar</a> (which has a free trial). In CandyBar, I just dragged the fixed icon file to the volume.
