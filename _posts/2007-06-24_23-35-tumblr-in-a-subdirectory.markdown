--- 
wordpress_id: 154
title: Tumblr in a subdirectory
tags: 
- PHP
---
I now have <a href="http://henrik.nyh.se/tumble/">a tumblelog</a>, powered by <a href="http://www.tumblr.com/">Tumblr</a>.

Tumblr seems quite awesome – simple and powerful, just the way I like it. They even offer <a href="http://www.tumblr.com/faqs#custom_domains">Tumblr on your own (sub)domain</a> if you can configure your DNS A records.

I didn't want to use a subdomain, though. My site is on a subdomain already, and sub-subdomains look silly. I don't like using subdomains directly under <code>nyh.se</code> for personal stuff since it's not namespaced (I considered <code>svnrik.nyh.se</code> before going with <code>svn.nyh.se</code> for my SVN repository…). Anyway, since Tumblr don't offer this, I threw together a tiny proxy.

<!--more-->

Over at <a href="http://henrik.nyh.se/tumble">http://henrik.nyh.se/tumble</a>, this is my <code>.htaccess</code>:

{% highlight text %}
 RewriteEngine On
RewriteBase /tumble

RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^(.*)$  proxy.php?url=http://malesca.tumblr.com/$1 


{% endhighlight %}

and this is <a href="http://henrik.nyh.se/uploads/proxy.phps"><code>proxy.php</code></a>:

{% highlight php %}
<?php 

$from = "malesca.tumblr.com";
$unto = "henrik.nyh.se/tumble";

// Because Dreamhost doesn't do remote fopens, and to get content-type
function fetch($url) {
	$curl = curl_init();
	$timeout = 5; // set to zero for no timeout
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, $timeout);
	curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1);
        $html = curl_exec($curl);
	$content_type = curl_getinfo($curl, CURLINFO_CONTENT_TYPE);
	curl_close($curl);
	return array($html, $content_type);
}

list($html, $content_type) = fetch($_GET['url']);

// Fix root-relative links etc.
$html = preg_replace('/\b(href|src|rel)="\//', '$1="http://'.$unto.'/', $html);
// Replace the old URL with the new
$html = str_replace($from, $unto, $html);

header("Content-type: $content_type");
echo $html;

?>
{% endhighlight %}

This piece of code just mirrors the content as well as the content-type of anything on <a href="http://malesca.tumblr.com">http://malesca.tumblr.com</a> to <a href="http://henrik.nyh.se/tumble">http://henrik.nyh.se/tumble</a>. Fixes links in the RSS feed as well. Pretty neat.

You obviously need a PHP with <a href="http://php.net/curl">libcurl</a>.

You'll likely want to change the <code>$from</code> and <code>$unto</code> values at the top, as well as the URL in the <code>.htaccess</code> rewrite rule.
