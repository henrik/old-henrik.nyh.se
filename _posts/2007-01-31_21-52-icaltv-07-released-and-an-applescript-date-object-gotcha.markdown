--- 
wordpress_id: 101
title: iCalTV 0.7 released, and an AppleScript date object gotcha
tags: 
- OS X
- AppleScript
---
Squashed a bug in iCalTV and bumped the version number to 0.7.

<a href="http://henrik.nyh.se/uploads/iCalTV0.7.zip">Download version 0.7 (276 KB).</a>

The bug was an interesting example of the fact that computers do what you say, not what you mean.

<!--more-->

<h4>Creating date objects with AppleScript</h4>

iCalTV inserts events into iCal by generating and running an AppleScript. In the script, each event is constructed and then inserted into the proper calendar. Each event has a start date and an end date, where "date" includes time of day.

As far as I know, there is no pleasant way of creating date objects (or of doing anything else :>) in AppleScript. AppleScript would prefer for you to create them from a localized string &ndash; Script Editor will replace

{% highlight applescript %}
set myDate to date "2007-01-31 22:00"
{% endhighlight %}

with

{% highlight applescript %}
set myDate to date "onsdag 31 januari 2007 22:00:0"
{% endhighlight %}

for me, with a Swedish-ish date locale, when I run a script.

In fact, you must (according to <a href="http://www.amazon.com/AppleScript-Definitive-Guide-Matt-Neuburg/dp/0596102119">AppleScript: The Definitive Guide</a>) specify dates in one of the formats defined in your International preferences. So the way you create date objects isn't necessarily portable to another account. Joy.

A way around this is to modify a date property by property. That is what iCalTV does. It creates a date object by the time of day alone, which results in an object representing that time today. (Probably using 24-hour time isn't portable either, but that's where I draw the line.) Then I modify the year, month and day property by property.

This is how the iCalTV-generated AppleScript would create a date object for tomorrow, February 1 2007, at 21:00:

{% highlight applescript %}
set myDate to date "21:00"
set year of myDate to 2007
set month of myDate to 2
set day of myDate to 1
{% endhighlight %}

<h4>Dates gone bad</h4>

I noticed that the <a href="http://henrik.nyh.se/2006/07/adapting-the-ical-events-widget-for-icaltv/">iCal Events Widget</a> wasn't displaying any reminders for the next couple of days, even though I knew there should be a few. Tracing through my code, I eventually found that the reminders <em>were</em> being set, but they were off by one. Month. My February 1 reminders were scheduled for March 1.

I played around in Script Editor. Setting the date properties like that would indeed create a March date. I ruled out zero-indexing (month <code>0</code> corresponding to January, <code>1</code> to February and so on) by testing. Setting the month to <code>1</code> would create a January date.

<h4>The solution</h4>

Eventually the cause of the bug became clear, and it was this. The date object was constructed as 21:00 today, January 31. The year was set to <code>2007</code>, which in this case did not in fact change anything. The month was set to <code>2</code>. This is where my intuition and programming logic diverged. Since there is no 31st of February, the modified date object was March 3. Changing the day of the month to <code>1</code> then turns it into March 1.

The simple solution was to set the day property before setting the month property. So this works as expected:

{% highlight applescript %}
set myDate to date "21:00"
set year of myDate to 2007
set day of myDate to 1
set month of myDate to 2
{% endhighlight %}

I can't think of any similar calendrical quirks that would require me to specify the year last, especially since leap days are separated from turns of the year by a couple of months on either side. Schedules aren't available to iCalTV more than about two weeks ahead of time, to my knowledge, and it defaults to a far smaller lookahead. If there is such an event, though, it'd be an interesting acquaintance, so I'll leave the order of properties like this and see what happens.
