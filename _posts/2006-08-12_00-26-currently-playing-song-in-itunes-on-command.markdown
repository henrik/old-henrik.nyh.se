--- 
wordpress_id: 30
title: Currently playing song in iTunes on command
tags: 
- OS X
- AppleScript
---
<img src="http://henrik.nyh.se/uploads/currentlyplaying.png" alt="[Screenshot]" style="float:right;padding:0 0 0.2em 0.8em;" />

Though <a href="http://www.macupdate.com/info.php/id/11273">iScrobbler</a> provides me with <a href="http://www.growl.info">Growl</a> notifications of track details whenever iTunes starts playing a song, I wanted a way to get those details at any time, on my command.

<!--more-->

<p class="updated"><a href="http://henrik.nyh.se/2006/08/re-currently-playing-song-in-itunes-on-command/">There is an updated version of this script.</a></p>

I don't want to have to switch focus to iTunes just to find out what the current song is, if I forgot to take note of the details as the song started playing.

I ended up writing an AppleScript that collects song details from iTunes, including any album art, and then passes those details to a Growl notification.

I choose to trigger the script with Quicksilver, similar to in <a href="http://henrik.nyh.se/2006/07/batch-open-urls-from-clipboard/">a previous post</a>.

The script (<a href="http://henrik.nyh.se/uploads/Currently%20playing.scpt">download</a>):

{% highlight applescript %}-- The Album art code is from http://www.macosxhints.com/article.php?story=20060406080910401

set theTitle to "Currently playing"

set tempArt to "/tmp/growlart.tiff"
set tempArtPath to POSIX file tempArt
set tempArtFile to tempArtPath as file specification

set doMusic to false
set doArt to false

tell application "iTunes"
  if player state is playing then
    set theArtist to artist of current track
    set theSong to name of current track
    set theAlbum to album of current track
    if (count of artwork of current track) > 0 then -- artwork is present
      
      do shell script "rm -rf " & tempArt
      
      set artworkData to data of artwork 1 of current track
      
      set fileRef to (open for access tempArtPath with write permission)
      try
        set eof fileRef to 512
        write artworkData to fileRef starting at 513
        close access fileRef
      on error errorMsg
        try
          close access fileRef
        end try
        error errorMsg
      end try
      
      -- Convert to tiff
      
      tell application "Finder" to set creator type of tempArtPath to "????"

      tell application "Image Events"
        set theImage to open tempArtFile
        save theImage as TIFF in tempArtFile with replacing
      end tell
      
      set doArt to true
      
    end if
      
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
      set theDesc to "Track: " & theSong & "\nAlbum: " & theAlbum & "\nArtist: " & theArtist
      if doArt
        notify with  name notification  title theTitle  description theDesc  application name appName  image from location tempArt
      else
        notify with  name notification  title theTitle  description theDesc  application name appName
      end if
    else
      notify with  name notification  title theTitle  description "Nothing."  application name appName
    end if
  end tell
end if{% endhighlight %}If anyone knows how to avoid the duplication in the end of the script, please let me know. I'm new to AppleScript.
