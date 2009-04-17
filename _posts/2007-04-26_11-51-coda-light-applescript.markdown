--- 
wordpress_id: 134
title: Coda Light AppleScript
tags: 
- OS X
- TextMate
- AppleScript
---
The last few days, there has been some buzz in the macosphere about Panic's <a href="http://www.panic.com/coda/">Coda</a>. Coda basically bunches editing, web viewing, file transfer, SSH and more together in a single app, where you can open up a "site favorite" to restore all those to where you left off.

I gave it a (very short) try and found that it looks very nice, but I prefer using more powerful dedicated apps.

The idea of a macro to open up the right files in your text editor, the right session in your FTP client and so on is nice, though, so I made an AppleScript for this. I'm not sure I'll use it a lot, but once I realized it should be called "Coda Light" (("Coda" is a trademark of Panic, Inc.)), I couldn't resist.

<!--more-->

<a href="http://henrik.nyh.se/uploads/Coda%20Light.app">Download</a> the script.

Open it in <code>Script Editor.app</code> and edit the configuration values, then just run it (by e.g. double-clicking) at your pleasure.

The script will
<ul>
 <li>open the project in <a href="http://macromates.com/">TextMate</a>,</li>
 <li>open related URLs in the default browser,</li>
 <li>open the related favorite in <a href="http://www.panic.com/transmit/">Transmit</a> (FTP) and</li>
 <li>open a related SSH session in Terminal.</li>
</ul>

<h4>The code</h4>

{% highlight applescript %}
-- Coda Light
-- By Henrik Nyh <http://henrik.nyh.se>, 2007-04-26
--
-- An AppleScript to start working on a web development project by
--  * opening the project in TextMate,
--  * opening related URLs in the default browser,
--  * opening the related favorite in Transmit (FTP) and
--  * opening a related SSH session in Terminal.
--
-- Inspired by Coda <http://www.panic.com/coda/>. Coda is a trademark of Panic, Inc.

----------------------------
-- Configure here
----------------------------

-- Full path to local file, TM project or folder
set localProject to "/tmp"

-- These will be opened in the default browser
-- (Set to {} to open nothing)
set URLs to {"http://localhost/~me/somesite", "http://example.com/somesite"}

-- The name of a related Transmit favorite
-- (Set to "" if you don't want to open Transmit)
set transmitFavorite to "Some site"

-- SSH server
-- (Set to "" if you don't want a SSH session)
set sshServer to "example.com"
-- SSH username (set to "" to use defaults)
set sshUser to ""
-- The SSH password must be entered manually; optionally set up DSA keys so you don't have to input it at all: see e.g. http://www.macosxhints.com/article.php?story=20011128174701140

----------------------------
-- Configuration ends
----------------------------

if transmitFavorite is not "" then
  tell application "Transmit"
    if (count of documents) is 0 then
      make new document at end
    end if
    tell document 1
      set theTab to (session 1)
      if is connected of session 1 then
        set theTab to (add tab)
      end if
      tell theTab
        if not (connect to favorite with name transmitFavorite) then
          display dialog "Could not connect to favorite!" buttons "For shame!" default button 1 with icon 1
        end if
      end tell
    end tell
  end tell
end if


if sshServer is not "" then
  tell application "Terminal"
    if sshUser is not "" then
      set sshUser to sshUser & "@"
    end if
    do script "ssh " & sshUser & sshServer
  end tell
end if

repeat with anURL in URLs
  open location anURL -- in default browser
end repeat

if localProject is not "" then
  tell application "TextMate"
    open POSIX file localProject as alias
    activate
  end tell
end if
{% endhighlight %}
