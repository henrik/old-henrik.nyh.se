--- 
wordpress_id: 49
title: Renaming Party Shuffle in iTunes
tags: 
- OS X
---
I love that OS X is so very scriptable and customizable. For example, if you don't like the appearance of some application, resources like its text strings and images are usually right inside the application package (simply a folder with special treatment) to be edited like any other text or image.

Reshacking was never less impressive.

I'm still trying to get used to the metadataness of the iLife suit. I miss Winamp, but I'm trying to learn how to do the things i want in iTunes. It turned out that the iTunes Party Shuffle function is somewhat like Winamp's queuing system. However, the name makes me gag. So I renamed it.

<!--more-->

This is simply a matter of replacing occurrences of "Party Shuffle" with something decent (I went with "Mixlist"), in the file <code>/Applications/iTunes.app/Contents/ Resources/English.lproj/Localizable.strings</code>. Then reopen iTunes.

This assumes you're using the English locale for iTunes/OS X.

Here's the <code>diff</code> (<a href="http://henrik.nyh.se/uploads/partyshufflebegone.diff">download</a>):

{% highlight diff %}632,633c632,633
< "163.059" = "The playlist “^1” does not contain any songs playable by Party Shuffle. Are you sure you want to choose this playlist?";
< "163.060" = "Party Shuffle automatically chooses upcoming songs from your Music Library or Playlists. You may add to, delete or reorder the upcoming songs at any time.";
---
> "163.059" = "The playlist “^1” does not contain any songs playable by Mixlist. Are you sure you want to choose this playlist?";
> "163.060" = "Mixlist automatically chooses upcoming songs from your Music Library or Playlists. You may add to, delete or reorder the upcoming songs at any time.";
2229c2229
< "9000.026" = "Party Shuffle";
---
> "9000.026" = "Mixlist";
2972,2973c2972,2973
< "kTrackContextualMenuItem10" = "Play Next in Party Shuffle";
< "kTrackContextualMenuItem11" = "Add to Party Shuffle";
---
> "kTrackContextualMenuItem10" = "Play Next in Mixlist";
> "kTrackContextualMenuItem11" = "Add to Mixlist";{% endhighlight %}
Apply it with e.g.

{% highlight text %}patch /Applications/iTunes.app/Contents/ Resources/English.lproj/Localizable.strings < partyshufflebegone.diff{% endhighlight %}
