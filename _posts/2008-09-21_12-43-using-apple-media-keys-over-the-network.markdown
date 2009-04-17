--- 
wordpress_id: 247
title: Using Apple media keys over the network
tags: 
- OS X
- AppleScript
---
We use a networked Mac Mini as media center, and usually play iTunes music off it, since it's hooked up to decent speakers.

If I'm using my own computer, controlling iTunes or changing volume on the Mini means I either have to physically walk over to it, or use Screen Sharing, or move my mouse over using <a href="http://www.abyssoft.com/software/teleport/">Teleport</a>.

The latter requires the Mini's screen (our tv) to be on, and to make things more bothersome, even though Teleport will send most keypresses to the Mini, the media keys (dedicated keyboard keys for back, play/pause, forward, mute, volume down and volume up) still control my own computer.

My solution was to write some scripts to do these things over the network, then bind them to <code>F7</code>, <code>F8</code> etc. So e.g. pressing <code>Fn</code>+Play/pause (which amounts to <code>F8</code>) will play or pause on the remote computer.

I also used ControlMaster SSH settings to speed up the network action.

<!--more-->

<h4>The scripts</h4>

These are shell scripts that have been made executable (<code>chmod +x filename.sh</code>). I keep them in <code>~/Library/Scripts/HyperControl</code>. They use <code>ssh</code> to run AppleScript on the remote computer.

<code>hyper</code> is my SSH alias for the Mac Mini. My <code>~/.ssh/config</code> file contains something like

{% highlight text %}
Host hyper
  Hostname hyperion.local
  User mini
{% endhighlight %}
and I <a href="http://sial.org/howto/openssh/publickey-auth/">log in by public key</a>.

<h5>back.sh</h5>

{% highlight bash %}
#!/bin/bash
ssh hyper "osascript -e 'tell app \"iTunes\" to back track'"
{% endhighlight %}

<h5>playpause.sh</h5>

{% highlight bash %}
#!/bin/bash
ssh hyper "osascript -e 'tell app \"iTunes\" to playpause'"
{% endhighlight %}

<h5>next.sh</h5>

{% highlight bash %}
#!/bin/bash
ssh hyper "osascript -e 'tell app \"iTunes\" to next track'"
{% endhighlight %}

<h5>mute.sh</h5>

{% highlight bash %}
#!/bin/bash
ssh hyper "osascript -e 'set volume output muted not (output muted of (get volume settings))'"
{% endhighlight %}

<h5>volume_down.sh</h5>

{% highlight bash %}
#!/bin/bash
ssh hyper "osascript -e 'set volume output volume (output volume of (get volume settings) - 7)'"
{% endhighlight %}

<h5>volume_up.sh</h5>

{% highlight bash %}
#!/bin/bash
ssh hyper "osascript -e 'set volume output volume (output volume of (get volume settings) + 7)'"
{% endhighlight %}

Note that changing the volume this way does not give any feedback other than, of course, the volume changing. You will not see a volume indicator on the screen, and you will not hear the volume example sounds.

<h4>Binding them</h4>

To bind these scripts to keyboard keys, I use <a href="http://www.blacktree.com/">Quicksilver</a>. I'm sure you could use something else like <a href="http://www.red-sweater.com/fastscripts/">FastScripts Lite</a> if you prefer.

 If you use Quicksilver, you need to do a couple of things.

First, you need to install the Terminal module (in the Plug-ins tab) to be able to run shell scripts from Quicksilver.

Then, the scripts need to be indexed by Quicksilver. You can add the script folder in the Catalog tab, make sure it's set to include the folder contents, then hit the rescan button (circular arrow at the bottom) to index them.

And now for the mapping proper. Go to the Triggers tab and add the scripts as HotKey triggers. "Select an Item" should be the script, and the "Action" should be "Run (Run a Shell Script)". Hit "Save", then set the key in the info drawer. Quicksilver will show the F-keys as a blank value in the shortcut column; triggers with no shortcut get "None", though.

You can even set Quicksilver to repeatedly run the script, e.g. every 0.5 seconds, if the key is kept down.

<h4>ControlMaster for faster SSH</h4>

Now you should be able to run the scripts by using <code>Fn</code> plus the media keys.

Even in a local network, though, opening up a new SSH connection for every command can be a little slow.

Turns out you can <a href="http://www.cyberciti.biz/faq/linux-unix-reuse-openssh-connection/">use ControlMaster settings to reuse SSH connections</a>. Basically, if you already have a SSH connection open to a machine, making another connection will be faster. But if you disconnect the first connection and then make another connection, there is no speedup.

The scripts above make a connection, run some AppleScript and then drop the connection, so there's no speedup there even if ControlMaster is activated.

My solution is to make my computer establish a master connection to the Mini when it's started. These scripts can then reuse that, and it will also speed up other SSH connections I make to that machine.

I use launchd to run code when my computer starts. This is <code>~/Library/LaunchAgents/name.henriknyh.controlmaster.plist</code>:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>name.henriknyh.controlmaster</string>
    <key>ProgramArguments</key>
    <array>
        <string>/opt/local/bin/ssh</string>
        <string>-MN</string>
        <string>hyper</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/dev/null</string>
    <key>StandardErrorPath</key>
    <string>/dev/null</string>
</dict>
</plist>
{% endhighlight %}

I needed to specify the full path to <code>ssh</code>, otherwise I saw issues. This is probably because my <code>ssh</code> is custom from <a href="http://www.macports.org/">MacPorts</a>.

The <code>M</code> flag is master mode for connection sharing. The <code>N</code> flag means to send no commands, only connect.

To load this into launchd, run

{% highlight text %}
launchctl load name.henriknyh.controlmaster.plist
{% endhighlight %}
from that directory (otherwise specify the full path). Then run

{% highlight text %}
launchctl start name.henriknyh.controlmaster
{% endhighlight %}
to start it immediately, without waiting for next boot.

And that's it. Pretty complicated, but very useful, and easy to use once it's set up.
