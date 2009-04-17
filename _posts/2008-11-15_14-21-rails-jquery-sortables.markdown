--- 
wordpress_id: 256
title: Rails/jQuery UI sortables with single UPDATE query
tags: 
- JavaScript
- Ruby
- Ruby on Rails
- SQL
- Ajax
- jQuery
---
I just wrote some sortable code for a Rails/jQuery app and figured I would blog just how little code it takes, and also the single MySQL query I used on the backend.

<!--more-->

I have a <code>#images</code> div containing several <code>.image</code> divs. I want the <code>.image</code> divs to be drag-and-drop sortable, and for the ordering to be persisted to the database (in a column named "ordinal").

The JavaScript sorting, using <a href="http://docs.jquery.com/UI/Sortables">Sortables</a> from <a href="http://ui.jquery.com/">jQuery UI</a>:

{% highlight javascript %}
$('#images').sortable({items:'.image', containment:'parent', axis:'y', update: function() {
  $.post('/admin/images/sort', '_method=put&authenticity_token='+AUTH_TOKEN+'&'+$(this).sortable('serialize'));
}});
{% endhighlight %}

So my <code>.image</code> divs are sortable within their containing <code>#images</code>, and can only be dragged on the y axis (up and down). When the sorting is done, an Ajax request is sent to <code>/admin/images/sort</code>. The AUTH_TOKEN bit is Rails CSRF protection – see <a href="henrik.nyh.se/2008/05/rails-authenticity-token-with-jquery">this post</a> for more details and another way of handling it.

The Ajax request contains params like <code>image[]=3&image[]=1&image[]=2</code>, reflecting the order. The parameter name and values are taken from the element ids (e.g. "image_1").

I route the path:

{% highlight ruby %}
admin.resources :images, :collection => { :sort => :put }
{% endhighlight %}

Then make a controller action:

{% highlight ruby %}
def sort
  order = params[:image]
  Image.order(order)
  render :text => order.inspect
end
{% endhighlight %}

What's rendered isn't important, but you should render <em>something</em> or you get a 404.

The model method is just this:

{% highlight ruby %}
# Set passed-in order for passed-in ids.
def self.order(ids)
  update_all(
    ['ordinal = FIND_IN_SET(id, ?)', ids.join(',')],
    { :id => ids }
  )
end
{% endhighlight %}

This generates a query like

{% highlight sql %}
UPDATE images SET ordinal = FIND_IN_SET(id, "3,1,2") WHERE id IN (3,1,2)
{% endhighlight %}
which sets the ordinal column to the position of the record id in that set.

Whenever I need the images ordered, I just make sure they're sorted by <code>ordinal ASC, created_at ASC</code>.

That's all the code it takes.
