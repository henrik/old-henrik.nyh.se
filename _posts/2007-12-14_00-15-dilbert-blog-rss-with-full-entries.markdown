--- 
wordpress_id: 199
title: The Dilbert Blog RSS feed with full entries (and RSS scraping with Ruby on Dreamhost)
tags: 
- Ruby
- Hpricot
- RSS
---
<a href="http://dilbertblog.typepad.com/">The Dilbert Blog</a> can be entertaining. However, <a href="http://dilbertblog.typepad.com/the_dilbert_blog/rss.xml">the RSS feed</a> was recently changed from containing the full entries to containing only a snippet, to increase ad revenue (by having people click through to the site).

I like full entries in my feed reader, so I made a feed that has them: <a href="http://henrik.nyh.se/scrapers/dilbert.rss">dilbert.rss</a>

That's all you need to know if all you wanted was the feed. Read on for technical details.

<!--more-->

<h3>Technical details :)</h3>

I'm using Ruby as a CGI script on <a href="http://www.dreamhost.com/r.cgi?296532 ">Dreamhost (referral link)</a>.

Most of the heavy lifting is done by Christoffer Sawicki's excellent <a href="http://termos.vemod.net/feedalizer">Feedalizer</a> gem.

I added very simple caching: rather than retrieving and parsing the web site on each hit, the output is written to a text file. The text file lives for 30 minutes and is then regenerated on the next hit.

This goes in <code>dilbert.cgi</code>, which should be executable:

{% highlight ruby %}
#!/usr/bin/env ruby

# This script generates a RSS feed for The Dilbert Blog with full entries,
# as opposed to summaries.

# Enable using gems I've installed, on Dreamhost
# http://nateclark.com/articles/2006/10/20/dreamhost-your-own-packages-and-gems
ENV['GEM_PATH'] = "/usr/lib/ruby/gems/1.8:/home/henrik/.gems"

require "rubygems"
require "feedalizer"

URL   = "http://dilbertblog.typepad.com/the_dilbert_blog/"
CACHE_FILE = "dilbert.cache"
CACHE_LIFE  = 30  # minutes

def uncached?
  !File.exist?(CACHE_FILE) ||
  (Time.now - File.mtime(CACHE_FILE))/60 > CACHE_LIFE
end

print "Content-Type: text/xml\n\n"

feedalize(URL) do
  feed.title = "The Dilbert Blog: Full Entries" 
  feed.description = "Dilbert humor, business absurdity, the meaning of life. And full entries."
  feed.about = URL

  scrape_items("//div.entry") do |rss_item, html_entry|
    header = html_entry.at('.entry-header')
    rss_item.link  = header.at('a').attributes['href']
    rss_item.date  = Time.parse(html_entry.at('.post-footers').inner_text)
    rss_item.title = header.inner_text
    rss_item.description = html_entry.at('.entry-body').inner_html
  end

  File.open(CACHE_FILE, 'w') {|f| f.write output }  # cache output
end if uncached?

print File.read(CACHE_FILE)
{% endhighlight %}

If you don't like <code>.cgi</code> in your URLs (I don't), put this in a <code>.htaccess</code> file in the same directory:

{% highlight text %}
RewriteEngine On
RewriteRule ^(dilbert)\.rss$    $1.cgi [L]
{% endhighlight %}
