--- 
wordpress_id: 86
title: Eniro.se telephone number large type
tags: 
- Greasemonkey
- JavaScript
- Firefox
---
A brilliant, somewhat hidden feature in the OS X Address Book is that you can click a telephone number and select "Large Type" to enlarge the number in an <abbr title="On Screen Display">OSD</abbr>. The idea is presumably to enable you to see the number from across the room, where your phone might be.

I wrote a new userscript, <a href="http://userscripts.org/scripts/show/6897">Eniro.se telephone number large type</a>, to bring this feature to the online Swedish telephone directory <a href="http://www.eniro.se">Eniro.se</a>.

<p class="center"><img src="http://henrik.nyh.se/uploads/gm-phone_large_type.png" class="bordered" alt="[Screenshot: Eniro.se large type]" /></p>

<!--more-->

Some nice features of this script is that the number remains centered on the screen until discarded (by clicking anywhere or pressing any key), and that the font is set to the maximum size that fits within the width of the window.

Sometime in the future, I plan on adding support for the directory <a href="http://www.hitta.se">Hitta.se</a> as well. I haven't done so yet because the site splits numbers up across several <code>span</code> tags, and does some other things different enough from Eniro.se to make things annoying.

I'm also considering making a general purpose "Large Type" userscript or bookmarklet, for any text you highlight.

Incidentally, when writing this script, I found that <code>window.innerWidth</code> would in fact include the width of the scrollbar, which messed up the centering. I hope there is some better solution out there, but this seemed to do the trick:

{% highlight javascript %}
var bs = getComputedStyle(document.body, '');
var widthWithoutScrollbar = parseInt(bs.getPropertyValue("width"), 10) + parseInt(bs.getPropertyValue("margin-left"), 10) + parseInt(bs.getPropertyValue("margin-right"), 10);
{% endhighlight %}
