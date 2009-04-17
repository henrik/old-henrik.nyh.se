--- 
wordpress_id: 173
title: MediaWiki image upload tip
tags: 
- Tips
- MediaWiki
---
I recently wanted a wiki, to collect some ideas with <a href="http://johannaost.com">my girlfriend</a>.

After trying several pieces of wiki software, I settled for <a href="http://www.mediawiki.org">MediaWiki</a>, which also powers <a href="http://wikipedia.org">Wikipedia</a>. I've found it mainly meets my needs, though I only need a small subset of its features.

One thing I don't like about MediaWiki is how convoluted it is to <a href="http://meta.wikimedia.org/wiki/Help:Images_and_other_uploaded_files">add an image to an article</a>. To wit:
<ul>
<li>Visit the <code>Special:Upload</code> page</li>
<li>Use the upload form</li>
<li>Copy the destination filename</li>
<li>Visit/create the article</li>
<li>Insert wiki markup using the copied filename</li>
<li>Save the article</li>
</ul>

A lot of steps, and in a non-intuitive order. After asking for better alternatives on <a href="irc://irc.freenode.net/mediawiki">#mediawiki</a>, I got a tip I thought I'd share. It's still convoluted, but much less so:

<ul>
<li>Visit/create the article</li>
<li>Insert wiki markup using whatever destination filename you want</li>
<li>Save (or preview) the article</li>
<li>In the saved article (or in a new tab from the previewed article), click the destination filename, which will be a red (=no such article) link</li>
<li>Use the upload form</li>
</ul>

Keep in mind that MediaWiki is particular about file extensions – if you'll be uploading a PNG, use the <code>.png</code> extension for your destination filename.
