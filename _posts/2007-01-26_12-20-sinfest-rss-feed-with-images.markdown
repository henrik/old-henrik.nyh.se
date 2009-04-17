--- 
wordpress_id: 99
title: Sinfest RSS feed with images
tags: 
- PHP
---
I couldn't find a <a href="http://www.sinfest.net">Sinfest</a> RSS feed with images inline in each post, so I made one: <a href="http://henrik.nyh.se/scrapers/sinfest.rss">Sinfest RSS feed with images</a>. 

<!--more-->

It wraps the official (but undocumented?) <a href="http://www.sinfest.net/rss.php">feed</a>, simply duplicating the image links into inline images. The results are cached. 

Enhancing feeds by wrapping them is really easy if you know your way around regular expressions. XML parsing would probably be overkill. Caching the feed is a courtesy to the source provider, and doesn't add a lot of code.

This is the code for this feed:

{% highlight php %}
<?php

$cache = "sinfest_feed.txt";
$expires = 30*60;  // in 30 minutes

if (!(@filemtime($cache) > time() - $expires)) {  // Cache expired, or does not exist

  $feed = file_get_contents("http://www.sinfest.net/rss.php");
  $feed = preg_replace('!(\s*)<link>(.+?\.(?:gif|png|jpe?g))</link>!', '$0$1<description>&lt;img src="$2" alt="Comic"&gt;</description>', $feed);
  $feed = preg_replace('/^\s*/', '', $feed);  // Source feed has illegal initial whitespace
  
  $c = fopen($cache, "w");
  fwrite($c, $feed);
  fclose($c);

} else {  // Was cached, so retrieve

  $feed = file_get_contents($cache);

}

header('Content-type: application/rss+xml');
echo $feed;

?>
{% endhighlight %}
