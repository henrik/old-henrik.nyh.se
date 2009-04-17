--- 
wordpress_id: 44
title: Fixed-size scrollable quotes in LiveJournal comment notification mails
tags: 
- Greasemonkey
- JavaScript
- Firefox
- Thunderbird
- LiveJournal
---
Though not a new hack, I thought I should blog this as it (well, the Thunderbird part) is hidden away in a <a href="http://userscripts.org/">userscripts.org</a> comment.

When people reply to your <a href="http://www.livejournal.com/">LiveJournal</a> posts or comments, you can receive e-mail notifications. It's lovely that these notifications quote whatever post or comment they are in reply to, but especially for comments on long posts with loads of images, things can get very scrolly and jumpy.

I wrote a <a href="http://userscripts.org/scripts/show/1562">Greasemonkey script</a> to tuck the quote away in a small, fixed-size scrollable box when using the <a href="http://www.squirrelmail.org/">SquirrelMail</a> web mail client.

I later realized this could be done in Thunderbird, too. It's simply a matter of changing your <a href="http://www.mozilla.org/support/thunderbird/edit#content">userContent.css</a> to include e.g.

{% highlight css %}table + blockquote {
  overflow:auto;
  max-height:70px;
}{% endhighlight %}Obviously this has some risk of overgenerating, but I have never received any other mail with blockquotes after tables.

<div class="updated">
<h5>Update 2007-04-18</h5>
<a href="http://henrik.nyh.se/2007/04/livejournal-comment-notification-scrollable-quotes">This CSS has been improved upon.</a>
</div>
