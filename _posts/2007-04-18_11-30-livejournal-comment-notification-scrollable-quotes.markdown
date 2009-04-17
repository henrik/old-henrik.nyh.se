--- 
wordpress_id: 131
title: LiveJournal comment notification scrollable quotes
tags: 
- LiveJournal
- CSS
- Userstyles
- Gmail
---
In <a href="http://henrik.nyh.se/2006/08/fixed-size-scrollable-quotes-in-livejournal-comment-notification-mails">a previous post</a>, I mentioned how to add scrollbars to quotes in LiveJournal comment notifications, in SquirrelMail or Thunderbird.

<p class="center">
<img src="http://henrik.nyh.se/uploads/USsmlj.png" alt="" class="bordered" />
</p>

I've now deprecated the userscript in favor of a <a href="http://userstyles.org/stylish/">Stylish userstyle</a>: <a href="http://userstyles.org/style/show/2232">LiveJournal comment notification scrollable quotes</a>.

The userstyle works in SquirrelMail, Gmail and any other e-mail client that preserves the notification mail HTML.

<!--more-->

It's basically the same CSS as in the Thunderbird solution in <a href="http://henrik.nyh.se/2006/08/fixed-size-scrollable-quotes-in-livejournal-comment-notification-mails">the earlier post</a>, but made less likely to overgenerate. Feel free to update your Thunderbird with this CSS:

{% highlight css %}
table + blockquote[style="border-left: 2px solid rgb(0, 0, 64); margin-left: 0px; margin-right: 0px; padding-left: 15px; padding-right: 0px;"] {
  overflow:auto;
  max-height:70px;
}
{% endhighlight %}
