--- 
wordpress_id: 205
title: TextMate command to prevent em spaces
tags: 
- OS X
- TextMate
---
Pressing <code>⌥+space</code> instead of just <code>space</code> is an easy mistake to make, especially if you just used <code>⌥</code> for something else.

In Cocoa text fields, <code>⌥+space</code> inserts a typographical em space, which e.g. Ruby's parser does not treat as a regular space. Painful debugging ensues. Even after being bitten by this several times, it still gets me now and then.

I finally got around to fixing it: the <a href="http://henrik.nyh.se/uploads/Prevent Em Space.tmCommand">Prevent Em Space</a> TextMate command slips into the Source bundle and simply outputs a regular space if you press <code>⌥+space</code>.
