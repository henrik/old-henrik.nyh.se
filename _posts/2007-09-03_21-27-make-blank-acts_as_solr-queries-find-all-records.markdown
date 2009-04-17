--- 
wordpress_id: 172
title: Make blank acts_as_solr queries find all records
tags: 
- Ruby
- Ruby on Rails
---
I wrote a small piece of code that makes <a href="http://acts_as_solr.railsfreaks.com/">acts_as_solr</a>'s various querying methods find <em>all</em> entries (subject to facet options etc) instead of no entries when the query is blank.

This is useful if acts_as_solr powers a filtering interface: all entries should be returned if no query has been specified, and facets and queries can be used to view subsets.

<!--more-->

Stick <code><a href="http://henrik.nyh.se/uploads/empty_query_finds_all.rb">empty_query_finds_all.rb</a></code> in <code>/lib</code> and <code>require "empty_query_finds_all"</code> in <code>config/environment.rb</code>.

The code is simply this:

{% highlight ruby %}
# Modifies the innards of acts_as_solr so empty queries find every model instance
# instead of none, e.g. User.count_by_solr('') and Group.find_by_solr(nil).

module ActsAsSolr
  module FindAllExtension
    FIND_ALL_QUERY = 'type:[* TO *]'
    
    def self.included(mod)
      mod.alias_method_chain :parse_query, :find_all
    end

    def parse_query_with_find_all(query=nil, *args)
      query = query.blank? ? FIND_ALL_QUERY : query
      parse_query_without_find_all(query, *args)
    end

  end
end

module ActsAsSolr::ParserMethods
  include ActsAsSolr::FindAllExtension
end
{% endhighlight %}

Note that this makes use of <code><a href="http://weblog.rubyonrails.org/2006/4/26/new-in-rails-module-alias_method_chain">alias_method_chain</a></code> which is edge Rails. You can use multiple <code>alias_method</code>s instead.
