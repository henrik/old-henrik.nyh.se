--- 
wordpress_id: 130
title: Ruby script to make LiveJournal entries private in batch
tags: 
- Ruby
- LiveJournal
---
I've been wanting to make some old, silly LiveJournal entries private (so that only I can read them) for some time.

There were 60 or so entries, and LiveJournal does not seem to provide batch editing. I've tried using some Perl stuff I found for the purpose, but I couldn't get it working. Today, I resolved to write my own Ruby script for it.

<!--more-->

Turns out there is <a href="http://neugierig.org/software/livejournal/ruby/">a LiveJournal Ruby module</a> which saved me a lot of work. The API is not very pleasant, but perhaps that reflects the underlying LiveJournal API.

Anyway, this is a script to make all your posts before a certain date private. Modify to taste; at the very least, change the name and password, unless they happen to be "foo" and "bar"…

Script (<a href="http://svn.nyh.se/ruby/LiveJournal%20make%20entries%20private.rb">download</a>):

{% highlight ruby %}
#!/usr/bin/env ruby
# By Henrik Nyh 2007-04-14.
# Free to modify and redistribute with due credit.

USERNAME = 'foo'
PASSWORD = 'bar'
MAKE_PRIVATE_BEFORE = Time.mktime(2004, 04, 01)  # year, month, day


require 'rubygems'
require 'livejournal/login'
require 'livejournal/entry'

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
  if e.time < MAKE_PRIVATE_BEFORE and e.security != :private
    puts "\tMaking private..."
    e.security = :private
    LiveJournal::Request::EditEvent.new(user, e).run
  end
  puts "\tSecurity: #{s = e.security;  s == :private ? s.to_s.upcase : s}"
end

puts "All done."
{% endhighlight %}
