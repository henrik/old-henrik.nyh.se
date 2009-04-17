--- 
wordpress_id: 114
title: Key binding for vertical ellipsis
tags: 
- OS X
---
I think the vertical ellipsis glyph (<code>⋮</code>) is underused, so I bound it to <code>⌥,</code> for easy insertion. This binding is analogous to <code>⌥.</code> producing the horizontal ellipsis (<code>…</code>) as is the case on my MacBook.

This is achieved just like <a href="http://macromates.com/blog/archives/2006/07/10/multi-stroke-key-bindings/">these multi-stroke key bindings</a>, but with this key-value pair in the top-level dictionary:

{% highlight text %}
"~,"    = ("insertText:", "\U22EE");
{% endhighlight %}

Like the multi-stroke key bindings, this binding only works in Cocoa applications.

As to what it's good for:

1. Bind <code>⋮</code> to <code>⌥,</code>.
⋮
3. Profit!
