--- 
wordpress_id: 55
title: Bookmarklet to blog all images from a Flickr page
tags: 
- JavaScript
- Firefox
- Bookmarklets
- LiveJournal
---
Flickr has some blogging integration, but it only seems to support blogging one photo at the time.

I made a bookmarklet that generates the HTML image tags for the full size version of every Flickr gallery image or thumbnail on the current page. It's wrapped in a LiveJournal "lj-cut" tag, but it should be obvious how to get rid of that if you're blogging elsewhere.

The bookmarklet doesn't actually post the images to a blog, but it does rid you of repeated cut-and-pasting.

<!--more-->

I have the Firefox bookmark keyword "ljcut" tied to the bookmarklet, meaning I can type that in the address bar and hit <code>&#x21A9;</code> to run it.

The contents of the Flickr page are replaced by the code. Just copy it into your blog.

Right-click this link and bookmark it: <a href="javascript: imgs = document.images; keep = []; for (i=0; i&lt;imgs.length; i++) if ((m = imgs[i].src.match(/(http:\/\/.*?static\.flickr\.com\/\d+\/\d+_[a-z\d]+)(_[a-z])?\.jpg/)) &amp;&amp; !imgs[i].className.match(/\b(setThumb|nextprev_thumb)\b/) &amp;&amp; imgs[i].id!=&quot;primary_photo_img&quot;) keep.push(&apos;&lt;img src=&quot;&apos;+m[1]+&apos;_o.jpg&quot; alt=&quot;[&apos;+ (imgs[i].alt||&quot;Photo&quot;) +&apos;]&quot; /&gt;&apos;); document.body.innerHTML = &quot;&lt;textarea style=&apos;width:100%;height:100%&apos;&gt;&lt;lj-cut text=\&quot;The photos.\&quot;&gt;\n\n&quot;+keep.join(&quot;\n\n&quot;)+&quot;\n\n&lt;/lj-cut&gt;&lt;/textarea&gt;&quot;;">LJ-cut from Flickr</a>.

Formatted for readability:

{% highlight javascript %}
imgs = document.images;
keep = [];
for (i=0; i<imgs.length; i++)
  if ((m = imgs[i].src.match(/(http:\/\/.*?static\.flickr\.com\/\d+\/\d+_[a-z\d]+)(_[a-z])?\.jpg/)) && !imgs[i].className.match(/\b(setThumb|nextprev_thumb)\b/) && imgs[i].id!="primary_photo_img")
    keep.push('<img src="'+m[1]+'_o.jpg" alt="['+ (imgs[i].alt||"Photo") +']" />');
document.body.innerHTML = "<textarea style='width:100%;height:100%'><lj-cut text=\"The photos.\">\n\n" + keep.join("\n\n") + "\n\n</lj-cut></textarea>";
{% endhighlight %}

This will obviously not work if full size images are not available.

<div class="updated">
<h5>Update 2007-03-10</h5>
<p>The above no longer works, but try <a href="http://henrik.nyh.se/2007/03/improved-bookmark-to-batch-link-flickr-images/">this updated code</a>.</p>
</div>
