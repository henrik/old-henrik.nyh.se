--- 
wordpress_id: 28
title: "World of Warcraft Europe auto-fill parental controls password "
tags: 
- Greasemonkey
- JavaScript
- Firefox
---
Probably my most niche script to date. :)

My younger brother would play too much World of Warcraft if we let him. Parental controls can be set through a web interface, but require a parental password to be input every time you modify them. This gets annoying fast, so I automated it.

<!--more-->

I wrote a <a href="http://userscripts.org/scripts/show/5099">Greasemonkey script</a> that inputs the password automatically. If combined with my <a href="http://userscripts.org/scripts/show/1595">autologin script</a> for the account log-in (not the same as the parental password), changing settings is now just a matter of inputing the bookmark keyword, changing stuff and submitting the changes.

I love it when things are reduced to the manual minimum.

In this case, I do need to manually express my intention of making changes to these specific settings, I do need to state what those changes are (at least in my case, as changes are unpredictable), and I do need to confirm that they have been made and should be committed (could be done automatically after a time-out, but would likely annoy).

Authenticating (as account holder and then as parental controller) is redundant, as that information can be automatically derived from the fact that I (my browser environment) initiated it.

Obviously this is less secure than doing it manually, but it should work fine as long as the parental controllee does not have access to the web environment (nor the computer, ideally) of the controller. That is true in my case. I didn't really intend to share this script, but I suppose it might be of help to someone.
