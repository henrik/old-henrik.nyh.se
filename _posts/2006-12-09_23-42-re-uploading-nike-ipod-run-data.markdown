--- 
wordpress_id: 82
title: Re-uploading Nike+ iPod run data
tags: 
- OS X
- Hardware
---
Triggered by <a href="http://www.cabel.name/2006/08/multiplayer-game-of-year.html">a very inspiring blog post</a>, I've now been using <a href="http://www.apple.com/ipod/nike/">the Nike+ iPod Sports Kit</a> for a couple of weeks.

The other day, though, when attempting to sync the data post-run, iTunes complained about not being able to validate my data. The data was not uploaded and would not re-sync on reconnecting the Nano. It happened again the day after, losing me a total of eight kilometers.

<img src="http://henrik.nyh.se/uploads/nikeerror.png" alt="[Your workout data could not be sent to nikeplus.com because the data could not be validated by the server.]" />

<a href="http://forums.nike.com/thread.jspa?threadID=807">Seems</a> this was a widespread issue.

The problem didn't occur again after today's run. Later, I followed <a href="http://discussions.apple.com/thread.jspa?messageID=2893663">these instructions for re-uploading run data</a>, though I used the terminal instead. The runs now synced fine, without causing the validation error.

<!--more-->

The name of your iPod, the identifier of your Nike+ and the filename for the run will vary from these values. Tab completion is your friend.

Connect your iPod and allow it to mount.

Go to the <code>synched</code> directory:

{% highlight text %}
cd /Volumes/YourNanoName/iPod_Control/Device/Trainer/Workouts/Empeds/2X345FOOBAR/synched
{% endhighlight %}

Move the file to the <code>latest</code> directory:

{% highlight text %}
mv 2006-12-06\ 17\;40\;02.xml ../latest/
{% endhighlight %}

Navigate out of the Nano to allow ejecting it:

{% highlight text %}
cd
{% endhighlight %}

Eject the Nano. Plug it back in. It should sync the run again.

Re-syncing a run that was already successfully synced does not seem to cause any problems &ndash; it is not duplicated, only flagged as new (but with its actual date maintained). Re-syncing older runs, after successfully having synced newer runs, didn't cause any issues, either.

It seems Apple Discussions (where I found <a href="http://discussions.apple.com/thread.jspa?messageID=2893663">the thread I based this on</a>) disallows search engine indexing, so hopefully this post will add googleability to the issue and solution.
