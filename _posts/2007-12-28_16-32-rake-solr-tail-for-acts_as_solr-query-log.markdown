--- 
wordpress_id: 201
title: rake solr:tail for acts_as_solr query log
tags: 
- Ruby
- Ruby on Rails
- Rake
- acts_as_solr
---
Here is a quick (and a bit dirty) Rake task to track the acts_as_solr built-in Jetty server log:

{% highlight ruby %}
namespace :solr do
  
  desc 'Tails the Solr log'
  task :tail => :environment do
    system("tail", "-f", "#{RAILS_ROOT}/vendor/plugins/acts_as_solr/solr/tmp/jetty_#{RAILS_ENV}")
  end

end
{% endhighlight %}

If you put that in e.g. <code>lib/tasks/solr_additions.rake</code>, you can then do <code>rake solr:tail</code> to see the last couple of queries to the Solr server. The output will update as new queries come in (courtesy of <code><a href="http://www.unix-manuals.com/quicktips/unix/tail.html">tail -f</a></code>); break out of it with <code>⌃C</code>.
