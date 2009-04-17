--- 
wordpress_id: 263
title: Show Git dirty state (and branch) in the prompt
tags: 
- Shell scripting
- Git
---
I've been using <a href="http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/">this excellent hack</a> for a while to get the current git branch in my shell prompt.

That takes care of knowing what branch you're on, but I still found myself running <code>git status</code> often after <code>cd</code>:ing into a working directory, to find out if it was dirty (had uncommitted stuff). If it is, I want to handle that before starting on something else.

I hacked that in, and now my prompt looks like e.g.

{% highlight text %}
henrik@Hyperion ~/dev/blog.johannaost.com[master]$
{% endhighlight %}
when the working directory is clean, and

{% highlight text %}
henrik@Hyperion ~/dev/blog.johannaost.com[master*]$
{% endhighlight %}
when it's dirty – an asterisk is added.

Code for bash, goes into <code>~/.bashrc</code>:

{% highlight bash %}
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
export PS1='\u@\h \[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '
{% endhighlight %}

<a href="http://gist.github.com/31631">Also available as a gist</a>, if you want to fork it.

I have nearly no experience in shell scripting, so please let me know how this can be improved. For one thing, I expect it could be made more efficient by just running <code>git status</code> once and getting both branch and dirtiness from that.

Feel free to contribute versions for other shells.
