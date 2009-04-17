--- 
wordpress_id: 181
title: Whiny protected attributes
tags: 
- Ruby
- Ruby on Rails
---
When using <a href=http://manuals.rubyonrails.com/read/chapter/47">attr_accessible/attr_protected</a> to protect attributes during mass-assignment, assignments to protected attributes are silently discarded.

So if you

{% highlight ruby %}
User.create!(:username => "Fool", :age => 12, :admin => true)
{% endhighlight %}
and <code>admin</code> is a protected attribute, then the record will still be created but will only assign the username and age.

This can sometimes cause confusion in development, when you accidentally protect an attribute too many, or mass-assign incorrectly. Since the assignments are silently ignored, it can take a while to figure out what's happening.

Hence this small piece of code.

Stick <a href="http://henrik.nyh.se/uploads/whiny_protected_attributes.rb">whiny_protected_attributes.rb</a>  (<a href="http://pastie.textmate.org/104522">highlighted on Pastie</a>) in the <code>lib</code> directory and then

{% highlight ruby %}
require 'whiny_protected_attributes'
{% endhighlight %}
in <code>config/environment.rb</code>.

Once the server has been restarted, ActiveRecord will now throw an exception whenever you try to mass-assign a protected attribute.

In production, an error is logged, but it doesn't throw, since it makes sense to still ignore it silently to the end-user's ears.
