--- 
wordpress_id: 93
title: del.icio.us Bookmarks extension and Firefox bookmark keywords
tags: 
- Firefox
---
I love the <a href="https://addons.mozilla.org/firefox/3615/">del.icio.us Bookmarks extension</a>, but it has at least one bug: though imported bookmarks with Firefox bookmark keywords keep working, a new bookmark posted with e.g. the tag <code>shortcut:foo</code> will not be triggered by the <code>foo</code> keyword.

There is a workaround, though (thanks, <a href="http://bkhl.elektrubadur.se/">Björn</a>): in the <code>View &gt; Sidebar &gt; Bookmarks</code> sidebar, find and right-click the bookmark in question. Select "Properties" from the contextual menu. Your keyword should appear in the "keyword" field. Click the "Save" button, and the keyword should start working.

I've reported this as a bug to <a href="mailto:feedback@del.icio.us">feedback@del.icio.us</a>.
