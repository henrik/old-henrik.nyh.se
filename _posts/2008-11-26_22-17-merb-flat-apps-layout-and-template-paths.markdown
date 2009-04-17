--- 
wordpress_id: 262
title: "Merb flat apps: layout and template paths"
tags: 
- Ruby
- Merb
---
Layout and template paths in flat Merb apps (<code>merb-gen flat myapp</code>) are different from in regular apps.

Regular apps put layouts in <code>app/views/layout</code>, e.g. <code>app/views/layout/application.html.erb</code>; flat apps by default expect them in <code>views</code>, with a <code>layout.</code> prefix, e.g. <code>views/layout.application.html.erb</code>.

Also, flat apps by default don't use per-controller view subdirectories, but only rely on the action name: <code>views/index.html.erb</code> for an "index" action and so on.

You can customize the paths in the <code>_template_location</code> method that the Merb generator will dump in your controller:

{% highlight ruby %}
def _template_location(action, type = nil, controller = controller_name)
  controller == "layout" ? "layout.#{action}.#{type}" : "#{action}.#{type}"
end
{% endhighlight %}

It's fairly straightforward as long as you know that when Merb looks for the layout, it will consider <code>controller</code> to be "layout" and <code>action</code> to be the layout name.

The <code>type</code> is the format – often "html".

If you want all layouts in their own subdirectory, do something like

{% highlight ruby %}
def _template_location(action, type = nil, controller = controller_name)
  controller == "layout" ? "layout/#{action}.#{type}" : "#{action}.#{type}"
end
{% endhighlight %}

If you want to include the controller in all template names, try

{% highlight ruby %}
def _template_location(action, type = nil, controller = controller_name)
  "#{controller}.#{action}.#{type}"
end
{% endhighlight %}

and so on.
