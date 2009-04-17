--- 
wordpress_id: 220
title: Map right-side Option to Enter in OS X
tags: 
- OS X
---
In OS X, the Enter (⌅) key does not always do the same thing as Return (↩): when editing text in Photoshop, Return breaks lines and Enter commits the changes.

<a href="http://www.adiumx.com/">Adium</a> and <a href="http://colloquy.info/">Colloquy</a> can be set up much the same way: Return breaks lines, Enter sends. <a href="http://macromates.com">TextMate</a> makes good use of Enter in its commands.

For a while up until recently, Apple keyboards without a separate numerical keypad still had a dedicated Enter key. It has since been replaced with a right-side Option key. While this was probably a change for the better to most users, some users have gotten used to the Enter key and miss it. While you can still produce Enter with Fn+Return, this is not nearly as convenient.

I looked into other solutions but had the same experience as <a href="http://paddymullen.com/?p=18">this blogger</a> – the only thing that really works is some C. So here is some:

<!--more-->

Put the <a href="http://henrik.nyh.se/uploads/opt2enter">opt2enter</a> binary in <code>/usr/local/bin</code>.

To make sure the binary is always running in the background, put <a href="http://henrik.nyh.se/uploads/name.henriknyh.opt2enter.plist">name.henriknyh.opt2enter.plist</a> in <code>/Library/LaunchDaemons</code> and run this command in a Terminal:

{% highlight text %}
sudo launchctl load -w /Library/LaunchDaemons/name.henriknyh.opt2enter.plist
{% endhighlight %}

<a href="http://pastie.textmate.org/166276">The source code</a> is available. I'm not really a C programmer, and not very familiar with these libraries. Don't hesitate to give suggestions on improvements to the code, functional as well as aesthetic.

The application is intended to be a Universal Binary. I'm not sure whether any PPC Macs have right-side Option keys, but they can of course be used with the Apple Wireless Keyboard that does. Let me know if you try this on a PPC and it works or not. I don't have one to try on.

There is a half-broken bonus feature: Enter is only sent if you press no other key at the same time; otherwise it still sends Option. So you can still e.g. use right-Option plus "." for ellipsis. This is half-broken because you'll get a line break too, after you hit Option but before you hit "."

There are various other minor limitations. Probably nothing you'll run into, but see the <a href="http://pastie.textmate.org/166276">source code</a> TODOs. And again, don't hesitate to give suggestions on how to fix these.
