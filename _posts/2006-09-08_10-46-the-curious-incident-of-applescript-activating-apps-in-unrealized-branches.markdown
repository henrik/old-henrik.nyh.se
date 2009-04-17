--- 
wordpress_id: 50
title: The curious incident of AppleScript activating apps in unrealized branches
tags: 
- OS X
- AppleScript
---
I ran into a very confusing and annoying AppleScript issue.

If you talk to an application in some unrealized branch of an uncompiled script, that app will still be activated the first time the script is run. A very simple test case:

{% highlight applescript %}if false then tell application "Dictionary" to display dialog "Cornholio!"{% endhighlight %}

Even though the if-condition is certainly not true, Dictionary will open, though it won't display the dialog.

I asked about this on <a href="irc://irc.freenode.net/macdev">#macdev</a> and it turns out that uncompiled scripts compile the first time they are run, and to do this they must open all involved applications to retrieve their AppleScript dictionaries.

Thus, a solution is to simply pre-compile the script, when possible.
