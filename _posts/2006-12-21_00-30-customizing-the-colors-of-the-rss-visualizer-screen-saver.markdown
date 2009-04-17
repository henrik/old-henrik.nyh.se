--- 
wordpress_id: 85
title: Customizing the colors of the RSS Visualizer screen saver
tags: 
- OS X
- Quartz Composer
---
I wanted to change the colors of the very pretty OS X RSS Visualizer screen saver.

I found a broken download link to a modified version <a href="http://www.macosxhints.com/article.php?story=20050425173919124">over at macosxhints.com</a>. By further googling and some guesswork, I figured out how to change the colors myself.

<p class="center"><img src="http://henrik.nyh.se/uploads/black-rss-visualizer.jpg" alt="[Screenshot: Black RSS Visualizer]" class="bordered" /></p>

<a href="http://henrik.nyh.se/uploads/Black%20RSS%20Visualizer.qtz">Download</a> my modified version with a black/dark gray background, dark red headers and white body text. Read on for how to define other colors.

Put the <code>qtz</code> file in <code>~/Library/Screen Savers</code> (available only to your user) or <code>/System/Library/Screen Savers</code> (available to all users). It seems the screen saver prefpane needs to be closed and re-opened to notice changes to these directories. 

<!--more-->

To modify the screen saver, you need to have Quartz Composer installed. It should be on your Apple Developer Tools disc along with e.g. Xcode. 

Now, since I didn't want to learn all about Quartz Composer at this time, my solution is in a spirit of just-make-it-work, aiming for no more than a very shallow understanding of things. I fully expect there to be better and simpler solutions. Please let me know of them.

<h4>In Quartz Composer</h4>

Open the screen saver in Quartz Composer.

One can double-click boxes with pink headers to drill down further, decomposing them. One can select an atomic(?) box with greenish headers, open the Inspector and select Input Parameters to change those values.

To change the background color, drill down into <code>Background &gt; Macro Patch &gt; Render in Image</code> and change the Input Parameters of the two "RGB Color" boxes in the top right. Their outputs are hooked to relevant color inputs. The parameters are sliders to change the amount of red, green, blue and opacity.

<p class="center"><img src="http://henrik.nyh.se/uploads/black-rss-bgcolors.png" alt="[Screenshot: Setting background colors]" class="bordered" /></p>

You should see the colors in the Viewer window change as you alter the parameters.

Similarly, change the body color in <code>Article &gt; Billboard &gt; 3D Transformation</code>, towards the right, and the header color in <code>Article &gt; Billboard &gt; 3D Transformation &gt; Iterator</code>, towards the bottom right.

As with the original RSS Visualizer, the screen saver preferences offer any feed that is bookmarked in Safari.
