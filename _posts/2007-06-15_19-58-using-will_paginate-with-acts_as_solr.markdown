--- 
wordpress_id: 151
title: Using will_paginate with acts_as_solr
tags: 
- Ruby
- Ruby on Rails
---
<a href="http://henrik.nyh.se/2007/06/rake-task-to-reindex-models-for-acts_as_solr">Still</a> playing with Solr/acts_as_solr.

The site I'm working on uses <a href="http://errtheblog.com/post/4791">will_paginate</a> for pagination. It turned out to be pretty easy to get that working with results from acts_as_solr.

The solution is to add a <code>find_all_by_solr</code> method that wraps <a href="http://api.railsfreaks.com/projects/acts_as_solr/classes/ActsAsSolr/ClassMethods.html#M000094"><code>find_by_solr</code></a> and returns the <code>records</code> of the returned <code>SearchResults</code>.

<!--more-->

Stick <a href="http://henrik.nyh.se/uploads/solr_pagination.rb">solr_pagination.rb</a> in <code>lib</code> in your Rails project.

{% highlight ruby %}
# By Henrik Nyh <http://henrik.nyh.se> 2007-06-18.
# Free to modify and redistribute with credit.

# Adds a find_all_by_solr method to acts_as_solr models to enable 
# will_paginate for acts_as_solr search results.

module ActsAsSolr
  module PaginationExtension

    def find_all_by_solr(*args)
      find_by_solr(*args).records
    end

  end
end

module ActsAsSolr::ClassMethods
  include ActsAsSolr::PaginationExtension
end
{% endhighlight %}

Then ensure that this code is actually run, by adding

{% highlight ruby %}
require 'solr_pagination'
{% endhighlight %} to <code>config/environment.rb</code>. It wouldn't work at the bottom of that file, so I stuck it just before

{% highlight ruby %}
Rails::Initializer.run do |config|
{% endhighlight %}

If you want to verify that things work so far, (re)start the <code>script/console</code> and try something like <code>SomeModel.find_all_by_solr("foo", {:limit => 5, :offset => 2})</code>.

And that's the plumbing done.

You want a controller action like

{% highlight ruby %}
count = SomeModel.count_by_solr(params[:query])
@results = SomeModel.paginate_all_by_solr(params[:query], :page => params[:page], :total_entries => count)
{% endhighlight %}

and a view like

{% highlight rhtml %}
<dl>
<% @results.each do |result| %>
  <dt><%= result.title %></dt>
  <dd><%= result.description %></dd>
<% end %>
</dl>

<%= will_paginate @results %>
{% endhighlight %}

Note that the <code>:total_entries</code> must be specified explicitly to <code>paginate_all_by_solr</code>. <code>find_all_by_solr</code> isn't a regular finder, so will_paginate can't just do a SQL <code>COUNT</code>.

<div class="updated">
<h5>Update 2007-06-18</h5>

Today's 0.9 release of acts_as_solr made things easier. The code above has been updated.

Below is the old 0.8.5 version of <code>solr_pagination.rb</code>, which had to translate <code>:limit</code> and <code>:offset</code> (used by regular ActiveRecord finders) into <code>:rows</code> and <code>:start</code> (used by <code>find_by_solr</code>)</a>, and that got the records directly rather than in a <code>records</code> attribute.

{% highlight ruby %}
# By Henrik Nyh <http://henrik.nyh.se> 2007-06-15.
# Free to modify and redistribute with credit.

# Adds a find_all_by_solr method to acts_as_solr models to enable 
# will_paginate for acts_as_solr search results.

module ActsAsSolr
  module PaginationExtension

    def find_all_by_solr(query, options)
      map = {:limit => :rows, :offset => :start}
      map.each do |from, to|
        options[to] = options[from]
        options.delete(from)
      end
      find_by_solr(query, options)
    end

  end
end

module ActsAsSolr::ClassMethods
  include ActsAsSolr::PaginationExtension
end
{% endhighlight %}

</div>
