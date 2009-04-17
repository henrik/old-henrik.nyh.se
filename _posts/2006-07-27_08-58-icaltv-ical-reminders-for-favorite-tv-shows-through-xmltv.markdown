--- 
wordpress_id: 12
title: "iCalTV: iCal reminders for favorite TV shows through XMLTV"
tags: 
- Ruby
- OS X
---
The last couple of days, I've been working on a set of Ruby scripts to download <a href="http://www.xmltv.org/">XMLTV format</a> (or some derivative) schedules from <a href="http://tv.swedb.se/">tv.swedb.se</a>, process them against rulesets, and export the intersection as reminders in an iCalendar (.ics) file that you can subscribe to with iCal.

<p style="text-align:center"><img src="http://henrik.nyh.se/uploads/icaltv.png" alt="iCalTV reminder" style="border:1px solid #CCC" /></p>

<!--more-->

An archive of the scripts including documentation/installation instructions is available as <a href="http://henrik.nyh.se/filer/iCalTV.zip">iCalTV.zip</a>.

The documentation/installation instructions, in Swedish only for now, are available by themselves as <a href="http://henrik.nyh.se/filer/iCalTV.html">iCalTV.html</a>.

Though that documentation is in Swedish only, the code and its comments are in English, so if anyone wants to adapt this for another country, it shouldn't be too hard to follow. I will add English documentation if it turns out anyone wants it. 

Until then, this is how iCalTV works in brief:

Install the set of Ruby scripts and support files into e.g. <code>~/Library/iCalTV</code>. Schedule <code>grabber.rb</code> to run every couple of days. That script retrieves new schedules and also runs <code>cleaner.rb</code>, which removes expired schedules, and <code>icaltv.rb</code>, which is the rule/calendar engine.

Data is stored in <code>~/Library/Xmltv</code>, intended to be the shared space for everything that works with this data. That could include TV listing widgets, tools to search in schedules or whatever.

<code>~/Library/Xmltv/favorites</code> contains <code>channels.xml</code>, listing the channels you're interested in, and <code>rulesets.xml</code>, containing, well, rulesets. A ruleset has an optional name, optional settings for how long before a show to notify, optional settings for the notification sound, and then a set of rules and the setting whether all rules need match, or just any one.

A ruleset might look like this:

{% highlight xml %}<ruleset>
	<rule attribute="name" condition="begins-with">CSI</rule>
	<rule attribute="channel" condition="is">Kanal 5</rule>
	<rule attribute="plays" condition="within">08:00-02:30</rule>
</ruleset>{% endhighlight %}

In addition to the scheduling, <code>grabber.rb</code> needs to be run manually whenever you add new channels (unless you want to wait for the scheduled update), and <code>icaltv.rb</code> needs to be run manually whenever the rulesets are changed. I plan for some interface to the channels and rulesets that would handle this itself.

When <code>icaltv.rb</code> is run, it compares the schedules downloaded for your channels to the rulesets, and exports an iCalendar file of your favorite shows to <code>~/Sites/TV.ics</code>.

All that remains is to toggle on Personal Web Sharing, and then subscribe to the file through your web server, in iCal, keeping in mind not to leave "Remove alarms" checked.

<p class="updated"><a href="http://henrik.nyh.se/2006/08/icaltv-04-released/">iCalTV 0.4 has been released &ndash; the above post is outdated.</a></p>
