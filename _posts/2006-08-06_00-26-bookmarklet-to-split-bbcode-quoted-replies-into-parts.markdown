--- 
wordpress_id: 20
title: Bookmarklet to split BBCode quoted replies into parts
tags: 
- JavaScript
- Firefox
- Bookmarklets
---
Every once in a while, I want to reply to a forum post part by part. For the common BBCode forums, doing this manually is a tedious matter of repeatedly typing and/or copy-and-pasting <code>[QUOTE]</code> and <code>[/QUOTE]</code> tags. An obvious candidate for automation.


<!--more-->

I figured the best vehicle for this piece of magic would be a <a href="http://en.wikipedia.org/wiki/Bookmarklet">bookmarklet</a>.

I can initiate a quoted reply, put "-snip-" or "-s-" wherever I want a word in, and then run the bookmarklet. It will insert the appropriate start and end tags, including any attributes to the start tag (e.g. <code>[QUOTE="Squid"]</code> or <code>[QUOTE from="Squid"]</code>), newlines to make room for my reply (after first removing superfluous whitespace around the snip point), and then put the caret in the first such slot.

So {% highlight text %}[QUOTE="Squid"]
Blubb blubb!
-s-
Boink boink?
-s-
Hrull...
[/QUOTE]{% endhighlight %} becomes {% highlight text %}[QUOTE="Squid"]
Blubb blubb!
[/QUOTE]

[QUOTE="Squid"]
Boink boink?
[/QUOTE]

[QUOTE="Squid"]
Hrull...
[/QUOTE]{% endhighlight %}with the caret automagically placed after the first quotation.

I have the Firefox bookmark keyword "quote" tied to the bookmarklet, meaning I can type that in the address bar and hit &#x21A9; to run it.

Right-click this link and bookmark it: <a href='javascript:(function(){ ta = document.getElementsByTagName("textarea")[0]; with (ta) { q = value.match(/\[QUOTE(.*?)\]/i)[0]; value = value.replace(/\s*-s(nip)?-\s*/g, "[/QUOTE]\n\n"+q); offset = value.indexOf("[/QUOTE]")+9; focus(); setSelectionRange(offset,offset); } })();'>Break up BBCode quote</a>.

Formatted for readability:

{% highlight javascript %}(function(){
  ta = document.getElementsByTagName("textarea")[0];
  with (ta) {
    q = value.match(/\[QUOTE(.*?)\]/i)[0];
    value = value.replace(/-s(nip)?-/g, "[/QUOTE]\n\n"+q);
    offset = value.indexOf("[/QUOTE]")+9;
    focus();
    setSelectionRange(offset,offset);
  }
})();{% endhighlight %}

This code makes the (rather safe, I think) assumption that you only care about the first textarea on the page. Modify to taste.

<code>setSelectionRange()</code> &ndash; to move the caret &ndash; is Gecko (Firefox) specific, so some modifications are necessary if you want to use this with some other browser.
