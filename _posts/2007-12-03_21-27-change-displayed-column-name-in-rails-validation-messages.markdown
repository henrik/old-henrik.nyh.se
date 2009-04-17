--- 
wordpress_id: 198
title: Change displayed column name in Rails validation messages
tags: 
- Ruby
- Ruby on Rails
---
I recently wanted to change how a database column name is represented in validation messages. Case in point: I wanted the "email" column to give error messages like "E-mail address must be valid".

I poked through the Rails code, and it turns out this is very simple. The method seems underdocumented/underblogged though, so I thought I'd write it up.

What you do is define a <code>human_attribute_name</code> method on the model class. The method is passed the column name as a string and returns the string to use in validation messages. You could exploit this in a couple of different ways, but this is what I do:

{% highlight ruby %}
class User < ActiveRecord::Base

  HUMANIZED_ATTRIBUTES = {
    :email => "E-mail address"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

end
{% endhighlight %}
