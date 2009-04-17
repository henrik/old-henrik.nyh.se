--- 
wordpress_id: 5
title: Batch-open URLs from clipboard
tags: 
- Ruby
- OS X
---
I often find myself wanting to batch-open several URLs from somewhere, typically an IM message log.

I've previously written a Greasemonkey script, <a href="http://userscripts.org/scripts/show/3279">Batch URL input</a>, in an attempt to solve this in at least the IM case. However, this requires an effort on the part of the person you're talking to, and also that they send their URLs all at once.

Recently, I came up with a better and more general solution.

<!--more-->

I simply have to copy some text containing URLs from wherever, and then run a Ruby script. Using <a href="http://quicksilver.blacktree.com/">Quicksilver</a>, running the script is only a matter of double-tapping the Command key, typing the first few letters of the script name, and hitting Return. The URLs should open in your default browser.

<h3>The script</h3>

{% highlight ruby %}#! /usr/bin/env ruby

url_pattern = %r{https?://\S+}i
url_antipattern = %r{[^\w/]+$}i

`pbpaste`.scan(url_pattern) do |url|
  url.sub!(url_antipattern, '')
  url.gsub!('"', '\"')  # Avoid command injection
  system(%Q{open "#{url}"})
end{% endhighlight %}

The <code>url_pattern</code> is a regular expression that matches a http:// or https:// and onwards until it runs into whitespace or out of text. The <code>url_antipattern</code> is used to strip any trailing punctuation from this. This is obviously not a very correct method for matching URLs, but it works fine for my purposes. If you often find yourself exchanging <code>prospero://</code> URLs with friends, though, you might want to use <a href="http://www.foad.org/~abigail/Perl/url3.regex">this behemoth</a> instead…

Make the script runnable with e.g. <code>chmod u+x clipurl.rb</code>.

<h3>Hooking it up with Quicksilver</h3>

Install the Terminal plug-in if you don't have it already.

Make sure the catalog is updated to include the script. This should happen automatically within ten minutes, or can be done manually from within the Quicksilver preferences.

Open the Quicksilver command interface. Start typing the name of the script. Mine is called <code>Clipboard open URLs.rb</code>.

Tab to the action slot. Select "Run". I moved "Run" above "Run in terminal" in the General > Actions > Files & Folders settings, so that it is the default action when selecting a script.

And that's it. Just copy some text containing URLs and then run the script.

Test with this:

{% highlight text %}Frou http://www.example.com, frou (http://www.google.com/#squid)
and http://henrik.nyh.se!{% endhighlight %}
