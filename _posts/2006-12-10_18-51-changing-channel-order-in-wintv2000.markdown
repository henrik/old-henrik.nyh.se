--- 
wordpress_id: 83
title: Changing channel order in WinTV2000
tags: 
- Hardware
- Windows
---
Today is my younger brother's 15th birthday. One of his presents was a TV card, Hauppauge WinTV PVR-150.

The bundled software, WinTV2000, seemed decent enough except for the "alien skin condition" look-and-feel, and the fact that you seemingly couldn't reorder the channels.

If you add the channels through auto scanning, they'll rarely end up in the preferred order. We would have Swedish Channel 1 in slot 3 and whatnot. Adding the channels one by one by manual tuning will put them in sequential slots, but if you change your mind about the order, you'd have to do it over.

The Suite Manager/Channel Configuration window actually has a "Reorder" button, but it was disabled.

After quite some googling and a few dead ends, I think <a href="http://www.hauppauge.co.uk/board/showthread.php?t=2197">this post</a> solved the issue.

<!--more-->

One should simply change the channel settings into "Preset mode", rather than "Channel mode". You'll find this option under <code>Menu &gt; Configure &gt; Channels</code>.

<img src="http://henrik.nyh.se/uploads/wintv2000-preset_mode.png" alt="[WinTV2000 screenshot]" /> 

This enables the "Reorder" button in the <code>Menu &gt; Suite Manager</code> window.

<img src="http://henrik.nyh.se/uploads/wintv2000-reorder.png" alt="['Reorder' button screenshot]" />

Clicking that will replace it with arrows that can be used to move the channels around.

<img src="http://henrik.nyh.se/uploads/wintv2000-reordered.png" alt="[Arrow buttons screenshot]" />
