--- 
wordpress_id: 191
title: Comma concatenation for punctuation after link in Haml
tags: 
- Ruby
- Ruby on Rails
---
This post is just to suggest that in <a href="http://haml.hamptoncatlin.com/">Haml</a> (which I can't decide if I like or not), rather than something like

{% highlight text %}
%p
  You are logged in.
  = succeed "?" do
    = link_to("Log out", "#")
{% endhighlight %}
consider

{% highlight text %}
%p
  You are logged in.
  = link_to("Log out", "#"), "?"
{% endhighlight %}

Using string concatenation to avoid the fugly <code><a href="http://haml.hamptoncatlin.com/docs/rdoc/classes/Haml/Helpers.html#M000011">succeed</a></code> helper is fairly obvious, but I think that specifically using <code>,</code> has a nice flow to it in the common case of a link followed directly by punctuation.
