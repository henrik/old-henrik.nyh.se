--- 
wordpress_id: 122
title: Greasemonkey bundle syntax highlighting
tags: 
- Greasemonkey
- OS X
- TextMate
---
I committed some changes to the <a href="http://henrik.nyh.se/2007/03/textmate-greasemonkey-bundle-in-official-repository/">Greasemonkey bundle</a> that scope non-standard header directives differently. I added a section to the bundle's help file with this information:

<blockquote>
<h5>Grammar/Highlighting Tips</h5>

These are some ways you can <a href="http://macromates.com/textmate/manual/themes">modify your theme</a> to get nicer syntax highlighting of userscripts.

<!--more-->

<ul>
<li>Add a style for <code>meta.header.greasemonkey</code>, perhaps a background color, to change the appearance of metadata headers.</li>
<li>Add a style for <code>meta.directive.<wbr />nonstandard.<wbr />greasemonkey keyword</code> to have non-standard metadata keywords (e.g. <code>@version</code>) highlighted differently from standard keywords (e.g. <code>@name</code>).</li>
</ul>
</blockquote>

In addition to the committed changes, I made a local modification to the grammar. If you insert

{% highlight text %}
{ name = 'meta.footer.staples.greasemonkey';
  begin = '^\s*/\* Staple functions \*/\s*';
  end = '^(?=not)possible$';
  beginCaptures = { 0 = { name = 'comment.block.staples.greasemonkey'; }; };
  patterns = ( { include = 'source.js.greasemonkey'; } );
},
{% endhighlight %}
just before

{% highlight text %}
{  include = 'source.js'; },
{% endhighlight %}
, then a line containing just optional whitespace and <code>/* Staple functions */</code> will be scoped as <code>comment.block.staples.greasemonkey</code>. That line and any code after it will be scoped as <code>meta.footer.staples.greasemonkey</code>.

Now, if you include staple functions with your scripts (see the bundle help for more info on this; see <a href="http://wiki.greasespot.net/Code_Snippets">the GM wiki</a> for useful functions), just add such a comment above them. This enables changing the highlighting of the comment and/or the entire section of bundle code. This is how userscripts are highlighted for me: 

<p class="center">
<img src="http://henrik.nyh.se/uploads/tm-gmbundle-highlighting.png" alt="" />
</p>

I use the Blackboard theme with some modifications. You can <a href="http://henrik.nyh.se/uploads/Blackboard HN.tmTheme">download it here</a>.
