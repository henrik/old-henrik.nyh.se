--- 
wordpress_id: 259
title: Use save(false), not save_without_validation
tags: 
- Ruby
- Ruby on Rails
---
In Active Record, I've preferred <code>save_without_validation</code> to <code>save(false)</code> because I like self-documenting code.

Until it was pointed out to me today, I somehow hadn't realized <code>save_without_validation</code> is a method introduced by <code>alias_method_chain</code>.

This means, of course, that by using <code>save_without_validation</code> directly, you miss out on other parts of the <code>save</code> method chain. At the time of writing, I think this is just <a href="http://ryandaigle.com/articles/2008/3/31/what-s-new-in-edge-rails-dirty-objects">dirty object handling</a>. Plugins may introduce more.

For that reason, I will be using <code>save(false)</code> in future. It's common enough that I can accept the lack of clarity; you could also do <code>save(validate=false)</code>, of course, at the cost of an extra instance variable.

<!--more-->

Example of how things can go wrong with <code>save_without_validation</code>:

{% highlight ruby %}
>> u = User.first
>> u.changed?
=> false
>> u.name = "foo"
=> "foo"
>> u.save
=> true
>> u.changed?
=> false
>> u.name = "bar"
"bar"
>> u.save_without_validation
=> true
>> u.changed?
=> true
>> u.name = "baz"
=> "baz"
>> u.save(false)
=> true
>> u.changed?
=> false
{% endhighlight %}

Note that <code>u.changed?</code> is <code>true</code> when using <code>save_without_validation</code>, but not with <code>save</code> or <code>save(false)</code>.
