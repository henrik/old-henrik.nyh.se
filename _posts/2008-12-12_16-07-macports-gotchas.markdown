--- 
wordpress_id: 264
title: "MacPorts gotchas: staging ncurses, running mysql5"
tags: 
- OS X
- SQL
- Git
---
Got my computer back from repairs. I'm reinstalling most things instead of just restoring from backup, to get rid of some cruft.

Ran into some gotchas when installing from <a href="http://www.macports.org/">MacPorts</a> that I thought I'd blog here for my own future reference and for others. This stuff is on Google, but can be hard to find.

<!--more-->

<h4>Running MySQL 5</h4>

I installed MySQL 5 with

{% highlight text %}
sudo port install mysql5 +server
{% endhighlight %}

Trying to start it with <code>mysql5</code> gave the error

{% highlight text %}
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/opt/local/var/run/mysql5/mysqld.sock' (2)
{% endhighlight %}
There were a lot of mentions of this on Google, but solutions were hard to find.

What worked for me was to run

{% highlight text %}
sudo mysql_install_db5 --user=mysql
{% endhighlight %}
which I believe creates the required default databases, then start MySQL with

{% highlight text %}
sudo /opt/local/etc/LaunchDaemons/org.macports.mysql5/mysql5.wrapper start
{% endhighlight %}

<h4>Staging ncurses</h4>

I tried to install some ports (<code>git-core</code>, <code>readline</code>) that have <code>ncurses</code> as a dependency.

Installation seemed to get stuck at 

{% highlight text %}
--->  Staging ncurses into destroot
{% endhighlight %}

The issue was as <a href="http://www.nabble.com/ncurses-install-hangs-td20580633.html">described here</a>.

Fixed by running

{% highlight text %}
sudo port clean --all ncurses ncursesw
sudo port upgrade ncursesw
sudo port install ncurses
{% endhighlight %}

After that, the ports that had previously stuck now completed fine.
