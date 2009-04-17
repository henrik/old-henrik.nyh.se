--- 
wordpress_id: 79
title: Colors different when saving images in Photoshop CS2 on MacBook
tags: 
- OS X
---
I use Adobe Photoshop CS2 (sorry, <a href="http://www.adobe.com/misc/trade.html#photoshop">Adobe&reg; Photoshop&reg; software</a>) for most of my image editing needs.

I don't know much about color profiles and calibration. For my purposes, it's enough that what I save looks like what I was editing, on my screen, and reasonably similar on other screens.

I had this out of the box when I used Photoshop under Windows, but after switching to OS X on a MacBook, it no longer "just worked" after installation. The colors when editing were more saturated than in the "Save for web" dialog, or indeed than in the saved image as displayed in my browser.

I finally got this solved yesterday, though color profilers and calibrators may cry.

<!--more-->

<h5>Before</h5>

<img src="http://henrik.nyh.se/uploads/pscolor-before.png" alt="[Screenshot]" class="bordered center" />

Left to right: image on Google Images in Firefox, image being edited, "Save to web" dialog.

It's quite apparent that the colors of the image being edited do not match the original image or the exported image.

<h5>After</h5>

<img src="http://henrik.nyh.se/uploads/pscolor-after.png" alt="[Screenshot]" class="bordered center" />

Left to right: image on Google Images in Firefox, image being edited, "Save to web" dialog.

Colors now match.

<h4>The solution</h4>

Asking about this issue on IRC, <code>View &gt; Proof Setup&hellip;</code> was mentioned. Setting this to "Monitor RGB" will display the image as it'll look when exported. However, this is not a very persistent setting. Whenever you re-open the image, or another image, you'll have to make the setting again, or <code>View &gt; Proof Colors</code>.

Having found this partial solution, I was better equipped to google it. <a href="http://sidesh0w.com/weblog/2006/09/07/surviving_color_management_in_photoshop_cs2/">Surviving color management in Photoshop CS2</a> helped me solve it more permanently.

In <code>Edit &gt; Color Settings&hellip;</code>, i changed the value for "RGB" under "Working Spaces" to "Monitor RGB - Color LCD". The value for "LCD" under "Color Management Policies" was automatically set to "Off".

<img src="http://henrik.nyh.se/uploads/pscolor-settings.png" alt="[Screenshot]" class="bordered center" />

And that seems to be it. When opening an image with another color profile, I am prompted whether I want to discard that color profile. If I do, or convert to the current color space, things look just the way they will when exporting the image.

<img src="http://henrik.nyh.se/uploads/pscolor-dialog.png" alt="[Screenshot]" class="bordered center" />

Under "Color Management Policies", there are checkboxes to get rid of the prompts, discarding the embedded profile silently.

Since it's probably relevant, I should perhaps mention that my screen display profile (in the "Color" tab of the "Displays" prefpane) is set to "Color LCD".

Again, I don't know much about color profiles and such. If there is a better way to solve my problem, please let me know. 

<div class="updated">
  <h5>Update 2006-12-18</h5>

  <p>In the Photoshop CS3 beta, you also need to toggle off "Convert to sRGB" in the "Save for Web &amp; Devices" dialog.</p>

  <p class="center"><img src="http://henrik.nyh.se/uploads/ps3-savergb.png" alt="[Dialog screenshot]" class="bordered" /></p>
</div>

<div class="updated">
  <h5>Update 2008-05-27</h5>
<p>I set up a new computer and read through this post again, as well as all the comments.</p>

<p>So the solution in the post suggests discarding any color profiles. This means the picture in Photoshop proper will look as desaturated as the picture in the "Save for Web" dialog.</p>

<p>A solution that seems better is to <em>convert</em> to the current color profile: that way, both pictures will keep the vibrant colors, rather than both be desaturated:</p>

<p class="center"><img src="http://henrik.nyh.se/uploads/photoshop-colors-revisited.png" alt="[Dialog screenshot]" class="bordered" /></p>

<p>I was unable to change the color management policy (to "convert") until I clicked "More Options" and then changed the RGB working space to "Color LCD" (rather than "Monitor RGB – Color LCD"). This is on a MacBook Air; on an iMac, I set it to "iMac" (rather than "Monitor RGB – iMac").</p>
</div>
