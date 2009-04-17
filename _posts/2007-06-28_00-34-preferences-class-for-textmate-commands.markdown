--- 
wordpress_id: 158
title: Preferences class for TextMate commands
tags: 
- Ruby
- OS X
- TextMate
---
In TextMate commands, you sometimes need to to persist information. Perhaps you want to remember what box the user checked, or their last input in some dialog.

When I needed persistence in my Greasemonkey bundle a while back, I wrapped the functionality in a <code>Preferences</code> class to keep things tidy. When I needed it again today, I tidied up that class further and moved it to a <a href="http://www.ruby-doc.org/core/classes/YAML.html">YAML</a> storage which made for less and nicer-looking code.

<!--more-->

You can use it like so:

{% highlight ruby %}
# require or paste the Preferences class here

# Store some values

prefs = Preferences[:foo_bundle]
prefs[:name] = "John Doe"
prefs[:age] = 42
prefs.merge!(:likes_pizza => true, :likes_broccoli => false)

# A reboot later…

prefs = Preferences[:foo_bundle]
puts "Your name is #{prefs[:name]} and you are #{prefs[:age]} years old."
puts "I know all this:"
p prefs.to_hash

# Forget age
prefs.delete(:age)

# Forget everything
prefs.clear!
{% endhighlight %}

String and symbol keys are interchangeable, so you could use <code>Preferences["foo_bundle"]["name"]</code> if you prefer, or even mix and match.

<a href="http://henrik.nyh.se/uploads/textmate_preferences.rb">Download with unit tests and all</a>, or see below for the meaty bits:

{% highlight ruby %}
# By Henrik Nyh <http://henrik.nyh.se> 2007-06-27
# Free to modify and redistribute with credit.

class Preferences
  %w{yaml fileutils}.each { |lib| require lib }
  
  # Each preference id should be a singleton

  @@instances = {}

  class << self; private :new; end

  def self.[](id)
    raise(ArgumentError, "Preference id must match /\A[a-zA-Z0-9_]+\Z/.") unless id.to_s =~ /\A\w+\Z/
    @@instances[id.to_sym] ||= new(id)
  end
  
  def initialize(id)
    @id = id.to_s
  end
  
  # Singleton code ends
    
  def [](key)
    value = to_hash[key.to_sym]
  end
  
  def []=(key, value)
    merge!({key => value})
    value
  end
  
  def merge!(new_hash)
    symbolized_keys = new_hash.inject({}) { |h, (k, v)| h[k.to_sym] = v; h }
    @hash = to_hash.merge(symbolized_keys)
    persist!
  end
  
  def delete(key)
    key = key.to_sym
    value = self[key]
    @hash.delete(key)
    persist!
    value
  end
  
  def clear!
    File.delete(path) if File.exist?(path)
    flush_cache!
  end
    
  def flush_cache!
    @hash = nil
  end
  
  def to_hash
    @hash ||= YAML.load_file(path) rescue {}
  end
  
private

  def path
    "#{ENV['HOME']}/Library/Preferences/com.macromates.textmate.#{@id}.yaml"
  end
  
  def persist!
    File.open(path, "w") { |out| YAML.dump(@hash, out) }
    @hash
  end
  
end
{% endhighlight %}
