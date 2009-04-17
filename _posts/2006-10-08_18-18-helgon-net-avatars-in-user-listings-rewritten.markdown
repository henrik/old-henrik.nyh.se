--- 
wordpress_id: 67
title: "\"Helgon.net avatars in user listings\" rewritten"
tags: 
- Greasemonkey
- JavaScript
- Firefox
---
I rewrote my <a href="http://userscripts.org/scripts/show/1563">Helgon.net avatars in user listings</a> userscript entirely.

<!--more-->

To the uncaring end-user, the difference is probably just increased speed (due to decreased traffic) and possibly decreased fragility (due to better code). Oh, and also that it works &ndash; I believe some <a href="http://www.helgon.net">Helgon.net</a> changes made the previous version occasionally freeze Firefox of late.

Under the hood, things are a lot more maintainable and a lot less embarrassing.

Cached data is now stored as a serialized hash in a single <code>GM_get/setValue</code> slot, rather than in one slot each. This might improve Firefox's load time.

Previously, only valid avatars were stored, and the script didn't learn not to re-attempt to find avatars for users who had none, or who had default (uninteresting) avatars. The rewritten script will cache a timestamp in place of an URL for those dull souls, and will only re-attempt to find an avatar for them after some time has passed (by default, six hours).

This obviously reduces traffic quite a bit, which means increased speed and a happier Helgon.net crew (who, by the way, allegedly have an un-enforceable blanket ban on "scripts", which seems to also include client-side CSS modifications &ndash; <a href="http://www.helgon.net/Forum2/display_mess.asp?mid=5193328&fid=79&VD=2&tid=383235">read and weep</a>, if you have a session).

A final major change is that instead of making a HTTP HEAD request for each cached avatar upon retrieval to check that it hasn't been removed or replaced, re-retrieval is now triggered by the <code>error</code> event on the avatar image object.
