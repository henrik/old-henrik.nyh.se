---
title: Usability trumps security
tags:  [UI, Annoyances]
---

After complaining about it on Twitter for the third time or so, I thought I should blog about a recurring UI annoyance.

It's all too common that login forms tell you that the username *or* password is incorrect, but not which one. I love [Pivotal Tracker](https://www.pivotaltracker.com/), but they made me laugh out loud by adding a third possible source of error:

![Failed login stating "Invalid username, password, or invitation."](http://dl.dropbox.com/u/546793/blog/2011-07-16-usability-trumps-security/pivotal-login.png)

The reason usually given is security. By not revealing to an attacker whether they got the username right, they may waste their time trying to crack the password of non-existent accounts.

That's right as far as it goes, but I would argue that this is a case where usability should trump security.

As a user, it's very frustrating to repeatedly fail to log in without knowing if you're using the wrong one out of several usernames or emails, or the wrong one out of several passwords. Or the wrong invitation. If you even have an account.

[TripAdvisor](http://tripadvisor.com) gets this right:

![Failed login stating "There is no account for nonuser@example.com".](http://dl.dropbox.com/u/546793/blog/2011-07-16-usability-trumps-security/tripadvisor-login.png)

There are definitely cases where it's the user-friendly thing not to reveal if a username or email is in use. Such as on a dating site, where the user may be embarrassed or worse to be revealed as a member.

Obviously security is important. But this is [security by obscurity](http://en.wikipedia.org/wiki/Security_through_obscurity). An attacker is unlikely to try email addresses entirely at random. They will probably know or suspect that the account exists before starting out. And your site should probably not rely on the username being a secret for security.

Also, if you do insist on not telling the user, please think things through.

![Password reset form stating "Invalid username or email".](http://dl.dropbox.com/u/546793/blog/2011-07-16-usability-trumps-security/pivotal-pwreset.png)

If other pages, such as user profiles or password reset, can tell if an account exists, your page is only one request safer. Any attacker worth their [salt](http://en.wikipedia.org/wiki/Salt_\(cryptography\)) can first try that page to find an existing account, then attack your login page.

Another common and amusing miss is to be unspecific if the username is known, but specific if unknown, such as on [Flickr](http://flickr.com). Incorrect password:

![Failed login stating "Invalid ID or password."](http://dl.dropbox.com/u/546793/blog/2011-07-16-usability-trumps-security/yahoo-wrongpw.png)

Incorrect username:

![Failed login stating "This ID is not yet taken."](http://dl.dropbox.com/u/546793/blog/2011-07-16-usability-trumps-security/yahoo-wrongname.png)

I'm not saying it's objectively wrong to be vague about what credential is incorrect. But it is often user-unfriendly, and my opinion is that this is a case where usability trumps security.
