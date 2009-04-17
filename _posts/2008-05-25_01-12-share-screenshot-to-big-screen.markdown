--- 
wordpress_id: 232
title: Share screenshot to big screen
tags: 
- OS X
- AppleScript
- Shell scripting
---
I often want to show something on my screen to my girlfriend.

The simple solution is to call her over or use the fancy OS X zooming.

The silly Saturday night hack version is this:

Make <a href="http://pastie.textmate.org/202864">a shell script</a> that
<ol>
<li>requests an interactive screen capture (mouse selection, or press space to capture an entire window),</li>
<li>sends the picture over scp to a computer connected to a big-screen tv, and</li>
<li>makes the latter computer show the picture full screen for a few seconds.</li>
</ol>

<!--more-->

I've tied the script (saved as <code>~/Library/Scripts/Share Screenshot.sh</code>) to <code>&#x21E7;&#x2325;&#x2318;4</code> using <a href="http://www.blacktree.com/">Quicksilver</a> and its Terminal Module plug-in.

In the code, modify the <code>scp</code> and <code>ssh</code> destination and the viewing duration (the <code>delay 8</code> (seconds) bit) to taste.

The <code>scp</code>/<code>ssh</code>ing adds some overhead, so there is a delay of a few seconds between taking the screenshot and seeing it on the big screen.

The full-screen display uses Quick Look. There is a command-line interface to Quick Look, but it's fairly limited, so full-screen is achieved by some AppleScript to open the Finder and trigger <code>&#x2325;&#x2318;Y</code> with the file selected. For this to work, I believe "Enable access for assistive devices" must be checked under the Universal Access preference pane. Not sure whether it is by default.

The AppleScript code with nicer formatting is <a href="http://pastie.textmate.org/202865">available here</a>.
