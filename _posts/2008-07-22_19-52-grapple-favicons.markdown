--- 
wordpress_id: 236
title: Tab favicons with GrApple Firefox themes
tags: 
- OS X
- Firefox
- CSS
---
I use Firefox 3 with the <a href="http://takebacktheweb.org/">GrApple Yummy (blue)</a> theme.

It has a clean OS X look, but I'm happy to trade in some of that cleanness for favicons on the tabs.

<img src="http://henrik.nyh.se/uploads/grapple-favicons.png" alt="[Screenshot]" class="bordered" />

<!--more-->

I achieved that by putting this in my <a href="http://support.mozilla.com/en-US/kb/Editing+configuration+files#userChrome_css">userChrome.css</a> file:

{% highlight css %}
.tab-icon-image {
  display: block !important;
  position: relative;
  left: -8px;
}
{% endhighlight %}

This does not look good with left-side close-tab buttons. I have close-tab buttons disabled altogether (instead double-clicking a tab to close it) using the <a href="http://tmp.garyr.net/forum/viewtopic.php?t=9178">Tab Mix Plus extension</a>.

I haven't tried it myself, but there is also a <a href="http://www.isriya.com/node/2032/takuapa-themes-for-firefox-3">"Takuapa"</a> fork of GrApple Yummy (blue) that adds the favicon among some other changes (including right-side close buttons).

If you want favicons in the Bookmarks toolbar or the search field, see the <a href="http://takebacktheweb.org/CaE.html">GrApple customization page</a>.
