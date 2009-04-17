--- 
wordpress_id: 228
title: EyeTV on/off keyboard button
tags: 
- OS X
- AppleScript
- EyeTV
---
I have a <a href="http://en.wikipedia.org/wiki/Home_theater_PC">HTPC</a> setup with <a href="http://elgato.com/">EyeTV</a> on a Mac Mini.

We use the <a href="http://www.apple.com/keyboard/">Apple Wireless Keyboard</a> as a remote. The bundled EyeTV remote is a bit mushy, slow to use for some tasks (that can easily be triggered by keyboard shortcuts), and is also bound by the limitations of IR (e.g. line-of-sight).

One thing I miss from the remote is the on/off button. Though EyeTV on the Mini is great in many ways, watching tv is a lot more complicated than it should be – especially starting to watch tv. The on/off button on the remote helps: as long as EyeTV is running (possibly without any windows open), the button will open a live tv window, or close it if already open. The shortcomings are that this doesn't work if EyeTV is not running, and that the live tv window does not open in full screen. And, of course, that you need to use the remote.

My solution was to code up an improved EyeTV on/off button for the keyboard.

<!--more-->

<h4>Functionality</h4>

The script I wrote does this when run:

If EyeTV has a tv window (live tv or a recording) open in full screen, all tv windows are closed. The EyeTV app is still running, so recordings keep recording.

If EyeTV has a tv window open but not in full screen, it is made full screen. If it was paused, it will resume playing.

If there was no tv window open, or EyeTV itself was not running, a live tv window is opened full screen.

Any iTunes playback is paused.

<h4>Installation</h4>

<a href="http://pastie.textmate.org/pastes/183413/download">Download the script</a> (<a href="http://pastie.textmate.org/pastes/183413">source</a>) as <code>~/Library/Scripts/EyeTV Toggle.scpt</code>, creating the <code>Scripts</code> directory if necessary.

I wanted a single key as a trigger, rather than a modifier/key combination, for simplicity. I chose the <code>°</code> key, which on a Swedish keyboard is to the left of <code>1</code> – I had that key to spare, and it's fairly conveniently placed. I'm not sure what would be a good key on an English layout keyboard. I originally wanted to use the Eject key, but research suggests it would be painful, if at all possible.

To bind the script to a single key, I used the free <a href="http://www.red-sweater.com/fastscripts/">FastScripts Lite</a> (see the bottom of that page for Lite).

This functionality is a big improvement, but the setup is still rather guest-unfriendly: you need to turn on the tv set itself with a separate remote, and figure out how to use the keyboard, at the risk of triggering unrelated software on the Mini (e.g. iTunes with the keyboard's media keys). I would love to fix this at some point, perhaps with a <a href="http://www.filewell.com/iRed/">scriptable IR blaster</a>, an iPod Touch and some hacking. I'd be very interested to hear how/if other people have made their EyeTV setups more spouse-/child-/guest-friendly.
