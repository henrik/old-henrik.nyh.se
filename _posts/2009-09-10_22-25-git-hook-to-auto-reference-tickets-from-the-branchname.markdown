---
title: Git hook to auto-reference tickets from the branchname
tags:  [Git, Git hook, Ruby]
---

It's common to put "Refs #123" or "Closes #123" in version control commit messages, and then have a server-side hook that lists the referring commits under that ticket in the ticket tracker, closing the ticket if requested.

It can be a bit of a pain to remember to reference the ticket you're working on, though.

Inspired by a discussion with [Teddy](http://teddyzetterlund.com/) at work, I just wrote a [Git hook](http://progit.org/book/ch7-3.html) to auto-reference tickets from the branchname.

Get it here: <http://gist.github.com/184711>

Installation instructions are in the file.

Use the format `t123` (or `t123-whatever`) for your topic branch names. When you are on such a branch and make a commit, the hook will append "Refs #123." to the commit message. It's clever enough to not add it if your message already contains "#123", e.g. if you've put "Closes #123" in there or a manual "Refs #123".

Because I can't stand an unclosed sentence, the hook takes care of that as it appends, turning "fix it" into "fix it. Refs #123."

If the branch name does not follow that format (e.g. in `master`), your commit message is untouched.

I chose to use the `commit-msg` hook, which runs after you've written a commit message but before the commit is made. Some would perhaps prefer to use the `prepare-commit-msg` hook, so the reference is pre-populated and can be edited as you write the rest of the commit message. That doesn't work with the custom commit dialog in [the TextMate Git bundle](http://github.com/timcharper/git-tmbundle/tree/master), though, which is what I use.

Feel free to fork and adapt to your workflow.
