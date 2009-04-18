--- 
wordpress_id: 138
title: Recent LiveJournal entries with Ruby (including LJ cuts and comments)
tags: 
- Ruby
- LiveJournal
---
I recently rewrote <a href="http://i.johannaost.com">my girlfriend's personal site</a> to list recent LiveJournal entries, recent photos on Flickr and such.

LiveJournal offers <a href="http://www.livejournal.com/developer/embedding.bml?method=all">various data feeds</a>, but only if you're a paying customer. These feeds seem to include the "cut" post body text – that is, any <a href="http://www.livejournal.com/support/faqbrowse.bml?faqid=75">LJ cuts</a> are shown as such; messages are not shown in full. This is what I want.

But again, this is just for paying customers. Also, you just get a blob of HTML and would need to parse that to do things like changing the date format. Furthermore, I wanted to show the number of comments on each entry, to make the page feel more dynamic.

I ended up retrieving most of the data from a RSS feed, and then parsing the things it does not provide – the cut post body text and comment counts – from HTML using <a href="http://code.whytheluckystiff.net/hpricot/">Hpricot</a>.

<!--more-->

The page is Ruby CGI running on Dreamhost.

<h4>The LiveJournal class</h4>

This class is sadly under-featured for its name, but it does show recent entries.

It caches stuff and sends an informative user agent to comply with <a href="http://www.livejournal.com/bots/">LiveJournal's rules for bots</a>. Be sure to change that user agent.

The constants in the code should properly be arguments passed into the class, but I couldn't be bothered.

The code should be pretty self-explanatory: 

{% highlight ruby %}
# Make Time.now do Central European Time
ENV['TZ'] = 'CET'

%w{rubygems hpricot open-uri rexml/document time}.each { |lib| require lib }

class LiveJournal
  USER_AGENT = "http://mysite.example.com; me@mysite.example.com"
  STALE_IN_MINUTES = 3
  CACHE_FILE = "lj-cache.txt"

  def initialize(username)
    @username = username
  end

  def recent_entries(options={:max => 2})
    age = if File.exist?(CACHE_FILE) then (Time.now - File.mtime(CACHE_FILE))/60 else STALE_IN_MINUTES end
    retrieve(options) unless age < STALE_IN_MINUTES
    entries = Marshal.load(File.read(CACHE_FILE))
    if entries.size < options[:max]
      retrieve(options)
    else
      entries
    end
  end
  
  private
  
  def blog() "http://#{@username}.livejournal.com/" end
  def feed() "#{blog}data/rss" end

  # By the rules in http://www.livejournal.com/bots/.
  def friendly_open(url)
    open(url, {"User-Agent" => USER_AGENT})
  end
  
  def retrieve(options)
    # Get the abbreviated (LJ-cut) bodies
    doc = Hpricot(friendly_open(blog))
    bodies = doc.search(%{//table[@class="entrybox"]/tr/td/table/tr[2]/td}).map { |entry| entry.inner_html.strip }
    comment_counts = doc.search(%{//table[@class="entrybox"]//td[@class="comments"][1]}).map { |td| td.inner_text.scan(/\d+/).first.to_i }

    # Get metadata and create post representations
    posts = []
    xml = REXML::Document.new(friendly_open(feed).read)
    xml.root.elements.to_a("channel/item").each_with_index do |item, index|
      break if index == bodies.size or options[:max] == index
      posts << {
        :link => item.elements["link"].text,
        :title => (item.elements["title"].text rescue nil),
        :date => Time.parse(item.elements["pubDate"].text),
        :body => bodies[index],
        :comment_link => (item.elements["comments"].text rescue nil),
        :comment_count => comment_counts[index]
      }
    end

    # Write to cache
    File.open(CACHE_FILE, 'w') { |f| f.print Marshal.dump(posts) }
    posts
  end
  
end
{% endhighlight %}

Different LiveJournal styles have different markup, so you'll likely have to change the XPath expressions in the code to fit.

Also note that since it pulls the cut body text and the comment count from your LiveJournal front page, it can only provide that info for those entries that are displayed there. If you want more, you'd have to make it handle pagination.

<h4>Displaying the data</h4>

I use Rails date helpers to show relative days. I suppose requiring ActionController and ActionView is overkill, but hey:

{% highlight ruby %}
require "action_controller"
require "action_view"
include ActionView::Helpers::DateHelper
{% endhighlight %}

For tidiness' sake, I stuck the username in a constant:

{% highlight ruby %}
LIVEJOURNAL_USERNAME = 'me'
{% endhighlight %}

No need for a password since the code only deals with public entries.

Finally, this is the erb/eruby to actually show the entries:

{% highlight rhtml %}
<h2>Recent LiveJournal entries</h2>

<%
 entries = LiveJournal.new(LIVEJOURNAL_USERNAME).recent_entries(:max => 3)
 entries.each do |post|        
%>

<div class="lj-post">
  <h3><a href="<%= post[:link] %>"><%= post[:title] || "Untitled" %></a>, <%= time_ago_in_words(post[:date]) %> ago</h3>

  <%= post[:body] %>
  
  <% if post[:comment_link] %>
  <p class="comment">
    <a href="<%= post[:comment_link] %>">
      <%= post[:comment_count]==0 ? "No" : post[:comment_count] %> comment<%= "s" unless post[:comment_count]==1 %>
    </a>
  </p>
  <% end %>

</div>

<% end %>

<p>
  <a href="http://<%= LIVEJOURNAL_USERNAME %>.livejournal.com/">More entries &raquo;</a>
</p>
{% endhighlight %}

And that's that. Have fun with it.
