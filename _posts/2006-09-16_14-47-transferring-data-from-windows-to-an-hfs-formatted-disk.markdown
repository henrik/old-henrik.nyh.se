--- 
wordpress_id: 60
title: Transferring data from Windows to an HFS+ formatted disk
tags: 
- OS X
---
Much of this is probably obvious, but I'm writing this mainly for other Win/OS X file transfer newbies and my future self.

I got a new hard disk drive (500 GB) yesterday, to use as external FireWire/USB drive with my MacBook.

I transferred about 100 GBs of data from my old NTFS-formatted external HDD to a computer running Windows, because that computer had loads of free space. Then I put the new HDD in the enclosure.

All that remained was a simple matter of transferring the data from Windows to my new HDD &ndash; or so I thought.

<!--more-->

<h4>MacDrive</h4>

OS X can read but not write NTFS. Both OS X and Windows can read and write FAT32, but it limits file sizes to a maximum of 4 GB. OS X prefers HFS+, but Windows cannot read or write that without e.g. <a href="http://www.mediafour.com/products/macdrive6/">MacDrive</a>.

I formatted the drive with HFS+ and installed the MacDrive trial under Windows. Things went well initially, but after a while I got a Blue Screen of Death (IRQL_NOT_LESS_THAN_OR_EQUAL). This fouled up the file system, so the disk had to be reformatted. Good thing I didn't have anything else on the new drive.

I tried again, after <a href="http://assist.mediafour.com/index.php?_a=knowledgebase&_j=questiondetails&_i=77">uninstalling Daemon Tools and the SPTD driver</a> since they are apparently in conflict with MacDrive. Still got a <abbr title="Blue Screen of Death">BSOD</abbr> and had to reformat.

At this point, I considered FAT32, but it seemed silly to use an ancient file system just for one transfer from Windows, and more importantly because backup archives could go way above 4 GB.

<h4>SMB</h4>

Instead, I <a href="http://www.networkworld.com/columnists/2006/050106internet.html">set up a FireWire network</a> between the Windows computer and my MacBook, connected the HDD to the MacBook through USB, shared the folder in question on the network and mounted it in OS X.

Then I tried to drag-and-drop files from the mounted folder to the HDD. This turned the Finder very sluggish, when it did not stall completely. When I finally got the transfer started, the estimated time until completion was something like 27 days for my 40 MBs of test data.

<h4>FTP to the rescue</h4>

I activated the OS X FTP server (in the Sharing prefpane), connected from a Windows FTP client (I like <a href="http://filezilla.sourceforge.net/">FileZilla</a>) using the Mac's IP address and my OS X account name and password, and proceeded to transfer the files to <code>/Volumes/Axolotl</code> &ndash; the name of the HDD.

One gotcha I encountered was that Windows and OS X aren't quite agreed on what constitutes an acceptable filename, so FileZilla failed with some files, and I had to rename them in batch and transfer anew.

Using <a href="http://www.albert.nu/programs/renamer/main.htm">Renamer</a>, I replaced occurrences of <code>:åäöÅÄÖ</code> and various other umlauted or accented characters with something more acceptable (e.g. <code>--</code>, <code>aa</code>, &hellip;). Not that OS X minds diacritics, but FileZilla had problems transferring them &ndash; perhaps something to do with encodings. For some directories with too many weird characters to replace even in batch (e.g. early Björk albums), I created RAR archives and transferred those.

At one point, FileZilla crashed, and the error log made mention of Norton Antivirus, so I uninstalled the latter &ndash; an application that does not offer a "Quit" option deserves no better.

Aside from those issues, FTP transfer seems like the way to go. It's reasonably fast, though not insanely so. I average something like 4 MB/s. Speeds would perhaps be higher if the computers networked through Ethernet and if the HDD <a href="http://en.wikipedia.org/wiki/Subjunctive_mood#Form">were</a> connected through FireWire (as opposed to USB), but I didn't have the cables for it.
