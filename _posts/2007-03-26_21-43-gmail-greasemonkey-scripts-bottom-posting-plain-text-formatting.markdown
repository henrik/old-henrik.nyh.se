--- 
wordpress_id: 118
title: "Gmail Greasemonkey scripts: bottom posting, plain text formatting"
tags: 
- Greasemonkey
- JavaScript
- Firefox
---
I'm trying out <a href="http://www.google.com/a">Google Apps</a> on a test domain (<code>nyh.name</code>) to see if I want to let them handle my e-mail and <abbr title="Instant Messaging">IM</abbr>.

I currently use <a href="http://www.mozilla.com/thunderbird/">Thunderbird</a>, with <a href="http://www.squirrelmail.org/">SquirrelMail</a> for web mail. Since <a href="http://mail.google.com/">Gmail</a> doesn't support <a href="http://en.wikipedia.org/wiki/Internet_Message_Access_Protocol#Advantages_over_POP3">IMAP</a>, I'd probably use their web interface most of the time, and so I've been writing Greasemonkey scripts to fix some things I'd miss from Thunderbird. I made two so far.

<!--more-->

<h4>Bottom posting in replies</h4>

I find <a href="http://mailformat.dan.info/quoting/bottom-posting.html">bottom posting</a> sensible. Gmail abstracts away <a href="http://en.wikipedia.org/wiki/Posting_styles">posting styles</a> when you're reading mail, by collapsing quotes inside mails and displaying preceding mails above the one you're reading. This is great, but what's not so great is that replying in Gmail caters to top posting, with no option to have the caret inserted after the quote. Though you barely notice the difference as a Gmail user, it's a courtesy to people with other mail clients.

The <a href="http://userscripts.org/scripts/show/8041">Gmail bottom posting in replies</a> userscript puts the caret <em>after</em> the quoted text when replying, shuffling whitespace as appropriate.

<h4>Plain text formatting</h4>

Thunderbird and some other clients support some <a href="http://kb.mozillazine.org/Thunderbird_:_FAQs_:_Viewing_Headers#Enhanced_plain_text_features">enhanced plain text features</a>, like visually bold-facing, italicizing and underlining text between two asterisks, slashes and underscores, respectively, in plain text mails.

With <a href="http://userscripts.org/scripts/show/8178">Gmail plain text formatting</a>, Gmail does this too:

<p class="center"><img src="http://henrik.nyh.se/uploads/gm-gmail-formatascii.png" alt="[Screenshot]" /></p>

Userscripting Gmail is difficult, what with it being <a href="http://www.ok-cancel.com/comic/105.html">AJAXED TO THE MAX</a>, but it's a lot of fun for the same reason.
