--- 
wordpress_id: 162
title: Trac autologin Greasemonkey script
tags: 
- Greasemonkey
- JavaScript
- Firefox
---
I hate how <a href="http://trac.edgewall.org/">Tracs</a> never seem to remember your authorization. I usually need Trac <em>right now</em> for some new-sprung idea or a just-encountered bug, and having to log in again and again is a big bother.

To make this less annoying, I wrote <a href="http://userscripts.org/scripts/show/10456">a Trac autologin Greasemonkey script</a>. The script works on <a href="http://trac-hacks.org/wiki/AccountManagerPlugin">Account Manager</a> type logins (which covers e.g. <a href="http://devjavu.com/">DevjaVu</a> and <a href="http://dev.rubyonrails.org/">Rails Trac</a>) and does this:

When you arrive at a Trac site, you're sent to the log-in page. If Firefox has pre-populated the log-in form with a username and password, you're logged in automatically and sent back whence you came. If the log-in form was <em>not</em> pre-populated, you're presumed not to have an account and are just sent back.

If you explicitly log out by clicking the "Logout" link (i.e. you presumably don't care to be logged in automatically for a while), or if you were assumed not to have an account, then the script won't try to log you in automatically again until you restart your browser or visit the login page manually.

Obviously, if you're running your own Trac installation, it's better to just tweak that to keep session cookies around longer (and possibly remove expirations on the server side – I haven't really looked into it).
