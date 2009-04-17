--- 
wordpress_id: 32
title: Retain metadata when exporting and reimporting iPhoto pictures, hackishly
tags: 
- Ruby
- OS X
- AppleScript
---
I'm still trying to get used to the whole metadata thing in the iLife suite. When I first had switched, I configured iPhoto not to create its own copies of the pictures I added, because I wanted to keep the original files in their file structure, and did not want duplicates.

I later realized it was probably a better idea to have iPhoto keep its own copies and remove the originals, as it didn't make a lot of sense to keep things in my own file structure when you can just export from iPhoto anyway.

However, when I changed that setting, it seems iPhoto did not fetch the original files for previously imported pictures, nor does it seem to have any option in its menus to perform such a consolidation. Since I don't want the confusion of having some pictures entirely in library and some only there in part, I decided I would export all pictures and then re-import them, with the new setting.

Testing this with one photo, it turned out this did not preserve metadata. Keywords and folder placement were lost.

Because I'd rather spend some time coding than a lot of time re-sorting thousands of pictures, I automated it.

<!--more-->

This is rather a hackish way of doing it, but it was easily coded, and works fine for me. Also, it's not bundled into a single self-contained script, as I don't expect to do this ever again. Just posting it here in the hope of saving someone else the trouble.

<h4>Export</h4>

First, export your photos into several folders, each for a folder or keyword you want to be able to restore. Folder contents may overlap, so one photo with three saveworthy keywords would go in at least three folders.

Also export the entire library to a folder.

<h4>Clear the library</h4>

Remove everything in your library within iPhoto.

<h4>Import</h4>

Import the entire library from that last folder.

<h4>Scripting</h4>

Do this for each of your keyword or iPhoto folder folders.

I started by creating a list suitable for AppleScript and saved it to a file. Using the Terminal, step inside the folder of photos in question and do

{% highlight text %}ruby -e 'puts %{"} + Dir["*.jpg"].join(%{", "}) + %{"}' > iphoto.scpt{% endhighlight %}

This presupposes files named something .jpg.

I then modified <code>iphoto.scpt</code>, building a script around that list of filenames and running it. The change will be made photo by photo. It might take a while.

For putting stuff into a folder, build this script around the file list:

{% highlight applescript %}set pics to {"one.jpg", "two.jpg"}
set theAlbumName to "My favorite numbers"

tell app "iPhoto"
  activate
  set theAlbum to (the first album whose name is theAlbumName)
  
  repeat with pic in pics    
    set thisPic to (the first photo whose image filename is the pic)
    add thisPic to theAlbum    
  end repeat
end{% endhighlight %}

For tagging stuff with a keyword, this is the way to go:

{% highlight applescript %}set pics to {"three.jpg", "five.jpg"}
set theKeyword to "Prime"

tell app "iPhoto"
  activate

  repeat with pic in pics    
    set thisPic to (the first photo whose image filename is the pic)
    select thisPic
    assign keyword string theKeyword
  end repeat
end{% endhighlight %}

These scripts assume the named folders and keywords already exist when the scripts are run.
