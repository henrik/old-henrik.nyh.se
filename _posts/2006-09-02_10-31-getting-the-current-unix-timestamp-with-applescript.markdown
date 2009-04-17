--- 
wordpress_id: 45
title: Getting the current UNIX timestamp with AppleScript
tags: 
- OS X
- AppleScript
---
Since I couldn't find the answer on Google when I needed it:

{% highlight applescript %}(do shell script "date +%s") as integer{% endhighlight %}
Or, verbosely (and possibly not portable across date formats):

{% highlight applescript %}current date - time to GMT - date "1970-01-01"{% endhighlight %}
