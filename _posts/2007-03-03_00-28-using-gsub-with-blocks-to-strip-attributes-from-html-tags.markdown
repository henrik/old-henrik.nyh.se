--- 
wordpress_id: 110
title: Using gsub with blocks to strip attributes from HTML tags
tags: 
- Ruby
---
I love Ruby's <code>gsub</code> used with blocks. To strip specified attributes from HTML tags becomes almost too easy:

{% highlight ruby %}

html = 'Getting <a href="#" id="foo">rid</a> of <code id="bar">id</code> attributes, but not in text: id="not this".'

html.gsub(/<(.*?)>/) {|innards| innards.gsub(/ id=("|').*?\1/, '') }

# => Getting <a href="#">rid</a> of <code>id</code> attributes, but not in text: id="not this".
{% endhighlight %}
