--- 
wordpress_id: 57
title: Removing formatting from the clipboard
tags: 
- OS X
---
I'm sure there are other and better methods, but until I find the time to research that: this a nice and simple way of removing formatting (e.g. colors, boldness) from text in the clipboard. In the Terminal:

{% highlight text %}
pbpaste | pbcopy
{% endhighlight %}Nothing more to it.
