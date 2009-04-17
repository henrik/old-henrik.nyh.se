--- 
wordpress_id: 156
title: TextMate command to close all HTML output windows
tags: 
- OS X
- TextMate
- AppleScript
---
I wrote a TextMate command to close all HTML output windows: <a href="http://henrik.nyh.se/uploads/Close%20All%20HTML%20Output%20Windows.tmCommand">Close All HTML Output Windows.tmCommand</a>. This is very useful, at least to me, when developing some TextMate commands – one can end up with tons of such windows.

<!--more-->

The command is a shell script that wraps this piece of AppleScript:

{% highlight applescript %}
set closedCount to 0
tell application "System Events"
  
  if not UI elements enabled then
    try
      tell application "TextMate" to set answer to button returned of (display dialog "This command relies on the GUI scripting architecture of Mac OS X which is currently disabled." & return & return & "You can activate it by selecting the checkbox \"Enable access for assistive devices\" in the Universal Access preference pane." buttons {"OK"} default button 1 with icon 1)
    on error number -128
      -- User cancelled
    end try
    return
  end if
  
  tell process "TextMate"
    repeat with i from (count windows) to 1 by -1 -- iterate backwards so indices don't shift on close
      try
        tell the first UI element of the first scroll area of window i
          if role is "AxWebArea" then
            tell application "TextMate" to close window i
            set closedCount to closedCount + 1
          end if
        end tell
      end try
    end repeat
  end tell

end tell

-- FIXME: This count is sometimes the expected value + 1 -- why?
if closedCount is 0
  return "No HTML output windows to close."
else if closedCount is 1
  return "Closed 1 HTML output window."
else 
  return "Closed "&closedCount&" HTML output windows."
end if
{% endhighlight %}

It was a bit tricky to actually close the window. To use the GUI scripting (to detect <code>AxWebArea</code>s), one apparently has to talk to the app as a System Events process – which seems to disallow anything like <code>close theWindow</code>. So I loop over the windows by index, doing GUI scripting by window index in process land and closing windows by index in <code>tell application</code> land. I loop backwards since closing a window shifts higher indices down.

As a comment in the code mentions, there is an occasional off-by-one bug in the "Closed 123 HTML output windows" tooltip message. Not a big deal, really. Another issue is that any HTML output window that has not completed will prompt on whether to stop its task, and the tooltip will appear even though there might still be windows-with-prompts around.
