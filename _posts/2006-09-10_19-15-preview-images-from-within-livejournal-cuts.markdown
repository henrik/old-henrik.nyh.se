--- 
wordpress_id: 52
title: Preview images from within LiveJournal cuts
tags: 
- Greasemonkey
- JavaScript
- Firefox
- LiveJournal
---
<a href="http://www.livejournal.com/">LiveJournal</a> is a sort of blogging community. I don't really participate in it myself, but <a href="http://johannakatt.livejournal.com">my girlfriend does</a>.

On LiveJournal, it is common to put long posts or large/plentiful/not-worksafe images behind a "LJ-cut", which means that the cut contents are not displayed in lists of posts, but only when you open the dedicated page for that post.

<p class="center"><img src="http://henrik.nyh.se/uploads/ljcutpreview.png" alt="Screenshot" class="bordered" /></p>

Some people want pretty much everything inside cuts; others want some content outside the cut to know whether they want to see more or not. My girlfriend is in the latter camp, and so I made a Greasemonkey script for cut image previews.

<!--more-->

The script and usage instructions are over at <a href="http://userscripts.org/scripts/show/5565">userscripts.org</a>.

The script works with the LiveJournal S2 Generator layout style, and some other layout I encountered. The last time I wrote <a href="http://userscripts.org/scripts/show/3567">a complex script for LiveJournal</a>, I put some effort into making it work across layouts &ndash; and even in Opera 9. I don't want to do that now &ndash; it is Somebody Else's Problem &ndash; but I've tried to make the code easy to adjust by someone who knows their way around JavaScript and XPath expressions.

<div class="updated">
<h5>Update 2007-05-11</h5>
<p>Should now work in most layouts.</p>
</div>

LJ-cut links are identified by the <code>href</code> containing "#cutid". I think this is constant across all layouts.

When retrieving images on a dedicated post page, the contents related to a particular cut are assumed to between <code>&lt;a name="cutid<em>n</em>"&gt;&lt;/a&gt;</code> and the next such tag, or else the end of the post contents as represented by <code>&lt;hr width='100%' size='2' align='center' /&gt;</code>. This might or might not be constant across layouts &ndash; I couldn't find anything that broke the pattern, but perhaps the layout of dedicated post pages depends on the logged-in user.

The XPath expression stored in <code>xpath_cut_to_post</code> is used to find the post element (containing the post contents) relative to a cut link. This definitely varies across layouts, so it is probably the first place to look if things don't work. Finding the post element is not necessary if "Preview even if images precede cut" is toggled on.
