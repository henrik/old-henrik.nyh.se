--- 
wordpress_id: 136
title: "\"Premature end of script headers\" for CGI can be directory permissions"
tags: 
- Ruby
---
Thought I'd write this up for googlability and my own future reference:

Other than the reasons <a href="http://httpd.apache.org/docs/1.3/misc/FAQ-F.html#premature-script-headers">outlined in the Apache FAQ</a>, the error log message "Premature end of script headers" for a CGI script (in my case a Ruby script on Dreamhost) can also mean that <em>the directory containing the script</em> is world-writable.

So folder permissions like <code>drwxr-xr<strong>w</strong>x</code> can cause this error. <code>chmod 755 mydir</code> would change those permissions to <code>drwxr-xr-x</code> and all is well.

I suppose Apache/suEXEC takes issue with running stuff that any evil user can edit.
