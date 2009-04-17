--- 
wordpress_id: 270
title: Using the "ZNC" IRC bouncer with OS X and iPhone
tags: 
- OS X
- Colloquy
- iPhone
- IRC
---
An <a href="http://en.wikipedia.org/wiki/Bouncer_(networking)">IRC bouncer</a> is basically a proxy server that you connect to IRC through.

This offers various benefits and possibilities; the major one for me is that I appear constantly connected and will see a scrollback of missed messages when I reconnect my client. This means no more connecting in the middle of something and not having context. With iPhone IRC clients, it's especially useful, since third-party iPhone applications don't maintain their connection when you switch away from them. I can also share a single apparent IRC connection between my home computer, my work computer and my phone.

<p class="center"><img src="http://henrik.nyh.se/uploads/znc-1.png" class="bordered" alt="[Screenshot" /></p>

I wanted a bouncer that I could run off my OS X home server. I looked at a few, but they were all severely underdocumented and/or didn't work as expected. I eventually found one I liked, on the <a href="http://twitter.com/colloquyapp/statuses/1132976532">advice of @colloquyapp on Twitter</a>: <a href="http://en.znc.in/">ZNC</a>.

<!--more-->

I like about ZNC that it works well with very little fuss, and that it's fairly well documented.

<h4>Installation</h4>

I compiled from source according to the <a href="http://en.znc.in/wiki/Installation#Source_Tarball">wiki instructions</a>. You need the <a href="http://developer.apple.com/technology/xcode.html">OS X developer tools</a> or equivalent for this.

After downloading the tar file from <a href="http://sourceforge.net/project/showfiles.php?group_id=115828">this page</a>, unpacking it and changing into that directory, I did

{% highlight bash %}
./configure --prefix=/usr/local
make
sudo make install
{% endhighlight %}
Ensure <code>/usr/local/bin</code> is in your <code>PATH</code>. There's no need to mess with <code>--with-openssl</code>; OS X has that covered.

With those settings, it compiled without a hitch for me.

<h4>Configuration</h4>

Run <code>znc --makeconf</code> from the command line to interactively create a configuration file. Later, you can modify it by hand (it'll be somewhere like <code>~/.znc/configs/znc.conf</code>), or even from IRC (<code>/msg *status help</code>).

The README that came with the source, and the <a href="http://en.znc.in/wiki/ZNC">ZNC wiki</a>, do a pretty good job of explaining the options. Some things that may not be obvious: "y" or "n" is enough when answering the "yes"/"no" setup questions, or just hit Return to go with the default. After setting the port, don't forget to forward it in your router or firewall. You should activate SSL for encryption; it's no hassle. The hostname of your shell is what you'll connect to from the outside, e.g. "myhomeserver.com". 

I didn't activate any global modules.

"Number of lines to buffer per channel" means that each time you connect, you'll see that many lines of channel log from just before you connected. The default is plenty; I've turned it down to 30. Answering "yes" to "Would you like to keep buffers after replay?" will mean that if you connect from your computer and get to see what you missed, connecting later from your iPhone will show those same messages (no matter that they're already been replayed). That means you are likely to see the same stuff several times, but also that you will always have context. I answered "yes".

As for user modules, I went with: <code>chansaver</code>, so ZNC remembers what channels I join and part; <code>keepnick</code>, to keep trying for my primary nick; <code>nickserv</code> to auth me with NickServ; <code>away</code> to set me away when I detach (disconnect my clients) and save private messages, I think (documentation is unclear); <code>awaynick</code> to change my nick when I go away, to make it more obvious I'm not present. See the <a href="http://en.znc.in/wiki/Category:Modules">wiki</a> for more information on modules.

If you add channels for ZNC to join automatically, don't forget the initial "#"; it's required.

<h4>Launching</h4>

It's very easy to make sure ZNC keeps running, e.g. if you reboot your server or ZNC crashes (it hasn't for me, so far). The wiki <a href="http://en.znc.in/wiki/FAQ#How_can_I_restart_ZNC_automatically_.28in_case_of_a_machine_reboot.2C_crash.2C_etc..29.3F">describes</a> that you can just set up a cron job; if ZNC is already running with a given config, starting it again will have no effect.

I went with <a href="http://en.wikipedia.org/wiki/Launchd">launchd</a> instead of cron. <a href="http://gist.github.com/65346">This .plist</a> will launch ZNC when OS X starts, as well as every 5 minutes (and after waking from sleep, if 5 minutes passed during that time). launchd has facilities for keeping an application always running, but that has some complications (pidfile management); starting every 5 minutes is good enough for me.

You can load my launchd task with these commands:

{% highlight bash %}
cd ~/Library/LaunchAgents
curl http://gist.github.com/raw/65346/52d07bd7566720fa965d7bd359b0ca27e0e30f01/name.henriknyh.znc.plist > name.henriknyh.znc.plist
launchctl load name.henriknyh.znc.plist 
{% endhighlight %}

This will also start ZNC at that time if it isn't already running.

<h4>Connecting</h4>

When you're all done, connect your IRC client to the bouncer on the hostname and port you configured, e.g. "myhomeserver.com:7777". When you connect to the bouncer, the configured username and password should be put in the server password field (yes, <em>server</em> password field) separated by a colon, like: <code>myusername:mypassword</code>.

And that should be it. When you're done chatting, quit your IRC client; don't actually part room by room, since that will part the bouncer from them as well. When you reconnect, the bouncer will let you know what you missed.

I'm using this successfully with <a href="http://limechat.net/mac/">LimeChat</a> for full-size Macs and <a href="http://colloquy.info/mobile/">Mobile Colloquy</a> on the iPhone.
