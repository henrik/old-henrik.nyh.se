--- 
wordpress_id: 62
title: Del.icio.us bookmarklet that opens in new tab (or window)
tags: 
- JavaScript
- Bookmarklets
---
I assume this has been done many times before, but a quick google didn't turn it up, so I'll blog it.

This is a very slight modification of the "official" <a href="http://del.icio.us">del.icio.us</a> bookmarklet, that opens the submission page in a new tab (or a new window, depending on your browser settings): <a href="javascript:void(window.open(&apos;http://del.icio.us/post?v=4;url=&apos;+encodeURIComponent(location.href)+&apos;;title=&apos;+encodeURIComponent(document.title)))">Add to del.icio.us</a>

<!--more-->

I want it in a new tab because I often decide to bookmark things when in the middle of reading them, and so having the page replaced with the submission page is annoying.   

The code is simply:

{% highlight javascript %}
void(window.open('http://del.icio.us/post?v=4;url='+encodeURIComponent(location.href)+';title='+encodeURIComponent(document.title)))
{% endhighlight %}
