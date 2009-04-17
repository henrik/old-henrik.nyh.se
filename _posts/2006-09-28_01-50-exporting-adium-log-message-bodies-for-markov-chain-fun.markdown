--- 
wordpress_id: 65
title: Exporting Adium log message bodies for Markov Chain fun
tags: 
- Ruby
- OS X
- Adium
---
I stumbled across some <a href="http://www.rubyquiz.com/quiz74.html">Ruby implementations of Markov Chains</a>. From earlier experiments with <a href="http://megahal.alioth.debian.org/">MegaHAL</a>, I know they are lots of fun.

I hacked together a quick and dirty (hence no proper XML traversal) Ruby script to get the incoming message bodies from your Adium IM logs for some contact, to build Markov Chains from.

<!--more-->

Code (<a href="http://henrik.nyh.se/uploads/adiumlog2txt.rb">download</a>):

{% highlight ruby %}require "CGI"

TO_FILE = "/tmp/adium.txt"
ACCOUNT = "ICQ.4618664"
CONTACT = "1234567"
output = []

Dir["#{ENV["HOME"]}/Library/Application\ Support/Adium\ 2.0/Users/Default/Logs/#{ACCOUNT}/#{CONTACT}/*"].each do |filename|
	File.open(filename).each do |line|
		output << CGI.unescapeHTML($1).gsub(%r{</?[^>]+>}, "") if line =~ %r{<div class="receive">.*?<pre class="message">(.*?)</pre></div>}
	end
end

File.open(TO_FILE, "w") do |file|
	file.puts output.join(" ")
end{% endhighlight %}

I used the first implementation of Markov Chaining, though I made <code>until sentence.count(".") == 4</code> use <code>&gt;=</code> instead since otherwise, batches of periods (pseudo-ellipses) will cause endless loops.

Some random <a href="http://ecmanaut.blogspot.com/">ecmanaut</a> (in Swedish):

<blockquote><p>Jag tror den här. :-) Funkar turbo som den här laget; en nod som Fixar Saker, och för övrigt bikta att lära mig av föreslagna alternativ-biljetter, tippar jag. Nä. Ja.</p>

<p>Jag brukar jag aldrig kört, bara ljud med. Och "in". Troligen till ett när det verkade det såg inte så IMO. OJMR var med xpathen byter "t" mot omvärlden.</p>

<p>Jag är en mjuk word wrap. Jag ska inte orkar fixa könssegregeringen den själv. Mmmm. Mycket bra hack.</p></blockquote>
