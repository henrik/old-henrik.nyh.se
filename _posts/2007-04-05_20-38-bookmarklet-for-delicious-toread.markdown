--- 
wordpress_id: 126
title: Bookmarklet to post page to del.icio.us as "toread"
tags: 
- JavaScript
- Firefox
- Bookmarklets
---
A common <a href="http://del.icio.us">del.icio.us</a> usage pattern is to tag the current page with "todo" or "toread", for something interesting you don't want to process just now.

I found a bookmarklet, "<a href="http://www.thunderguy.com/semicolon/2005/04/25/one-click-to-read-list/">one del.icio.us click</a>" for this. It sort of works: you end up on the post screen with the "toread" tag pre-filled, but you have to submit the form yourself. You also see an ugly error message.

I want less interaction. I wrote a bookmarklet that uses the <a href="http://del.icio.us/help/api">del.icio.us API</a> in an iframe to actually post the current page. You get an alert that tells you it was tagged; remove it if you want no feedback at all.

<!--more-->

The name is set to the page title and the description is set to the selected text between quotes, if there is a selection.

I've only tested this in Firefox. Probably needs minor adjustments for other browsers.

Bookmark this: <a href="javascript:var user = &quot;username&quot;, pw = &quot;password&quot;, tag = &quot;toread&quot;, shared = &quot;yes&quot;, replace = &quot;yes&quot;; with(document) { i = body.appendChild(createElement(&quot;iframe&quot;)); }; var notes = getSelection().toString().substring(0,253); if (notes) notes = &apos;&quot;&apos;+notes+&apos;&quot;&apos;; i.style.display = &apos;none&apos;; i.src = &apos;https://&apos;+user+&apos;:&apos;+pw+&apos;@api.del.icio.us/v1/posts/add?&amp;url=&apos;+encodeURIComponent(location.href)+&apos;&amp;description=&apos;+encodeURIComponent(document.title)+&apos;&amp;extended=&apos;+encodeURIComponent(notes)+&apos;&amp;tags=&apos;+tag+&apos;&amp;shared=&apos;+shared+&apos;&amp;replace=&apos;+replace; alert(&apos;OK, tagged as &quot;&apos;+tag+&apos;&quot;.&apos;); i.parentNode.removeChild(i); void(0);">"toread" on del.icio.us</a>

Ironically, it seems you must make it a regular bookmark for it to work properly; del.icio.us manhandles bookmarklets. So if you're using <a href="https://addons.mozilla.org/en-US/firefox/addon/3615">del.icio.us Bookmarks</a>, hit <code>del.icio.us &gt; Show Bookmarks Menu</code>, add it there, then <code>Hide Bookmarks Menu</code>.

Edit the bookmarklet to configure your del.icio.us username, password, the tag you want to use, if the bookmark should be shared (public) and whether old bookmarks should be replaced.

The default setting is to replace bookmarks, which means that any old tags, description etc for the same URL are overwritten. You can toggle this easily in the bookmarklet code, but if the URL is already bookmarked, the "toread" tag will never be added.

Another caveat is that it doesn't check the response code; the alert will always tell you "OK", even if there were errors (there shouldn't be, though).

I might write a Greasemonkey script that enables cross-domain <a href="http://en.wikipedia.org/wiki/XMLHttpRequest">XHR</a> for a bookmarklet like this one, so errors can be properly handled and the "toread" tag be merged rather than replacing or discarding.

This is the bookmarklet formatted for readability:

{% highlight javascript %}
var user = "username", pw = "password", tag = "toread", shared = "yes", replace = "yes";
with(document) {
  i = body.appendChild(createElement("iframe"));
};
var notes = getSelection().toString().substring(0,253);
if (notes) notes = '"'+notes+'"'; 
i.style.display = 'none';
i.src = 'https://'+user+':'+pw+'@api.del.icio.us/v1/posts/add?&url='+encodeURIComponent(location.href)+'&description='+encodeURIComponent(document.title)+'&extended='+encodeURIComponent(notes)+'&tags='+tag+'&shared='+shared+'&replace='+replace;

alert('OK, tagged as  “'+tag+'”.');

i.parentNode.removeChild(i);

void(0);
{% endhighlight %}
