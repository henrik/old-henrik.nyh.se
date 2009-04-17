--- 
wordpress_id: 184
title: rake accessify
tags: 
- Ruby
- Ruby on Rails
- Rake
---
<a href="http://somethinglearned.com/articles/2006/05/24/best-practices-a-strong-case-for-attr_accessible-part-2"><code>attr_accessible</code> is preferable to <code>attr_protected</code></a>, but typing out all the attributes to which you want to grant mass-assignment access can be bothersome with big models.

To make this easier, I made a <code>rake accessify</code> task. Run e.g.

{% highlight bash %}
rake accessify MODEL=user
{% endhighlight %}
for output like

{% highlight bash %}
attr_accessible :age, :location, :location_id, :sex
{% endhighlight %}
(but presumably longer). The output is in alphabetical order for your culling pleasure.

<!--more-->

Some attributes that are very rarely supposed to be accessible (like <code>*_count</code> and <code>created_at</code> – see code for the full list) are not included. It's <strong>very important</strong> to note, though, that the task is only meant to save typing, not to make security decisions. Some few obvious attributes are left out, but you should read through the generated list of attributes very carefully and remove those that should not be available to mass assignment.

To get this, just put <a href="http://henrik.nyh.se/uploads/accessify.rake">accessify.rake</a> in <code>lib/tasks</code>.

The code:

{% highlight ruby %}
excluded_setters  = %w[id [] attributes]
excluded_suffixes = %w[count ids] 

usage = "Specify model like 'rake accessify MODEL=user'."

desc "Outputs an attr_accessible statement with all setters except for those that typically are not for mass assigment, like *_count, *_ids and {created,updated}_{at,on}. #{usage} Note that this task is only meant to save the effort of typing in attributes manually; it does not make any security decisions for you. Read through the generated list of attributes very carefully and remove those that should not be available to mass assignment."
task :accessify => :environment do

  begin
    model = ENV['MODEL'].downcase.classify.constantize
  rescue
    raise "No such model! #{usage}"
  end

  methods = (model.instance_methods - Object.instance_methods).grep(/=$/).map(&:chop)
  columns = model.column_names
  setters = methods | columns
  setters.reject! do |setter|
    setter.match(/_#{ Regexp.union(*excluded_suffixes) }$/) || 
    setter.match(/(created|updated)_(at|on)/) || 
    excluded_setters.include?(setter)
  end
  setters = setters.sort.map(&:to_sym).map(&:inspect).join(', ')
  puts "attr_accessible #{ setters }"
  
end
{% endhighlight %}

Please point out any other attributes that can be discarded by default, and anything else that can be improved. I'm not at all sure this is the best way to pick out all setters.
