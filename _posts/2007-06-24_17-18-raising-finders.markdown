--- 
wordpress_id: 153
title: Raising finders
tags: 
- Ruby
- Ruby on Rails
---
I find exceptions preferable to if/else branching in many cases.

Though Rails has <code>save!</code> and <code>create!</code> methods that raise exceptions if they fail, the same can not be said for finders. <code>User.find(123)</code> will raise <code>ActiveRecord::RecordNotFound</code> if there's no record with that id, but other finders (<code>find(:all, …)</code>, <code>find(:first, …)</code> and dynamic finders like <code>find_by_username(…)</code>) will just return <code>nil</code> or an empty array.

Adding this has been <a href="http://groups.google.com/group/rubyonrails-core/browse_thread/thread/9b79f15be8cea7ab/b09890407fe2583e">discussed</a>, and there is <a href="http://dev.rubyonrails.org/ticket/5974">a slumbering ticket</a>.

This is my take. <code>require 'raising_finders'</code> in <code>environment.rb</code> and put this in <a href="http://henrik.nyh.se/uploads/raising_finders.rb"><code>lib/raising_finders.rb</code></a>:

{% highlight ruby %}
# Enables methods like find!(:all, …), find_by_username!(…) that
# raise ActiveRecord::RecordNotFound for empty results.

module RaisingFinders
  def method_missing(name, *args)
    return super unless name.to_s =~ /^(find(_.+)?)!$/
    returning send($1, *args) do |result|
      raise ActiveRecord::RecordNotFound if result.blank?
    end
  end
end

class << ActiveRecord::Base
  include RaisingFinders
end
{% endhighlight %}

While writing this, I found I was reinventing the wheel – there is a <a href="http://soen.ca/svn/projects/rails/plugins/whiny_finder/">whiny_finder</a> plugin that's functionally equivalent – but I find that code a bit wordy. My wheel is rounder!
