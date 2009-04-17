--- 
wordpress_id: 233
title: Rails authenticity token with jQuery
tags: 
- JavaScript
- Ruby on Rails
- jQuery
---
By default, Rails 2 employs <a href="http://ryandaigle.com/articles/2007/9/24/what-s-new-in-edge-rails-better-cross-site-request-forging-prevention">protection</a> against <a href="http://en.wikipedia.org/wiki/Cross-site_request_forgery" title="Cross-Site Request Forgery">CSRF</a> attacks.

What it comes down to is sending an authenticity token (unique per session) along with all non-GET requests as well as all Ajax requests.

I prefer <a href="http://jquery.com/">jQuery</a> to Prototype, the JavaScript library that ships with Rails. This is how I made jQuery automagically send the authenticity token along with all Ajax requests.

<!--more-->

In my application layout, I stick an authenticity token in a JavaScript variable in the page header:

{% highlight rhtml %}
<%= javascript_tag "var AUTH_TOKEN = #{form_authenticity_token.inspect};" if protect_against_forgery? %>
{% endhighlight %}

Then in my <code>application.js</code> file:

{% highlight javascript %}
$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});

{% endhighlight %}

<code>ajaxSend</code> is a <a href="http://docs.jquery.com/Ajax_Events">global event</a> that is broadcast before every Ajax request. This code adds a handler for that event, that in turn adds the authenticity token to the request data.

This solution was inspired by some code by "Andreas" in <a href="http://errtheblog.com/posts/73-the-jskinny-on-jquery#comment_1154">an "Err the Blog" comment</a>. Note that if you use <code>$.ajaxSetup({data: …})</code>, though, you only set <em>default</em> data, that is overwritten if the Ajax request has data of its own. My solution effectively merges the authenticity token into whatever other data is in the request.
