--- 
wordpress_id: 210
title: Haml::Template options in Merb
tags: 
- Ruby
- Haml
- Merb
---
I'm rewriting a toy project in <a href="http://merbivore.com/">Merb</a> (0.5).

Though Merb supports <a href="http://haml.hamptoncatlin.com/">Haml</a> out of the box, I was unable to find a simple way of changing the Haml options, e.g. to wrap attributes in double-quotes instead of the default single-quotes.

In Rails, you can set them in the <code>Haml::Template.options</code> hash, but that doesn't work in Merb; that class is closely tied to Rails.

You can also pass options to the <code>Haml::Engine</code> constructor (which is what <code>Template</code> does). Merb doesn't seem to offer a simple way of doing this, but Ruby itself does.

Stick this in <code>config/merb_init.rb</code>:

{% highlight ruby %}
# Haml template configuration

class Haml::Engine
  alias_method :old_initialize, :initialize
  def initialize(template, options = {})
    options.merge!(
      :attr_wrapper => %{"}
    )
    old_initialize(template, options)
  end
end
{% endhighlight %}

And that's it.
