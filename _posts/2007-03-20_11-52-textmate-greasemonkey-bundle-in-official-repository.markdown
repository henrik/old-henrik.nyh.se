--- 
wordpress_id: 117
title: TextMate Greasemonkey bundle in official repository
tags: 
- Greasemonkey
- JavaScript
- OS X
- TextMate
- Firefox
---
The <a href="http://henrik.nyh.se/2007/03/major-update-to-the-textmate-greasemonkey-bundle/">Greasemonkey bundle</a> for <a href="http://macromates.com/">TextMate</a> has now been committed to the official bundle repository.

<!--more-->

See <a href="http://macromates.com/textmate/manual/bundles#getting_more_bundles">these instructions</a> for how to check out the bundle. This one is <code>Greasemonkey.tmbundle</code>.

Before committing the bundle, some small changes were made. The more interesting ones are:

<ul>
<li>"Upload to Userscripts.org…" broke because Userscripts.org switched to lighttpd which apparently has a problem with curl file uploads. Fixed.</li>
<li>The file for staple code should now be <code>~/Library/Preferences/ com.macromates.textmate.gmbundle.staples.user.js</code>, not <code>~/Library/Application Support/TextMate/Bundles/ Greasemonkey.tmbundle.staples.user.js</code>. You don't need to have such a file, but if you had one and want to keep using it, move it.</li>
<li>Collapsed the <code>log</code> snippets into a single one. <a href="http://groups.google.com/group/greasemonkey-dev/browse_thread/thread/f9d58c46e84d1f4b#msg_d73776184ff432d9">Apparently</a>, the log level only ever existed in documentation.</li>
<li>Made the template and the "Open Installed Script…" commands non-global in scope, which means their keyboard shortcuts only work when editing Greasemonkey scripts. They make more sense as app-global, but bundles shouldn't use the global space unless absolutely necessary. Just remove the scope from those commands to get rid of this limitation.</li>
</ul>

Future updates will be logged in commit messages (messages for the entire repository are available through <a href="http://macromates.com/svnlog/bundles.rss">a RSS feed</a>; I think <a href="http://subtlety.errtheblog.com/O_o/110.xml">this feed</a> should work for this bundle alone). I'll probably still blog any major or majorly cool updates, though.
