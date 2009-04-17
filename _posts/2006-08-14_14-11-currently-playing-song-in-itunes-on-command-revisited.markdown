--- 
wordpress_id: 36
title: Currently playing song in iTunes on command, revisited
tags: 
- OS X
- AppleScript
---
<img src="http://henrik.nyh.se/uploads/currentlyplaying2.png" alt="[Screenshot]" style="float:right;padding:0 0 0.2em 0.8em;" />

The previously blogged <a href="http://henrik.nyh.se/2006/08/currently-playing-song-in-itunes-on-command/">Currently playing song in iTunes on command</a> script has been updated.

It turned out <a href="http://hcs.harvard.edu/~jrus/">Jacob Rus</a> had made a similar script before mine, that did without saving cover art as a temporary file. I modified my code accordingly. It seems this also solved the strange problem that the script worked fine when run directly but sometimes not when run through Quicksilver.

<!--more-->

Jacob's script, along with others by him to e.g. quickly change rating or skip-and-display, are <a href="http://hcs.harvard.edu/~jrus/quicksilver/iTunes%20Controller.zip">available here</a>.

<p>The script (<a href="http://henrik.nyh.se/uploads/Currently%20playing2.scpt">download</a>):</p>

{% highlight applescript %}set theTitle to "Currently playing"
set albumArt to null
set doMusic to false

tell application "iTunes"
  if player state is playing then
    set theArtist to artist of current track
    set theSong to name of current track
    set theAlbum to album of current track
    
    try
      set albumArt to data of artwork 1 of current track
    on error
      set albumArt to null
    end try
      
    set doMusic to true
  end if
end tell

set appName to theTitle
set notification to theTitle
set myAllNotesList to {notification}

tell application "System Events"
   set isRunning to (name of processes) contains "GrowlHelperApp"
end tell

if isRunning then  
  tell application "GrowlHelperApp"
    register as application appName  all notifications myAllNotesList  default notifications myAllNotesList  icon of application "iTunes"
    
    if doMusic
      set theDesc to "Track:\t" & theSong & "\nAlbum:\t" & theAlbum & "\nArtist:\t" & theArtist
    else
      set theDesc to "Nothing."
    end

    if albumArt is not null
      notify with  name notification  title theTitle  description theDesc  application name appName  pictImage albumArt
    else
      notify with  name notification  title theTitle  description theDesc  application name appName
    end if

  end tell
end if{% endhighlight %}
