--- 
wordpress_id: 251
title: Using form helpers with split-up forms in Rails
tags: 
- Ruby
---
Say you have a two-column layout, where the layout looks something like:

{% highlight rhtml %}
<div id="left-column">
  <%= yield %>
</div>
<div id="right-column">
  <%= yield :sidebar %>
</div>
{% endhighlight %}

So your main content goes in the left column, and you can optionally specify content to go in the sidebar.

In a template using this layout, you might have a form where some parts are in the left column, some in the right:

<!--more-->

{% highlight rhtml %}
<%# This goes in the left column: %>
<% form_for(@user) do |form| %>
  <%= form.text_field :name %>
  <%= form.submit %>
<% end %>

<%# This goes in the right column: %>
<% content_for(:sidebar) do %>
  <%# These do not work %>
  <%= form.radio_button :gender, "M" %>
  <%= form.radio_button :gender, "F" %>
<% end %>
{% endhighlight %}

How are you to get the radio buttons inside the form? You can't just extend the <code>form_for</code> block to surround the <code>content_for</code> block; the form start and end tags would still be inside the left column and not encompass the right column.

This is what I would do. First, allow content to be injected into the layout before and after both columns:

{% highlight rhtml %}
<%= yield :before_content %>
<div id="left-column">
  <%= yield %>
</div>
<div id="right-column">
  <%= yield :sidebar %>
</div>
<%= yield :after_content %>
{% endhighlight %}

Then in the template we need to insert the start form tag before and the end form tag after:

{% highlight rhtml %}
<% content_for(:before_content) do %>
  <%= form_tag(@post) %>
<% end %>
<% content_for(:after_content) do %>
  </form>
<% end %>
{% endhighlight %}
Note that I'm using <code>form_tag</code> where I used <code>form_for</code> before. It seems <code>form_for</code> can't be used without a block (=without creating an end tag as well).

<a href="http://api.rubyonrails.com/classes/ActionView/Helpers/FormTagHelper.html#M001699"><code>form_tag</code></a> will transform a record into a RESTful route just like <a href="http://api.rubyonrails.com/classes/ActionView/Helpers/FormHelper.html#M001740"><code>form_for</code></a>, but unlike that helper, it will not assign an id or class to the form, so be advised.

Now to the form fields. We're not using <code>form_for</code> anymore, and even if we could have, the columns would not have been contained in its block. One solution is to use <a href="http://api.rubyonrails.com/classes/ActionView/Helpers/FormTagHelper.html#M001701"><code>text_field_tag</code></a> and friends, manually specifying the field name and default value. But thankfully, we can use <a href="http://api.rubyonrails.com/classes/ActionView/Helpers/FormHelper.html#M001741"><code>fields_for</code></a>.

<code>fields_for</code> is basically like <code>form_for</code> but without the form start and end tags. It's most commonly used to mix multiple models in the same form. We can use it like this:

{% highlight rhtml %}
<% content_for(:before_content) do %>
  <%= form_tag(@post) %>
<% end %>
<% content_for(:after_content) do %>
  </form>
<% end %>

<%# This goes in the left column: %>
<% fields_for(@user) do |form| %>
  <%= form.text_field :name %>
  <%= form.submit %>
<% end %>

<%# This goes in the right column: %>
<% content_for(:sidebar) do %>
  <% fields_for(@user) do |form| %>
    <%= form.radio_button :gender, "M" %>
    <%= form.radio_button :gender, "F" %>
  <% end %>
<% end %>
{% endhighlight %}

This will set proper field names ("user[name]", "user[gender]") and default values (if <code>@user</code> has a name or gender already).

One thing to do note is that if you have other forms in the right column already (perhaps a search box), that form will of course be nested in this one and weirdness may ensue. In that case, rethink your layout.<!-- ~ --><!-- ~ -->
