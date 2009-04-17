--- 
wordpress_id: 243
title: Show 404 instead of 500 for invalid format in Rails
tags: 
- Shell scripting
- Rack
---
When you visit <code>/page?format=foo</code> (and sometimes <code>/page.foo</code>, depending on the routes) in a Ruby on Rails app, Rails will try to render the action in that format - that is, using the <code>page.foo.erb</code> template.

If you use the

{% highlight ruby %}
respond_to do |wants|
  wants.html { … }
  wants.xml { … }
end
{% endhighlight %}
syntax, requesting an invalid format gives you an empty "406 Not Acceptable" response.

Actions that do not use this syntax, though, will cause an <code>ActionController::MissingTemplate</code> exception – which the user sees as an unsightly "500 Internal Server Error".

<!--more-->

That means actions that render implicitly like

{% highlight ruby %}
def page
  @page = Page.find(:first)
end
{% endhighlight %}
as well as explicitly like

{% highlight ruby %}
def page
  @page = Page.find(:first)
  render :layout => 'example'
end
{% endhighlight %}

I don't want to show the 500 page unless necessary. In this case, a 404 page makes some sense; you could also argue for using a 406 error (for consistency with <code>respond_to</code>, if nothing else).

I added this to my <code>ApplicationController</code>:

{% highlight ruby %}
# With +respond_to do |format|+, "406 Not Acceptable" is sent on invalid format.
# With a regular render (implicit or explicit), this exception is raised instead.
# Log it to Exception Logger, but show users a 404 page instead of error 500.
rescue_from(ActionController::MissingTemplate) do |e|
  log_exception(e)
  request.format = :html
  render_404
end
{% endhighlight %}

The <code>log_exception(e)</code> line should obviously be changed or removed if you don't use <a href="http://github.com/henrik/exception_logger/">Exception Logger</a>, or don't want the errors logged.

<code>render_404</code> was described in <a href="http://henrik.nyh.se/2008/07/rails-404">an earlier blog post</a>. If you prefer an empty error 406, a simple

{% highlight ruby %}
head(:not_acceptable)
{% endhighlight %}
should do it.

Note that none of this affects the 406 error when passing an invalid format to a <code>respond_to</code> action.
