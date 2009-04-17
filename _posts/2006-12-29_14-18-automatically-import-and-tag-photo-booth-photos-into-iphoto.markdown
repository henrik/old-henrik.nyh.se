--- 
wordpress_id: 88
title: Automatically import (and tag) Photo Booth photos into iPhoto
tags: 
- OS X
- AppleScript
---
When you take <a href="http://flickr.com/photos/malesca/tags/photobooth/">pictures</a> with Apple's Photo Booth, there is a button to import them into iPhoto one at the time.

Having decided yet again to try to get used to the metadataness of OS X, this annoys me. If iPhoto is supposed to handle my images, abstracting away the file system, I want new photos to go there automatically.

I created a <a href="http://www.apple.com/applescript/folderactions/">folder action</a> that does just that. Assuming you enable Folder Actions and attach this one to the Photo Booth directory (<a href="http://www.apple.com/applescript/folderactions/01.html">instructions</a>), new photos will automatically be imported into iPhoto and tagged with "Photo Booth".

<!--more-->

The script assumes that you have created a "Photo Booth" tag in the iPhoto settings, and a smart album named "Photo Booth" that displays the photos with that tag.

Script (<a href="http://henrik.nyh.se/uploads/add%20-%20import%20into%20iPhoto%20and%20tag%20with%20%22Photo%20Booth%22.scpt">download</a>, recommended location <code>/Library/Scripts/Folder Action Scripts/</code>):

{% highlight applescript %}
on adding folder items to this_folder after receiving added_items
  tell application "iPhoto"
    import from added_items
    delay 5 -- wait for import to finish
    tell (the first album whose name is "Last roll") to select photos
    assign keyword string "Photo Booth"
    select (the first album whose name is "Photo Booth")
  end tell
end adding folder items to
{% endhighlight %}

The delay is in seconds. If the import doesn't finish before the script tags whatever is in "Last roll", increase the delay. This seems to work fine for me.

After assigning the tag, the "Photo Booth" album is selected, i.e. its contents are displayed.

Optionally, if you want to stick Photo Booth photos into a regular (non-smart) folder and not tag it, try something like this instead:

{% highlight applescript %}
on adding folder items to this_folder after receiving added_items
  tell application "iPhoto"
    import from added_items to (the first album whose name is "Photo Booth")
    select (the first album whose name is "Photo Booth")
  end tell
end adding folder items to
{% endhighlight %}

This solution is not perfect &ndash; I would ideally want the script to delete the original images, only keeping them in iPhoto, but still have them display in the Photo Booth history. This is probably possible by modifying the <code>Recents.plist</code> file, which I have not yet had time to look into.

Throw in a <code>quit</code> on its own line before <code>end tell</code> to quit iPhoto when done. I prefer to leave it open since I will usually take more photos, and also so that I can add further tags.
