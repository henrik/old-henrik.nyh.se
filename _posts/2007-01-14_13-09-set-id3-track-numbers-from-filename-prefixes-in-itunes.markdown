--- 
wordpress_id: 94
title: Set ID3 track numbers from filename prefixes in iTunes
tags: 
- OS X
- AppleScript
---
I wrote an AppleScript (<a href="http://henrik.nyh.se/uploads/ID3%20Track%20Numbers%20from%20Filename%20Prefixes.scpt">download</a>) for iTunes to set ID3 (metadata) track numbers from number prefixes (ignoring leading zeros) in the filenames. So for filenames like <code>01. Foo.mp3</code>, <code>2-Bar.mp3</code>, <code>003_Baz.mp3</code>, <code>4 Balloon.mp3</code> and <code>5Frou.mp3</code>, the track numbers will be set to <code>1</code>, <code>2</code>, <code>3</code>, <code>4</code> and <code>5</code> respectively.

For some reason, many MP3 songs I come across will be well-tagged except for the track number, though present in the filename.

<!--more-->

I still miss <a href="http://www.id3-tagit.de/english/index.htm">ID3-TagIT</a> (version 2, not 3) from my Windows days, but I think I'll get by pretty well with this script, <a href="http://www.dougscripts.com/itunes/scripts/ss.php?sp=trackparser">Track Parser</a> and <a href="http://www.dougscripts.com/itunes/scripts/ss.php?sp=filerenamer">File Renamer</a>.

Put the script in <code>~/Library/iTunes/Scripts</code>, creating the directory if it doesn't exist. A script menu (looking like a stylized scroll) should appear in iTunes. Select a couple of songs and choose the script from the menu to apply it.

I started out with <a href="http://www.dougscripts.com/itunes/scripts/ss.php?sp=filenamestosongnames">Filenames to Song Names</a> by Doug Adams. Instead of sticking the filename into the song name field, I pipe it through a Ruby one-liner and stick the result into the track number field.
