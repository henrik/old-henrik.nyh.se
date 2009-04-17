--- 
wordpress_id: 227
title: Torrent Forwarder
tags: 
- OS X
- AppleScript
---
I wrote this script a while back, but I haven't gotten around to blog it until now.

This is my set-up at home: I have a Mac Mini as <a href="http://en.wikipedia.org/wiki/Home_theater_PC">HTPC</a> and as server for various things. I also use it as my BitTorrent machine.

So the Mini handles torrent downloads. The Mini is always on because it is a web server, because it might need to record a tv show in the middle of the night etc. This is, of course, nice for downloads as well. I can put my notebook to sleep and take it with me somewhere and my downloads will be uninterrupted.

Also, most of the time I want the downloads on that machine after completion, if they're movies/shows/music. Saves me having to copy them over.

To facilitate this, I made a Folder Action script so I can click a torrent file on my notebook and have it start on the Mini. A web page showing torrent progress is also opened on my notebook.

<!--more-->

<h3>On the Mini</h3>

The Mini runs the <a href="http://www.transmissionbt.com/">Transmission</a> BitTorrent client.

In the Transmission preferences, under the "Transfers" pane, "Auto add" is activated and set to watch for torrent files in <code>~htpc/Public/Torrent drop</code>.

It also runs <a href="http://clutchbt.com/">Clutch</a>, a web interface to Transmission.

<h3>On the notebook</h3>

I wrote a Folder Action script that is attached to my <code>Downloads</code> folder. <a href="http://pastie.textmate.org/pastes/171463/download">Download the script</a> (<a href="http://pastie.textmate.org/171463">source</a>) and <a href="http://henrik.nyh.se/2007/10/lift-the-leopard-download-quarantine">attach it</a>. I've put the script in <code>~/Library/Scripts/Folder Action Scripts/Torrent Forwarder.scpt</code>.

You will need to modify the script for your setup. The script will by default scp to <code>hyper:Public/Torrent drop</code>. I can use <code>hyper</code> because <code>~/.ssh/config</code> contains

{% highlight text %}
Host hyper
  Hostname hyperion.local
  User htpc
{% endhighlight %}

There's no need to specify a password since <a href="http://www.noah.org/wiki/SSH_public_keys">SSH public key authentication</a> is used.

The script uses "http://torrent" for Clutch: I have an <code>/etc/hosts</code> entry mapping "torrent" to the IP address of the Mini, and a <a href="http://nginx.net/">nginx</a> proxy rule so I don't have to specify the port. Change the URL to whatever works for you.

I realize this is all pretty user-unfriendly. I'm sharing it as inspiration for intrepid hackers, rather than as a simple tutorial for the newbie. Nevertheless, feel free to ask if you get stuck, and I'll try to help.
