--- 
wordpress_id: 260
title: "AtomICA: ICA-banken RSS feed"
tags: 
- Ruby
- RSS
---
My bank is Swedish <a href="http://www.icabanken.se">ICA-banken</a> (or "ICA banken", as they would have it - it's a Swedish grammar vs. marketing thing).

They're a fairly modern bank – even have an <a href="http://iphone.icabanken.se/">iPhone version</a>.

They do not offer a RSS feed of account activity, though. I really wanted this: account activity in your feed reader means you can easily keep on top of where your money goes, when you get your salary and when you get paid for that eBay item.

I suggested to the bank that they add it, but they didn't want to, so I made it myself.

<p class="center"><img src="http://henrik.nyh.se/uploads/atomica.png" class="bordered" alt="[Screenshot]" /></p>

<!--more-->

(The account numbers and balances in the screenshot are fake.)

I realize it will only be of use to customers of ICA-banken, but I thought I'd still share it for those few, and as inspirations for others. It should be fairly easy to adapt to any bank that offers read access without a hardware token or similar.

For your own privacy (since you shouldn't give your password to strangers), I don't offer a hosted version, but if you know your way around CGI scripts, set it up yourself: <a href="http://github.com/henrik/atomica">http://github.com/henrik/atomica</a>

It's actually an Atom feed, not RSS, but any modern feed reader won't care.

Alas, I believe Google Reader still doesn't support HTTP authentication in feeds. Most desktop readers do, as does the online <a href="http://beta.bloglines.com/">Bloglines</a> (and it doesn't share authenticated feeds publicly, of course).

Also see my <a href="http://userscripts.org/scripts/show/1711">ICA-banken autologin Greasemonkey script</a>.
