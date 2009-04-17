--- 
wordpress_id: 150
title: Rake task to (re)index models for acts_as_solr
tags: 
- Ruby
- Ruby on Rails
- Rake
---
I'm currently playing with <a href="http://lucene.apache.org/solr/">Solr</a>/<a href="http://acts_as_solr.railsfreaks.com/">acts_as_solr</a> for a Rails project.

Alas, there doesn't seem to be any simple way to (re)index your models. If model objects are added or modified while the Solr server is running, the index is updated, but if you install acts_as_solr when you already have a bunch of data,  you've got some work ahead of you.

You could loop over every object and run <code>solr_save</code>. A better idea is to run <code>rebuild_solr_index</code> on every model class. This method more or less amounts to running solr_save on each object and optimizing the index afterwards, though it can add items in batch to speed things up.

Better still would be to have this wrapped in a Rake task, so you can easily (re)index all models that act_as_solr without going into the console and processing the classes one by one.

<!--more-->

This is <a href="http://henrik.nyh.se/uploads/solr_additions.rake">solr_additions.rake</a>. Stick it in lib/tasks inside your Rails project.

{% highlight ruby %}
namespace :solr do
  
  desc %{Reindexes data for all acts_as_solr models. Clears index first to get rid of orphaned records and optimizes index afterwards. RAILS_ENV=your_env to set environment. ONLY=book,person,magazine to only reindex those models; EXCEPT=book,magazine to exclude those models. START_SERVER=true to solr:start before and solr:stop after. BATCH=123 to post/commit in batches of that size: default is 300. CLEAR=false to not clear the index first; OPTIMIZE=false to not optimize the index afterwards.}
  task :reindex => :environment do
    
    includes = env_array_to_constants('ONLY')
    if includes.empty?
      includes = Dir.glob("#{RAILS_ROOT}/app/models/*.rb").map { |path| File.basename(path, ".rb").camelize.constantize }
    end
    excludes = env_array_to_constants('EXCEPT')
    includes -= excludes
    
    optimize     = env_to_bool('OPTIMIZE',     true)
    start_server = env_to_bool('START_SERVER', false)
    clear_first   = env_to_bool('CLEAR',       true)
    batch_size   = ENV['BATCH'].to_i.nonzero? || 300

    if start_server
      puts "Starting Solr server..."
      Rake::Task["solr:start"].invoke 
    end
    
    # Disable solr_optimize
    module ActsAsSolr::CommonMethods
      def blank() end
      alias_method :deferred_solr_optimize, :solr_optimize
      alias_method :solr_optimize, :blank
    end
    
    models = includes.select { |m| m.respond_to?(:rebuild_solr_index) }    
    models.each do |model|
  
      if clear_first
        puts "Clearing index for #{model}..."
        ActsAsSolr::Post.execute(Solr::Request::Delete.new(:query => "type_t:#{model}")) 
      end
      
      puts "Rebuilding index for #{model}..."
      model.rebuild_solr_index(batch_size)

    end 

    if models.empty?
      puts "There were no models to reindex."
    elsif optimize
      puts "Optimizing..."
      models.last.deferred_solr_optimize
    end

    if start_server
      puts "Shutting down Solr server..."
      Rake::Task["solr:stop"].invoke 
    end
    
  end
  
  def env_array_to_constants(env)
    env = ENV[env] || ''
    env.split(/\s*,\s*/).map { |m| m.singularize.camelize.constantize }.uniq
  end
  
  def env_to_bool(env, default)
    env = ENV[env] || ''
    case env
      when /^true$/i: true
      when /^false$/i: false
      else default
    end
  end

end
{% endhighlight %}

The description and code hopefully make things apparent. The simplest way to use it is just <code>rake solr:reindex</code> which will (re)index all models with an act_as_solr declaration inside them, and which assumes there is a Solr server already running.

Since it depends on the "environment" task, you can also use e.g. <code>RAILS_ENV=production</code> to set what environment it applies to. I think there are gotchas related to using acts_as_solr against multiple environments, though.

<div class="updated">
<h5>Update 2007-06-18</h5>

The entry has been updated to take advantage of the batch processing support in acts_as_solr 0.9. Batched reindexing is several times faster, since the overhead for posting and indexing additions one by one really adds up. 
</div>

<div class="updated">
<h5>Update 2007-06-19</h5>

Now takes an <code>OPTIMIZE</code> flag that defaults to <code>true</code>. Optimizing the index is recommended <a href="http://api.railsfreaks.com/projects/acts_as_solr/classes/ActsAsSolr/CommonMethods.html#M000111">"once following large batch-like updates and/or once a day"</a>. 
</div>

<div class="updated">
<h5>Update 2007-07-04</h5>

Now takes an <code>CLEAR</code> flag that defaults to <code>true</code>. Clearing means emptying the index before reindexing. <code>rebuild_solr_index</code> does not do this by default, which means it will not get rid of orphaned records – items that are indexed but no longer in the database. 
</div>
