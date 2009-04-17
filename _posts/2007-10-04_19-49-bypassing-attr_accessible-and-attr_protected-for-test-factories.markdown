--- 
wordpress_id: 180
title: Bypassing attr_accessible/attr_protected for test factories
tags: 
- Ruby
- Ruby on Rails
---
<a href="http://manuals.rubyonrails.com/read/chapter/47">Using attr_accessible/attr_protected to secure your models during mass-assignment</a> is a good idea – when you're mass-assigning unsafe user-provided data.

If you <a href="http://www.dcmanges.com/blog/38">use factory methods for tests</a>, though, or do trusted mass-assignment elsewhere, you might want a way to bypass the protection.

I added this to <code>test/test_helper.rb</code>:

{% highlight ruby %}
class ActiveRecord::Base
  def self.unprotected_create!(*args)    
    previous_attr_protected  = read_inheritable_attribute("attr_protected")
    previous_attr_accessible = read_inheritable_attribute("attr_accessible")

    write_inheritable_attribute("attr_protected",  nil)
    write_inheritable_attribute("attr_accessible", nil)

    creation = create!(*args)

    write_inheritable_attribute("attr_protected",  previous_attr_protected)
    write_inheritable_attribute("attr_accessible", previous_attr_accessible)

    creation
  end
end
{% endhighlight %}

Then just use <code>unprotected_create!</code> instead of <code>create!</code> for your factories.
