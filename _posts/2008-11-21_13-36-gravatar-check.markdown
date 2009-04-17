--- 
wordpress_id: 257
title: Check if gravatar exists for email in Ruby
tags: 
- Ruby
---
I love <a href="http://en.gravatar.com/">gravatars</a>. You associate a (<strong>g</strong>lobally <strong>r</strong>ecognized) avatar with your email address, and any site that has your email can show it. My blog uses it for the comments.

For another blog I'm working on, I want to detect if a commenter has a gravatar. If not, they will see a message after posting, to the effect of "Personalize your comment with a gravatar." A bunch of identical default gravatars looks boring.

<!--more-->

Gravatar actually has <a href="http://en.gravatar.com/site/implement/url">support for unique default icons</a>, but <a href="http://scott.sherrillmix.com/blog/blogger/wp_monsterid/">MonsterID</a> and <a href="http://www.shamusyoung.com/twentysidedtale/?p=1462">Wavatar</a> are quite ugly, <a href="http://scott.sherrillmix.com/blog/blogger/wp_identicon/">Identicons</a> are a little boring, and <a href="http://twitter.com/henrik/statuses/975925385">ChauvinistID</a> is not yet a reality.

Anyway, I thought I'd share the code I came up with for detecting if there is a gravatar for a given email address:

{% highlight ruby %}
require 'net/http'
require 'digest/md5'
# Is there a Gravatar for this email? Optionally specify :rating and :timeout.
def gravatar?(email, options = {})
  hash = Digest::MD5.hexdigest(email.to_s.downcase)
  options = { :rating => 'x', :timeout => 2 }.merge(options)
  http = Net::HTTP.new('www.gravatar.com', 80)
  http.read_timeout = options[:timeout]
  response = http.request_head("/avatar/#{hash}?rating=#{options[:rating]}&default=http://gravatar.com/avatar")
  response.code != '302'
rescue StandardError, Timeout::Error
  true  # Don't show "no gravatar" if the service is down or slow
end
{% endhighlight %}

The idea is to make a HEAD request for a gravatar. We won't get image data back, only headers, so the standard size is fine. The <code>default</code> is set to a URL so it actually redirects if there was no gravatar. If a redirect code is sent, we know it doesn't exist. Otherwise, we assume it exists.

Pass the <code>:rating</code> as an option, if you want to limit the check to that rating or safer. The default is "x", meaning it checks for any avatar, even x-rated ones. Gravatar URLs default to "g" if nothing is specified, but the rationale here is that if someone has a gravatar (but an x-rated one), it would be incorrect to tell them "You don't have a gravatar."

Since sites can be slow or go down, the default timeout is 2 seconds. Override with <code>:timeout</code>. Yes, this relies on Ruby's <a href="http://blog.headius.com/2008/02/rubys-threadraise-threadkill-timeoutrb.html">broken <code>timeout.rb</code></a>, but since the method uses <code>net/http</code> anyway, it may be acceptable.

Setting the <code>default</code> gravatar to e.g. "." or "/" (but not to empty) worked as well (redirected to that same URL), but I decided that the character savings didn't make up for relying on undocumented behavior.
