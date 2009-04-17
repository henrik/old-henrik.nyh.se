--- 
wordpress_id: 74
title: Fix for Bloglines breaking WordPress RSS feeds
tags: 
- PHP
- WordPress
---
If you're reading this through a feed reader, you might have seen a lot of recent posts marked as new. This would be because I just changed the WordPress generation code slightly to compensate for a <a href="http://www.bloglines.com/">Bloglines</a> issue.

The issue is that the part of a blog post after a cut will be all blue, because Bloglines will replace the cut anchor (something like <code>&lt;a id="more-123"&gt;&lt;/a&gt;</code>) with some broken code of its own, including links that span the cut contents.

<!--more-->

Ideally, Bloglines would solve this themselves. I reported the problem months ago. Since they haven't, though, I solved it for my own blog by simply making the cut anchor into a <code>div</code> tag rather than an <code>a</code> tag. The anchor still works, and Bloglines no longer messes with my feed.

I'm running WordPress 2.0. I've no idea if the problem or this solution apply to other versions. I did notice <a href="http://www.livejournal.com/">LiveJournal</a> feeds get the same treatment, though…

The file to change is <code>wp-includes/template-functions-post.php</code>, around row 90. Unidiff (<a href="http://henrik.nyh.se/uploads/bloglineswordpress.diff">download</a>):

{% highlight text %}
--- wp-includes/template-functions-post-old.php	2006-07-16 09:44:50.000000000 +0200
+++ wp-includes/template-functions-post.php	2006-10-25 20:46:47.000000000 +0200
@@ -87,7 +87,7 @@
 	$output .= $teaser;
 	if ( count($content) &gt; 1 ) {
 		if ( $more )
-			$output .= '&lt;a id="more-'.$id.'"&gt;&lt;/a&gt;'.$content[1];
+			$output .= '&lt;div id="more-'.$id.'"&gt;&lt;/div&gt;'.$content[1];
 		else
 			$output .= ' &lt;a href="'. get_permalink() . "#more-$id\"&gt;$more_link_text&lt;/a&gt;";
 	}
{% endhighlight %}
