--- 
wordpress_id: 41
title: Scrobbler (Last.fm) sidebar module
tags: 
- PHP
- WordPress
---
I recently switched this blog to the <a href="http://www.getk2.com">K2 WordPress theme</a>. By the time you read this, I might be using something else &ndash; the blog is new and its appearance very much in flux.

K2 supports <a href="http://nybblelabs.org.uk/projects/sidebar-modules/">sidebar modules</a>, similar to <a href="http://automattic.com/code/widgets/">sidebar widgets</a>.

I created such a sidebar module for use with the <a href="http://leflo.de/projekte/wordpress/scrobbler/">Scrobbler</a> plug-in, which displays <a href="http://www.last.fm">Last.fm</a> data in your blog.

<!--more-->

Though there's nothing non-obvious about the code, it still might save someone else some work.

The module displays the Last.fm favicon to the right of the header, similar to the RSS icon in some other modules. It achieves this by leveraging the <code>feedlink</code> CSS class. If you're anal about semantic HTML, you might want to rework this.

Watch it in action (at the time of writing, at least) at <a href="http://henrik.nyh.se/about/">my "About" page</a>.

This goes into a file like <code>wp-content/themes/k2/modules/lastfm.php</code> (<a href="http://henrik.nyh.se/uploads/lastfm.phps">download</a>):

{% highlight php %}<?php

function lastfm_sidebar_module($args) {
  global $scrobbler_user;
  extract($args);

  if ( function_exists('get_scrobbler') ) {
    echo $before_module . $before_title . $title . $after_title;
?>
    <span class="metalink"><a href="http://www.last.fm/user/<?php echo $scrobbler_user; ?>" class="feedlink" title="My Last.fm profile"><img src="http://static.last.fm/matt/favicon.ico" alt="Last.fm" /></a></span>
    
    <?php
    get_scrobbler();
    echo $after_module;
  }
}

register_sidebar_module('Last.fm module', 'lastfm_sidebar_module', 'sb-lastfm');

?>{% endhighlight %}
