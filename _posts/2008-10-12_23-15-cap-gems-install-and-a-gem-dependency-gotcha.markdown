--- 
wordpress_id: 250
title: cap gems:install and a Gem dependency gotcha
tags: 
- Ruby
- Ruby on Rails
- Capistrano
---
I made a simple Capistrano task to run <code>rake gems:install</code> on the server, for <a href="http://ryandaigle.com/articles/2008/4/1/what-s-new-in-edge-rails-gem-dependencies">Rails Gem dependencies</a>:

{% highlight text %}
namespace :gems do
  desc "Install gems"
  task :install, :roles => :app do
    run "cd #{current_path} && #{sudo} rake RAILS_ENV=production gems:install"
  end
end
{% endhighlight %}

The one non-obvious thing here is how <code>sudo</code> and <code>cd</code> interacts. Explained further in <a href="http://www.mail-archive.com/capistrano@googlegroups.com/msg05066.html">this thread</a>.

Also, I ran into a catch 22 with an app that has <code>will_paginate</code> as a Gem dependency.

<!--more-->

The <code>rake gems:install</code> task will load the app environment, but as I was using the <code>WillPaginate</code> constant in my app (in a helper), the task failed with

{% highlight text %}
uninitialized constant WillPaginate
{% endhighlight %}

So the Rake task could not run to install the gem, because the <code>WillPaginate</code> constant was not available, because the gem was not installed…

The fix was simply to check for the constant in a conditional:

{% highlight ruby %}
class CustomRenderer < WillPaginate::LinkRenderer
  ⋮
end if defined?(WillPaginate)  # avoid catch 22 with "rake gems:install"
{% endhighlight %}

Another solution would, of course, be to install the gem outside of the Rake task, but that kind of does away with the point of having the task in the first place.
