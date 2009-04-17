--- 
wordpress_id: 98
title: Automatically open incoming URLs with Adium
tags: 
- Ruby
- OS X
- AppleScript
- Adium
---
My girlfriend sends me quite a lot of links over IM. Opening each link manually by clicking is dreary, and it's easy to miss one.

My first attempt at automating away the pain was the <a href="http://userscripts.org/scripts/show/3279">Batch URL input</a> userscript, where you could disguise several URLs as one, and have Firefox explode them into individual tabs. This required an effort on the behalf of the sender, though, and that they would collect all URLs before sending them.

I then made a script to <a href="http://henrik.nyh.se/2006/07/batch-open-urls-from-clipboard/">batch-open URLs from the clipboard</a>. You simply copy some of the message history and invoke the script through e.g. <a href="http://quicksilver.blacktree.com/">Quicksilver</a>. A lot better, but still not quite there.

I like how my <abbr title="Instant Messaging">IM</abbr> client, Adium, can be configured to open "safe" (e.g. images) incoming files automatically. If I receive an image, I'm very likely to want to open it. I suppose you might be of another opinion if you often receive <a href="http://en.wikipedia.org/wiki/Not_safe_for_work">non-worksafe</a> images in public places.

So I made something similar for incoming URLs (in messages).

<!--more-->

I wrote an AppleScript (wrapping a Ruby script, wrapping a detached shell, wrapping AppleScript :&gt;) that is triggered whenever I receive a message from my girlfriend. In the user info dialog for her meta-contact (ICQ, Jabber and MSN all in one), under the "Events" tab, I added this script to be run on "Message received".

<p class="center"><img src="http://henrik.nyh.se/uploads/adium-incoming_urls_info.png" alt="" /></p>

So the script is triggered on every incoming message. For each contact specified within the script (i.e. the contact on ICQ, Jabber and MSN), it finds the message log for today, if there is one.

If the most recent event in the log is an incoming message less than five seconds old (so that an incoming ICQ message doesn't lead to an old outgoing Jabber message being processed), links are extracted and opened.

Before incoming URLs are opened, the OS X speech synthesizer informs you, and there is a two second pause. The idea is that you should be prepared for the browser stealing focus. On a technical note, the pause would delay the incoming message from displaying in the message log, until I put it in a detached process.

URLs are opened in your default browser. My Firefox is set to always open URLs from other applications in new tabs. If you don't have a similar setup, beware.

In the script, you can define the contacts you want to monitor. I've only specified contacts representing the same person (my girlfriend's accounts on various protocols), but I suppose it'd work with contacts from distinct persons as well. If they send you a message within five seconds of one another, though, their logs will be parsed for links twice &ndash; something that's unlikely to happen with multiple accounts belonging the same person. You could create multiple copies of the script to get around this.

Note that <code>open "http://www.theurl.com"</code> is run in the shell. There is a theoretical possibility of someone injecting commands as parts of URLs, to get your shell to execute them. Quotes are escaped, though, and only would-be URLs processed, so there should be little or no risk if you trust the friend in question.

The script (<a href="http://henrik.nyh.se/uploads/Adium%20-%20open%20incoming%20URLs.scpt">download</a>):

{% highlight applescript %}
tell app "Adium"
  set theContact to {"ICQ.123456/234567", "Jabber.me@jabber.org/them@jabber.org", "MSN.me@hotmail.com/them@hotmail.com"}
  set rubyScript to "
  SNIP
"
  set AppleScript's text item delimiters to " "
  do shell script "ruby -e " & quoted form of rubyScript & " " & (theContact as text)
end
{% endhighlight %}

where <code>SNIP</code> stands in for this Ruby code, escaped up the wazoo:

{% highlight ruby %}
require "Time"
log_path = "#{ENV['HOME']}/Library/Application Support/Adium 2.0/Users/Default/Logs";
date = Time.now.strftime("%Y-%m-%d");

ARGV.map do |friend|  # Get today's logs for contact
  Dir["#{log_path}/#{friend}/*(#{date}).html"].first 
end.compact.each do |file|  # Scan last message from each log for URLs
  last_message = File.open(file).readlines.last
  next if last_message.match(/^<div class="send"/)  # Nevermind outgoing messages
  timestamp = last_message.match(%r{<span class="timestamp">(.*?)</span>})[1]
  next if (Time.now.to_i - Time.parse(timestamp).to_i) > 5  # Nevermind old messages
  urls = last_message.scan(/<a href="(.+?)"/i)
  next if urls.empty?
  urls = urls.flatten.map {|url| '"' + url.gsub('"', '\"') + '"'}  # Avoid injections
  # Detach process, or incoming message will be delayed
  `{
  osascript -e 'say "incoming URL#{'s' if urls.size>1}"'
  sleep 2
  open #{urls.join(' ')}
  } &>/dev/null &`
end
{% endhighlight %}

<div class="updated">
<h5>Update 2007-04-20</h5>
I think this code has broken with the advent of Adium 1.0, but the basic idea should be the same.
</div>
