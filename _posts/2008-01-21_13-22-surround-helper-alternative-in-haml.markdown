--- 
wordpress_id: 202
title: surround helper alternative in Haml
tags: 
- Ruby
- Ruby on Rails
- Haml
---
I've previously blogged <a href="http://henrik.nyh.se/2007/11/comma-after-link-in-haml">a simple alternative</a> to the Haml <code><a href="http://haml.hamptoncatlin.com/docs/rdoc/classes/Haml/Helpers.html#M000013">succeed</a></code> helper.

Today I wanted to put a link in parentheses. There is a <code><a href="http://haml.hamptoncatlin.com/docs/rdoc/classes/Haml/Helpers.html#M000011">surround</a></code> helper, but that syntax isn't pretty.

This is what I do instead:

{% highlight text %}
%li
  =h item.name
  = "(%s)" % link_to_remote("x", item, :method => :delete)
{% endhighlight %}

The code

{% highlight text %}
"(%s)" % "foo"
{% endhighlight %}
in Ruby is short for

{% highlight text %}
format("(%s)", "foo")
{% endhighlight %}
or

{% highlight text %}
sprintf("(%s)", "foo")
{% endhighlight %}
and will simply return

{% highlight text %}
(foo)
{% endhighlight %}
.
