--- 
wordpress_id: 89
title: "Reversing the Photo Booth twirl effect with Photo Rebooth (or: The two-way fun house mirror)"
tags: 
- OS X
- Cocoa
- Quartz Composer
---
The application <a href="http://en.wikipedia.org/wiki/Photo_Booth">Photo Booth</a> comes pre-installed on recent Macs and allows you to take stills with the built-in iSight web cam. You can add silly distortion effects, for hours of fun.

The other day, I realized it would be cool if there was some way to provide such a distorted image as input and get an undistorted image as output &ndash; people do some weird posing in front of fun house mirrors.

<!--more-->

Having toyed a little with Quartz Composer before, and knowing the Photo Booth effects are implemented with it, I opened up <code>/Applications/Photo Booth.app/Contents/Resources/Video.qtz</code> and poked around. I found that the twirl effect could easily be reversed by running the image through a counter-twirl.

Alas, I was not able to reverse any other effect very successfully. Possibly the twirl is the only (almost) lossless and easily reversible effect. Please let me know if you manage to reverse any of the others.

<p class="center"><img src="http://henrik.nyh.se/uploads/Photo%20Rebooth.png" alt="" /></p>

Since I have been wanting to try Cocoa programming for some time, I wrapped my untwirler composition in an application &ndash; Photo Rebooth (<a href="http://henrik.nyh.se/uploads/Photo%20Rebooth.zip">download</a>, <a href="http://henrik.nyh.se/uploads/Photo%20Rebooth%20source.zip">source</a>).

<p class="center"><img src="http://henrik.nyh.se/uploads/photo_rebooth.jpg" alt="" /></p>

Drag a twirled JPG to the application in the Finder or in the dock, or to the image display area, or open it through the menu or the prominent button. The untwirled image will be displayed. There is currently no way to export the untwirled image (other than by screenshot).

For untwirl fodder, some of the images from <a href="http://flickr.com/photos/shawn_grimes/sets/72157594250621397/">this Flickr set</a> are fun.

<div class="updated">
  <h5>Update 2007-01-01</h5>

  <p>Version 1.1:</p>

  <ul>
    <li>Input images no longer have to be 640x480 pixels.</li>
    <li>Input images may be drag-and-dropped onto the image display area.</li>
  </ul>
</div>
