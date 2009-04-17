--- 
wordpress_id: 217
title: Flickr-style tag splitting in Ruby
tags: 
- Ruby
---
Someone asked on IRC for Ruby code to split tags <a href="http://flickr.com">Flickr</a> style, e.g. getting the tags from <code>tag1 tag2 "tag 3 has spaces" tag4</code>.

I came up with this:

{% highlight ruby %}
def parse_tags(string)
  string.split(/"(.+?)"|\s+/).reject {|s| s.empty? }
end
{% endhighlight %}

It even preserves tag order, which you wouldn't get if you'd first <code>gsub</code> out (and store) quoted tags and then <code>split</code> the rest.
