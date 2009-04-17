--- 
wordpress_id: 9
title: Modifying the Transmit widget to copy URLs to clipboard
tags: 
- JavaScript
- Ruby
- OS X
- Dashboard widgets
---
Yet another clipboard hack. I should just rename this blog "Copy and pug". ;)

The FTP application <a href="http://www.panic.com/transmit/">Transmit</a> comes with a <a href="http://www.apple.com/macosx/features/dashboard/">Dashboard widget</a>, on which you (drag-and-)drop files to transfer them to whatever server and directory you've configured.

I missed one feature, though &ndash; having the resulting URLs of the files automatically copied to clipboard. I've posted a feature request to the Transmit people, but whipped up my own solution to stay me until they get around to it, if they do at all.

<!--more-->

<div class="updated">
<h5>Update 2007-10-26</h5>

I had to make a tiny fix to the widget for it to work with Leopard (using <code>/bin/echo</code> without the <code>-e</code> flag rather than just <code>echo</code> with the <code>-e</code> flag), so I took the opportunity to
<ul>
<li>make this an unidiff;</li>
<li>remove the stuff about adding <code>&lt;key&gt;AllowSystem&lt;/key&gt;&lt;true/&gt;</code> to the <code>Info.plist</code>, since the widget seems to have that already these days; and</li>
<li>sort-of-fix an encoding issue, so characters in Latin-1 (not just ASCII) are handled correctly.</li>

The post has been updated with this code.
</ul>

</div>

When the widget is installed, edit <code>/Users/<em>username</em>/Library/Widgets/Transmit.wdgt/Transmit.js</code> per <a href="http://pastie.textmate.org/111275">this patch</a>.

Adjust the <code>section</code> and <code>url</code> bits to taste. The <code>url</code> is what goes before the filename. In my case, I have two widgets that upload to the directories "henrik.nyh.se/foo" and "henrik.nyh.se/bar" respectively, so the <code>section</code> line extracts the directory name and tacks it onto the rest of the <code>url</code>.

<h3>Copy on drop or on completion?</h3>

I prefer to have the URLs copied immediately after dropping files on the widget, rather than when the files have finished uploading. That way, my clipboard will be replaced as an immediate reponse to something I did, rather than at some unexpected time in the future, when I might have forgotten all about the upload and copied something import to clipboard. The downside is that I will have the URL before it actually points to something.

You could just hook the code into <code>uploadFinished()</code> instead, if you'd prefer to have it copy when finished.

<h3>Turning the URLs into tags</h3>

This could, of course, be combined with commands to transform the clipboarded URLs into link or image tags in HTML, BBCode, Markdown or whatever. The command might be triggered with <a href="http://quicksilver.blacktree.com/">Quicksilver</a> similarly to <a href="http://henrik.nyh.se/2006/07/batch-open-urls-from-clipboard/">Batch-open URLs from clipboard</a>.

A Ruby script for making BBCode links out of raw URLs follows, with only minor and (hopefully) obvious changes necessary to instead copy to another format.

{% highlight ruby %}#!/usr/bin/ruby
require "cgi"

url_pattern = %r{https?://\S+}i
url_antipattern = %r{(.+?)([^\w/]*)$}i

fixed = `pbpaste`.gsub(url_pattern) do |url|
  match = url.match(url_antipattern)
  url, tail = match[1,2]
  link = CGI::unescape((url =~ %r{.+[^/:]/(.+)}) ? $1 : url)
  "[url=#{url}]#{link}[/url]#{tail}"
end

IO.popen("pbcopy", "w") { |copier| copier.print fixed }{% endhighlight %}
