--- 
wordpress_id: 129
title: "Importing mail into (Google Apps) Gmail: some tips"
tags: 
- Gmail
---
I've moved the nyh.se e-mail to <a href="http://www.google.com/a/">Google Apps</a>.

I'm currently importing mail from my old mailbox into Gmail using the Gmail <a href="http://mail.google.com/support/bin/answer.py?ctx=%67mail&hl=en_GB&answer=21288">Mail Checker</a>. Some things I've learned:

<!--more-->

<h4>Adding a mail account with the same address</h4>

<p class="center"><img src="http://henrik.nyh.se/uploads/gmail-import.png" alt="" class="bordered" /></p>

You can't add a mail account with the same address as your Gmail address. The obvious workaround is to specify the added mail account as <code>me.other@example.com</code> rather than <code>me@example.com</code>. Since you also specify server, log-in name and password, the specified e-mail address shouldn't really matter.

<h4>Force fetch</h4>

Gmail will download mail in batches of 200. The interval between fetches can be a couple of minutes or upwards of an hour; it varies. So importing thousands of mails can take a while. I found you can force a fetch, though: just "edit info" (without actually making any changes) and save the details for the remote account.

It seems when you have somewhere around 300 mails or less remaining to import, you get a "Check mail now" link that you can use instead.

<h4>Import sent mail</h4>

It seems Google will only import your inbox (I assume that's all POP3 exposes), but if you move your sent mail into your inbox, Gmail will figure out that they should go in the Sent folder.

That's it, for now.
