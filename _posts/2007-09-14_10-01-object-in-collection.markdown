--- 
wordpress_id: 175
title: object.in?(collection)
tags: 
- Ruby
---
I often find <code>collection.include?(object)</code> to read backwards. Consider

{% highlight ruby %}
puts "Nice doggie!" if [:pug, :bulldog].include?(dog)
{% endhighlight %}
I think

{% highlight ruby %}
puts "Nice doggie!" if dog.in?(:pug, :bulldog)
{% endhighlight %}
reads a lot better.

<!--more-->

This may seem obvious to many. My intention is to promote the <em>idea</em> of doing things this way to those who hadn't considered it, and the (rather straightforward) implementation as a convenience.

This is the code I use in a current Rails project:

{% highlight ruby %}
class Object
  def in?(*args)
    collection = (args.length == 1 ? args.first : args)
    collection.include?(self)
  end
end
{% endhighlight %}

The conditionals make it so you can do either <code>dog.in?([:pug, :bulldog])</code> (easier if the collection is in a variable/constant) or <code>dog.in?(:pug, :bulldog)</code> (easier if you enumerate the collection right there). If you just want the former syntax,

{% highlight ruby %}
class Object
  def in?(collection)
    collection.include?(self)
  end
end
{% endhighlight %}

will do.

For better readability still, try something like

{% highlight ruby %}
alias_method :one_of?, :in?
{% endhighlight %}
and then

{% highlight ruby %}
puts "Nice doggie!" if dog.one_of?(:pug, :bulldog)
{% endhighlight %}
