--- 
wordpress_id: 132
title: Fix Your Last Input plugin for Adium
tags: 
- OS X
- Cocoa
- Adium
---
Programmers like to correct their own chat typos with faux Perl type regular expression substitutions, like

{% highlight text %}
<i>12:34</i> <b>Me:</b> Hello. I'm making a tpyo.
<i>12:35</i> <b>Me:</b> s/tpyo/typo/
{% endhighlight %}

There is a very cool plug-in for the <a href="http://colloquy.info">Colloquy</a> IRC client, <a href="http://colloquy.info/extras/details.php?file=50">Fix Your Last Input (Regex)</a>, that causes input like the above to actually end up as

{% highlight text %}
<i>12:34</i> <b>Me:</b> Hello. I'm making a tpyo.
<i>12:35</i> <b>Me:</b> (s/tpyo/typo/) correction: Hello. I'm making a typo.
{% endhighlight %}

I wanted a plugin like this for the <a href="http://www.adiumx.com/">Adium</a> IM client as well, so I made one.

<p class="center">
<img src="http://henrik.nyh.se/uploads/fixyourlastinput.png" alt="" />
</p>

<!--more-->

Download plugin: <a href="http://henrik.nyh.se/uploads/FixYourLastInput.AdiumPlugin.zip">Fix Your Last Input</a> (<a href="http://svn.nyh.se/cocoa/FixYourLastInputPlugin/">SVN source</a>).

To install the plugin: download, unzip and drag it to the Adium icon in the Dock. You will be prompted to install it and asked to restart Adium.

Just send <code>s/find/replace/flags</code> to correct your previous message. The plugin uses Perl behind the scenes, so you should be able to do most anything Perl substitutions do.

I spent some time in encoding hell. After many efforts, the plugin doesn't mess up non-ASCII characters, but it doesn't recognize them in the find part. So <code>s/ä/a/g</code> won't transform "foobär", but <code>s/o/ö/g</code> will turn it into "fööbär". Patches to make it Unicode friendly all the way are welcome.

I'm not sure about the name – I'd say it fixes your last <em>output</em> – but I wanted it to match the name of the Colloquy plugin.
