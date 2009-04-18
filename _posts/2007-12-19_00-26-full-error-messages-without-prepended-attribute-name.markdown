--- 
wordpress_id: 200
title: Full error messages without prepended attribute name
tags: 
- Ruby
- Ruby on Rails
---
In your Rails validations, you can add errors to <code>base</code> or to a specific attribute. When you add errors to an attribute, the full error messages (used e.g. by <code><a href="http://api.rubyonrails.org/classes/ActionView/Helpers/ActiveRecordHelper.html#M001005">error_messages_for</a></code>) are prepended by the (<a href="http://henrik.nyh.se/2007/12/change-displayed-column-name-in-rails-validation-messages">humanized</a>) attribute name.

Sometimes this isn't what I want. Here's a quick hack to not prepend the attribute name if the error message starts with an upper case character.

Just stick this in <code><a href="http://henrik.nyh.se/uploads/less_full_error_messages.rb">lib/less_full_error_messages.rb</a></code>, and <code>require</code> that file from <code>environment.rb</code>:

{% highlight ruby %}
class ActiveRecord::Errors
  def full_messages
    full_messages = []

    @errors.each_key do |attr|
      @errors[attr].each do |msg|
        next if msg.nil?

        if attr == "base" || msg =~ /^[[:upper:]]/
          full_messages << msg
        else
          full_messages << @base.class.human_attribute_name(attr) + " " + msg
        end
      end
    end
    full_messages
  end
end
{% endhighlight %}

Now,

{% highlight ruby %}
errors.add('name', "is just silly") if name.just_silly?
errors.add('born_at', "You're too young") if age < AGE_LIMIT
{% endhighlight %}

will result in the full error messages

{% highlight text %}
Name is just silly
You're too young
{% endhighlight %}
