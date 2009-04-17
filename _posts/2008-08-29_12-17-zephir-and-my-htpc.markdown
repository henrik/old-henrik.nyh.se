--- 
wordpress_id: 242
title: ZephIR and my HTPC
tags: 
- OS X
- AppleScript
- Hardware
- EyeTV
---
Our <a href="http://en.wikipedia.org/wiki/Htpc"><abbr title="Home Theater PC">HTPC</abbr></a> setup mainly consists of a Mac Mini running <a href="http://elgato.com/">EyeTV</a> and a 40" tv (Fujitsu-Siemens Myrica VQ40-3SU) for a display.

As <a href="http://henrik.nyh.se/2008/04/eyetv-onoff-keyboard-button">previously blogged</a>, I've gotten rid of the EyeTV remote, using only the Apple Wireless Keyboard.

We still had the remote for the tv (display) though. But yesterday, I got the <a href="http://www.thezephir.com/ZephIR/Home.html">ZephIR IR blaster</a> I had ordered, and now we're down to just the keyboard.

<p class="center"><a href="http://www.flickr.com/photos/malesca/2805705609/"><img src="http://farm4.static.flickr.com/3213/2805705609_5025026fbc.jpg?v=0" class="bordered" alt="[Photo]" /></a></p>

This is what I did.

<!--more-->

<h4>Mounting</h4>

I put the ZephIR on the back of the tv with the included suction cup.

<p class="center"><a href="http://www.flickr.com/photos/malesca/2805704145/"><img src="http://farm4.static.flickr.com/3195/2805704145_0247289a90.jpg?v=0" class="bordered" alt="[Photo]" /></a></p>

<p class="center"><a href="http://www.flickr.com/photos/malesca/2805704485/"><img src="http://farm4.static.flickr.com/3034/2805704485_1ef61de52f.jpg?v=0" class="bordered" alt="[Photo]" /></a></p>

The IR seems strong enough that it will bounce its way to the IR eye even without line-of-sight. Having it behind the tv means you don't see it at all from the front, which was a goal.

<h4>AppleScripts</h4>

The functions I use on the tv remote are: power on/off, volume up/down (the Wii currently uses the tv speakers, though the computer has external ones) and changing input between computer (HDMI) and Wii (component/YUV).

The ZephIR software is AppleScriptable, so I made scripts for these commands. Volume up and down were just single calls. These will vary with the names you have in ZephIR, but as an example:

{% highlight applescript %}
tell application "ZephIR Station" to fire zephir command "Volume Up" of component "Fujitsu-Siemens Myrica TV"
{% endhighlight %}

Scripting against <code>ZephIR Station</code> rather than <code>ZephIR</code> means you talk directly to the faceless background app that runs the hardware, without having to start the visible ZephIR app.

If your IR commands seem slower than they should, experiment with re-recording or cutting away more. (Since undo seems broken, I close-and-save whenever I have a good state, then reopen, and just don't save if it stops working.) My "Volume Down" command was slower than "Volume Up" until I did this.

Some tvs respond to discrete codes even where the remote has a toggle: so there might be a "Power off" (not "Power on/off") command, and a "HDMI" command (not "Switch to next input"). Alas, if my tv has them, I don't know what they are. I found <a href="http://www.remotecentral.com/cgi-bin/mboard/rc-discrete/thread.cgi?4603">some codes in another format</a> that I will try to import – the ZephIR author very helpfully provided support on that.

So ZephIR only knows about "Switch to next input" right now, but I kind of faked discrete codes by having the computer store the current input, and then have a script that switches the right number of times based on that:

{% highlight applescript %}
set currentInput to readPref()

if currentInput is "YUV" then
	set n to 1 -- steps from YUV to HDMI
	writePref("HDMI")
else
	set n to 5 -- steps from HDMI to YUV
	writePref("YUV")
end if

tell application "ZephIR Station"
	repeat n times
		fire zephir command "Toggle Digital Input" of component "Fujitsu-Siemens Myrica TV"
	end repeat
end tell

-- Persisting selection

property thePref : "home.automation.tv"
property theKey : "digitalInput"

on readPref()
	try
		do shell script "defaults read " & thePref & " " & theKey
	on error
		null
	end try
end readPref

on writePref(theValue)
	do shell script "defaults write " & thePref & " " & theKey & " " & (quoted form of theValue)
end writePref
{% endhighlight %}

This works well because I plan on only ever changing the input through this script, and it never changes on its own, so I can rely on the stored value to be accurate.

I did not, however, make a similar scripts for discrete power on/off, since I sometimes turn it off on the tv set itself, sometimes it turns itself off when left without input for too long, etc. I looked into whether OS X could tell me if the tv (its display) was on, but I had no luck. I briefly considered a webcam on the power diode and some image analysis, but decided against ;)

On that subject, does anyone know if there are tvs that act like computer displays in that they sleep/wake based on activity, so you don't need to use a power button at all? I would like that in my next tv set, if tvs still exist by then.

So "Power" is just a simple script, like the volume ones. I also made a simple "Next input" script so I don't have to find the tv remote if somehow the actual input and the stored value get out of sync.

<h4>Mapping to keyboard</h4>

To make these scripts actually useful, I needed to map them to our keyboard. So I had five functions to map: power on/off, toggle HDMI/YUV, next input, volume down, volume up.

When I <a href="http://henrik.nyh.se/2008/04/eyetv-onoff-keyboard-button">made an EyeTV on/off button</a>, I mapped that to the <code>°</code> key, left of the <code>1</code> key on a Swedish keyboard. But that was more or less the only key I didn't use.

So when mapping the tv functions to the keyboard, I decided to use the function keys.

<p class="center"><img src="http://henrik.nyh.se/uploads/apple-wireless-keyboard-function-keys.jpg" class="bordered" alt="[Photo]" title="Photo stolen from AppleInsider!" /></p>

The Apple Wireless Keyboard has symbols on most function keys, providing functionality like changing display brightness and controlling iTunes. If you hold the <code>Fn</code> key while pressing them, you get actual F1, F2 etc.

If you don't use the symbol keys, OS X can be configured to provide F1 and friends without needing to press <code>Fn</code>.

Using the free <a href="http://www.red-sweater.com/fastscripts/">FastScripts Lite</a>, I mapped my old "EyeTv On/Off" script to F1 (small sun), tv "Power On/Off" to F2 (big sun), "Toggle HDMI/YUV" to F7 (rewind), "Next input" to F9 (fast forward), and volume to F11 and F12 (volume down/up). The symbols kind of fit, and I also tried to get the different functions spread a bit apart, to avoid accidental key presses.

So now, pressing <code>Fn</code> and the big sun turns on/off the tv display, and so on.

With the free <a href="http://www.abyssoft.com/software/teleport/">Teleport</a> software, I can even mouse right over to the HTPC and then hit those function keys from my own keyboard.

<h4>Making the software presentable</h4>

While I love what the ZephIR lets me do, it's not the prettiest of apps. The icon looks particularly out of place in OS X.

The ZephIR app must be running to receive AppleScript and send IR blasts. Alas, it always appears in the Dock – I would very much like an option to have it in the menu bar only, or even to have a separate ZephIR daemon that handles AppleScript/IR, with the regular app only for configuration. I plan on submitting this and other feedback to the author at some point.

<div class="updated">
<h5>Update 2008-09-04</h5>
The ZephIR creator told me there is such a daemon already. Changing the AppleScripts from <code>tell application "ZephIR"</code> to <code>tell application "ZephIR Station"</code> means no visible app needs to be running.

The code above has been changed to reflect this, so this section is no longer very relevant.
</div>

I tried hiding the app with <a href="http://forums.macosxhints.com/showthread.php?t=26703">the <code>LSUIElement</code> trick</a>, but I didn't like that – it made the app hard to find when you needed it, disabled the menu bar and made it unhideable.

So instead, I replaced the icon with a prettier one. The prettiest/most suitable icon I could think of was the one for the app <a href="http://gravityapps.com/sofacontrol/download/index.html">SofaControl</a> – so I downloaded that app and stole its icon for my personal use.

I had to open the app packages and copy the icon over, renaming it to <code>ZephIR.icns</code> – copying across from the Info windows did not work.

And that's it. I've only had the ZephIR for a day so far, but I'm very happy with being down to a single remote and the possibilities for automation.
