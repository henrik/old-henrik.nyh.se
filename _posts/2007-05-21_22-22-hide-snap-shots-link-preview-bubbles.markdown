--- 
wordpress_id: 141
title: Hide "Snap Shots" link preview bubbles
tags: 
- Annoyances
- CSS
- Userstyles
---
<a href="http://www.snap.com/about/shots_central.php">Snap.com "Snap Shots"</a> annoy me. I don't want huge preview bubbles when I hover a link. So I got rid of them with <a href="http://userstyles.org/styles/2394">a tiny userstyle</a>:

{% highlight css %}
@namespace url(http://www.w3.org/1999/xhtml);

#snap_com_shot_main { display:none; }
{% endhighlight %}
