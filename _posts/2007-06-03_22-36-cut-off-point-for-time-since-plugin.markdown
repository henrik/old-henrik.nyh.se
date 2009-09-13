--- 
wordpress_id: 146
title: Cut-off point for Time Since plugin
tags: 
- PHP
- WordPress
---
I'm helping my girlfriend set up an <a href="http://me.johannaost.com/18thcentury">18th century blog</a>. I'm currently playing around with how to present dates and times for posts and comments. It's an interesting usability question, what with different time zones.

The <a href="http://binarybonsai.com/wordpress/time-since/">Time Since plugin</a> displays relative times like "1 hour, 23 minutes ago". I like this, but I want a cut-off point. Times older than some number of days (or hours, seconds, whatever) should be displayed absolute.

The plugin doesn't support this out of the box, but it's a very easy fix.

<!--more-->

Simply change the code for displaying the time into something like this:

{% highlight php %}<?php if (function_exists('time_since') && (time() - get_the_time('U') < 60*60*24*7)) { // If < 7 days ago ?>
  <?php echo time_since(abs(strtotime($post->post_date_gmt . " GMT")), time()) ?> ago
<?php } else { ?>
  <?php the_time('M jS, Y') ?> at <?php the_time('H:i') ?>
<?php } ?>
{% endhighlight %}

The `60*60*24*7` bit is the cut-off age – 7 days, in seconds.

Incidentally, that blog displays the absolute time in user local time per <a href="http://ecmanaut.blogspot.com/2006/01/ajax-date-time-time-zones-best.html">Johan's insights</a>. I'll likely blog that later.
