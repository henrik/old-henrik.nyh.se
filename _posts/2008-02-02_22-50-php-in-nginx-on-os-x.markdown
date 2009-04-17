--- 
wordpress_id: 208
title: PHP in nginx on OS X
tags: 
- OS X
- PHP
- nginx
---
I recently got myself a Mac Mini to use as HTPC and server for all things serveable.

I'm trying out the <a href="http://wiki.codemongers.com/">nginx</a> web server, but I had some trouble getting PHP working on OS X Leopard. I finally did, with lots of help from <a href="http://termos.vemod.net/">Christoffer</a>.

I roughly followed <a href="http://blog.kovyrin.net/2006/05/30/nginx-php-fastcgi-howto/">these instructions</a>, but with these differences:

I installed php with <a href="http://www.macports.org/">MacPorts</a> like so:

{% highlight text %}
sudo port install php5 +fastcgi +mysql5 
{% endhighlight %}

Obviously remove the <code>+mysql5</code> bit if you don't want MySQL; if you want MySQL to autostart, install it separately first with

{% highlight text %}
sudo port install mysql5 +server
{% endhighlight %}
and follow the instructions.

It's possible that you need to get the fcgi port before installing PHP:

{% highlight text %}
sudo port install fcgi
{% endhighlight %}

I'm not sure it's necessary – we didn't realize we should be using the <code>php-cgi</code> binary and not the <code>php</code> one until after I installed fcgi, so I didn't check if it supported fcgi even before then.

You can confirm <code>php-cgi</code> works with fcgi like so:

{% highlight text %}
$ php-cgi -m | grep fcgi
cgi-fcgi
{% endhighlight %}

The script from <a href="http://blog.kovyrin.net/2006/05/30/nginx-php-fastcgi-howto/">those instructions</a> needed some modifications. I put mine in <code>/opt/local/etc/nginx/php_fastcgi.sh</code>, by the way.

Obviously, the path to the PHP binary should be changed:

{% highlight bash %}
PHPFCGI="/opt/local/bin/php-cgi"
{% endhighlight %}

Also, the <code>su</code> line must be changed, since the BSD <code>su</code> that comes with OS X doesn't take all those flags. Instead, you can do either of these two:

{% highlight bash %}
EX="/usr/bin/su -m $USERID \"$PHPFCGI -q -b $FCGIADDR:$FCGIPORT\""
EX="/usr/bin/sudo -u $USERID $PHPFCGI -q -b \"$FCGIADDR:$FCGIPORT\"" 
{% endhighlight %}

The full shell script I use is available <a href="http://pastie.textmate.org/146715">here</a>. I should mention I'm not actually running under a "www-data" user; OS X doesn't come with one by default, unlike some Linux distributions.

Hope this helps someone.

I only just got it running, so I'm not sure yet it works well, but it <em>is</em> running.
