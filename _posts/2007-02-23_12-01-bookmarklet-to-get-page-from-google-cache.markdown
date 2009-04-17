--- 
wordpress_id: 104
title: Bookmarklet to get page from Google cache
tags: 
- JavaScript
- Bookmarklets
---
Every now and then, you follow a link from a search result listing and find it is no more. Rather than go back and click the "Cached" link (on Google result listings), use this bookmarklet: <a href="javascript:location.href=&quot;http://www.google.com/search?q=cache:&quot;+encodeURIComponent(location.href)">Get from Google cache</a>.

I've assigned it the bookmark keyword "cached".

After writing the bookmarklet and before writing this post, I googled it, and found (not surprisingly) that it's been done before. However, the other solutions (e.g. <a href="http://rentzsch.com/notes/googleCacheHacking">Google Cache Hacking</a>, <a href="http://ostermiller.org/bookmarklets/cache.html">Cache Bookmarklets</a>) seem unnecessarily complicated. Perhaps stripping the protocol and messing with hashes was required, once.
