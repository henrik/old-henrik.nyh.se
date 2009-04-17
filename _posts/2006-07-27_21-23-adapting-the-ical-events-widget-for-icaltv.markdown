--- 
wordpress_id: 16
title: Adapting the iCal Events widget for iCalTV
tags: 
- JavaScript
- OS X
- Dashboard widgets
---
<img src="http://henrik.nyh.se/uploads/icalevents.png" alt="iCal Events widget" class="right" style="float:right;padding:0 0 0.1em 0.5em;" />

I realized it'd be nice to have a widget that displays the upcoming favorite TV shows entered into iCal by <a href="http://henrik.nyh.se/2006/07/icaltv-ical-reminders-for-favorite-tv-shows-through-xmltv/">iCalTV</a>.

The easiest solution was to use the <a href="http://www.benkazez.com/icalevents.php">iCal Events widget</a>, setting it to only display events from the "TV" calendar.

I made two small adjustments to the widget to fit iCalTV better.

<!--more-->

For one, I made it not display newlines and anything trailing them, in event titles. Having the description as part of the title looks great in reminders, but not so good in a listing such as this one.

Also, if an event (a show, in this case) spans two days, it would appear once under the heading for each day, without the starting time on the second day. I changed it so it only appears on the day the show starts.

The changes follow as a unidiff (<code>man diff</code>, <code>man patch</code>):

{% highlight text %}-<!---->-<!---->- iCalEvents.js.old	2006-07-27 20:27:58.000000000 +0200
+++ iCalEvents.js	2006-07-27 20:39:07.000000000 +0200
@@ -262,7 +262,7 @@
 					     currentDayEnd_getTime > startDate_getTime))
 					displayTime = true;
 				else
-					displayTime = false;
+					continue;
 
 				if (currentDayStart_getTime >= endDate_getTime) {
 					// TODO: optimization here using firstEventConsidered.
@@ -311,7 +311,7 @@
 				
 					paperHTML += ">";
 					if (summary)
-						paperHTML += summary;
+						paperHTML += summary.replace(/\n.+/, "");
 					paperHTML += "</td></tr>";
 					
 				} else {
{% endhighlight %}

<a href="http://henrik.nyh.se/uploads/icalevents.diff">Download</a>.

Apply it with e.g.

{% highlight text %}patch ~/Library/Widgets/iCal\ Events.wdgt/iCalEvents.js < icalevents.diff{% endhighlight %}
