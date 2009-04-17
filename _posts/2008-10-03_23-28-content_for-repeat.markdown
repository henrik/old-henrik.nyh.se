--- 
wordpress_id: 248
title: Repeat content in Rails with content_for
tags: 
- Ruby
- Ruby on Rails
---
Just came up with a simple but useful Rails trick (though I'm likely not the first).

Say you have a long table with the same controls (buttons, pagination, whatever) both above and below it.

Doing the controls twice over is not <abbr title="Don't Repeat Yourself">DRY</abbr>; using a helper or partial may be overkill if these controls are never reused other than these two times.

Enter <a href="http://api.rubyonrails.com/classes/ActionView/Helpers/CaptureHelper.html#M001751"><code>content_for</code></a>.

It's commonly used to pass content such as a title or sidebar box from a template to a layout, but you can also use it within one and the same page.

<!--more-->

Hence:

{% highlight rhtml %}
<% content_for :controls do %>
  <ul>
    <li>Do this</li>
    <li>Do that</li>
  </ul>
<% end %>
<%= yield :controls %>

<table>
  …
</table>

<%= yield :controls %>
{% endhighlight %}

Prettier in <a href="http://haml.hamptoncatlin.com/">Haml</a>, of course:

{% highlight text %}
- content_for :controls do
  %ul
    %li Do this
    %li Do that
= yield :controls

%table
  …

= yield :controls
{% endhighlight %}

The effect is something like inline partials. Perfectly DRY without adding much complexity.
