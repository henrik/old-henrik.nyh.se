--- 
wordpress_id: 254
title: Time Machine mounting issues
tags: 
- OS X
---
When Time Machine won't work, I've found it's often a matter of the drive being mounted already, by the user. Time Machine wants to mount the drive as itself (backupd). Console.app can often tell you if this is the case.

Sometimes, it's enough to eject the drive in the Finder. If that doesn't work, or you don't see it there, fire up Terminal.app and do

{% highlight bash %}
ls /Volumes
{% endhighlight %}

If it lists your drive, try

{% highlight bash %}
diskutil unmount /Volumes/Backup
{% endhighlight %}
or whatever the name is.

If you get

{% highlight text %}
Unmount blocked by dissenter with status code 0x0000c001 and message (null)
Unmount failed for /Volumes/Backup
{% endhighlight %}
then try

{% highlight bash %}
diskutil unmount force /Volumes/Backup
{% endhighlight %}

A related issue: when setting up Time Machine to use a certain drive, you'll need to have it mounted to be able to select it, but after that you may need to manually eject it, before it can be used for backing up.
