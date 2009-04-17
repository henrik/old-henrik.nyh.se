--- 
wordpress_id: 206
title: Rails truncate helper that handles HTML tags and entities
tags: 
- Ruby
- Ruby on Rails
- Hpricot
---
I needed a Rails helper like <a href="http://api.rubyonrails.com/classes/ActionView/Helpers/TextHelper.html#M001049">truncate</a> but that doesn't truncate in the middle of a tag or entity and doesn't leave start tags without their end tags. So

{% highlight ruby %}
truncate_html('foo &amp; bar baz', 9)
truncate_html('foo <b class="x">ar</b> baz', 8)
{% endhighlight %}
gives

{% highlight ruby %}
'foo &amp; ...'
'foo <b class="x">a</b>...'
{% endhighlight %}
and not something like

{% highlight ruby %}
'foo &a...'
'foo <...'
{% endhighlight %}

Also, I made it aware of HTML in the ellipsis text, so e.g.

{% highlight ruby %}
truncate_html(@object.description, 25, link_to(@object, "more"))
{% endhighlight %}
only displaces four characters (for "more") of truncated string, instead of several (for the link HTML).

Oh, and being based on Hpricot, which has a robust parser, it handles crap HTML well:

{% highlight ruby %}
>> truncate_html(%{<i><b>foo</i></b> bar<p>baz<p>boink}, 14)
=> "<i><b>foo</b></i> bar<p>baz<p>b</p></p>..."
{% endhighlight %}


<!--more-->

<h4>Installation</h4>

Get it <a href="http://pastie.textmate.org/pastes/145402/download">here</a> (<a href="http://pastie.textmate.org/145402">highlighted source</a>).

Save it as <code>app/helpers/text_helper.rb</code> and make sure you're doing

{% highlight ruby %}
helper :all
{% endhighlight %}
or

{% highlight ruby %}
helper TextHelper
{% endhighlight %}
in your <code>ApplicationController</code>.

<h4>Previous work</h4>

I was inspired by Mike Burns' <a href="http://mikeburnscoder.wordpress.com/2006/11/11/truncating-html-in-ruby/">Truncating HTML in Ruby</a> and Joakim Andersson's response <a href="http://joakimandersson.se/archives/2007/03/01/rails-tidy-rexml/">Rails + tidy + REXML</a>. Joakim uses <a href="http://tidy.sourceforge.net/">tidy</a> to keep REXML from choking on malformed HTML. I <a href="http://joakimandersson.se/archives/2007/03/01/rails-tidy-rexml/#comment-29821">suggested</a> cleaning the HTML with Hpricot, and then figured it'd be fun to write my own helper using just Hpricot, not REXML.

My helper behaves just like the Rails helper in regard to what arguments it takes and how it interprets the max length – if the string is within limits, the full string is returned; if it's longer, the truncated string <em>including the ellipsis</em> is limited to the max length.
