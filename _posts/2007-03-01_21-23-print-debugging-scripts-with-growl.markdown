--- 
wordpress_id: 109
title: Print-debugging scripts with Growl
tags: 
- OS X
---
Sometimes I find myself writing scripts in contexts where you can't easily debug just by printing to STDOUT.

Rather than messing with a log file that you then have to look for/open (I often <code>touch /tmp/wood</code>), this (suggested by <a href="http://ecmanaut.blogspot.com/">Johan</a>) works if you've got <a href="http://growl.info/">Growl</a> with growlnotify. Drop into a shell and:

{% highlight bash %}
growlnotify -m 'Still executing!'
{% endhighlight %}
