--- 
wordpress_id: 272
title: git reset --soft as stash replacement and undo
tags: 
- Git
---
With <a href="http://git-scm.com/">Git</a>, if you have some work in progress and find you need to switch to another incompatible branch, you can <code>git stash</code> the changes and later restore them with <code>git stash pop</code>.

However, I dislike having to remember I have something stashed. It's easy to forget. (Idea: make the shell prompt indicate stash.) Instead, when I have work in progress, I just commit it as usual, with something like "WiP" as the message:

{% highlight bash %}
git commit -a -m "WiP"
{% endhighlight %}

When I get back to a branch, find that the last commit is "WiP" and want to restore my previous state, I do

{% highlight bash %}
git reset --soft HEAD^
{% endhighlight %}
This will leave the working tree in the WiP state, but roll back the current HEAD one commit, as though you never made that commit.

Just remember not to share the branch with a WiP commit or someone else may build upon it and object when you rewrite history.

More generally, <code>git reset --soft HEAD^</code> is great for undoing non-pushed commits. If I realize I committed a file I shouldn't have, I do a soft reset and then redo the commit properly. It can be easier than amending or interactively rebasing.
