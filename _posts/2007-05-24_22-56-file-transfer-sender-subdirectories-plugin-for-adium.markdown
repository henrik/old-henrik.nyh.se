--- 
wordpress_id: 142
title: File Transfer Sender Subdirectories plugin for Adium
tags: 
- OS X
- Cocoa
- Adium
---
In my Windows days, I used <a href="http://www.miranda-im.org/">Miranda</a> for IM. On OS X, I use <a href="http://www.adiumx.com/">Adium</a>.

Miranda allows you to specify per-user directories for incoming file transfers. So you might end up with <code>Incoming/IM/John Doe/female_deer.jpg</code> and <code>Incoming/IM/Foo Barr/baz.pdf</code>. Adium, on the other hand, will put everything in a single download directory. I don't like this; I want what Miranda does.

I've asked about this feature on <a href="irc://irc.freenode.net/adium">#adium@Freenode</a> but was told, or got the impression, that the developers do not want this and aren't likely to add it. So I wrote a plugin.

<!--more-->

Download the plugin: <a href="http://henrik.nyh.se/uploads/FileTransferSenderSubdirectoriesPlugin.AdiumPlugin.zip">File Transfer Sender Subdirectories</a> (<a href="http://svn.nyh.se/cocoa/FileTransferSenderSubdirectoriesPlugin/">SVN source</A>).

To install, double-click the unzipped plugin or drag it to the Adium dock icon.

Note that the plugin has only been tested with MSN (single file) transfers since those are the only file transfers that ever work for me in Adium (with or without this plugin). Please let me know if it works or not with other protocols and multiple files so that I can remove this notice.

If your Adium is configured to automatically accept files, things should Just Work. If you're prompted for the download directory, going with the default directory (the "Save files to" directory in the File Transfer settings) will cause the file(s) to go into a sender subdirectory. If any directory other than the default directory is selected, the file(s) will go where specified and not into a subdirectory.

The plugin is clever enough to re-use the same subdirectory for a user even if their display name changes. It will be re-used even if the folder itself is renamed, as long as the folder name is either the same as the user ID (ICQ UIN, MSN e-mail address etc) or ends with the user ID in parentheses and preceded by a space, like "Renamed Friend (user.id@hotmail.com)".
