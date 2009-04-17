--- 
wordpress_id: 174
title: Ruby script to batch find-and-replace in LiveJournal entries
tags: 
- Ruby
- LiveJournal
---
I got a request for a script like my <a href="http://henrik.nyh.se/2007/04/ruby-livejournal-batch-private">Ruby script to make LiveJournal entries private in batch</a>, but to replace a string in all entries (e.g. if you've changed the URL of your web site).

I usually do not do commission work for free, but I dislike the idea of someone having to spend ages on something I could do in a few minutes, and I had those minutes to spare. So voilà, <a href="http://henrik.nyh.se/uploads/lj_batch_replace.rb">lj_batch_replace.rb</a>:

<!--more-->

{% highlight ruby %}
#!/usr/bin/env ruby
# By Henrik Nyh 2007-09-11.
# Free to modify and redistribute with due credit.


# Change these:

USERNAME = 'frank'
PASSWORD = 'sesame'

REPLACE_FROM = 'myoldsite.com'
REPLACE_UNTO = 'mynewsite.com'


# Leave these alone unless you know what you're doing:

require 'rubygems'
require 'livejournal/login'
require 'livejournal/entry'

# So the livejournal gem doesn't choke:
# http://henrik.nyh.se/2007/04/ruby-livejournal-batch-private#comments
LiveJournal::Entry::KNOWN_EXTRA_PROPS << "used_rte"

puts "Logging in..."
user = LiveJournal::User.new(USERNAME, PASSWORD)
login = LiveJournal::Request::Login.new(user)
login.run
puts "Login response:"
login.dumpresponse

puts "Getting entries..."
entries = LiveJournal::Request::GetEvents.new(user, :recent => -1).run.values
entries = entries.sort_by { |e| e.time }

puts "Processing entries..."
entries.each do |e|
  puts "#{e.time} #{e.subject}"
  e.event = e.event.gsub(REPLACE_FROM, REPLACE_UNTO)
  LiveJournal::Request::EditEvent.new(user, e).run
  puts e.event
end

puts "All done."
{% endhighlight %}

As with <a href="http://henrik.nyh.se/2007/04/ruby-livejournal-batch-private">the batch private script</a>, you need to install a Ruby interpreter, install RubyGems, install the LiveJournal gem (e.g. <code>sudo gem install livejournal</code>), configure the values at the top of the script and then run it (e.g. <code>ruby lj_batch_replace.rb</code>).
