---
title: Canonizing pseudo-slugs in Rails
tags:  [Ruby, Ruby on Rails]
---

It's common to use pseudo-slugs in Ruby on Rails apps. You do something like

{% highlight ruby %}
class Item < ActiveRecord::Base

  def to_param
    [id, slug].join("-")
  end

end
{% endhighlight %}

The Rails URL helpers will now use this parameter in URLs instead of just the `id`. Controller actions can usually be left unchanged since `ActiveRecord::Base#find` will run `to_i` on the parameter string, lopping off the slug.

These pseudo-slugs let people mess with you, though. They could pass your `http://example.com/items/1-foo` URL to someone else as `http://example.com/items/1-ugly-ass-foo` and it will work fine. It may even be indexed by search engines that way.

This is easy to overlook, but the solution is fairly obvious and simple:

{% highlight ruby %}
class ItemsController < ActionController:Base

  def show
    @item = Item.find(params[:id])
    
    canonical = @item.to_param
    if canonical != params[:id]
      redirect_to(:overwrite_params => { :id => canonical }, :status => :moved_permanently) and return
    end
  end

end
{% endhighlight %}

Using `:overwrite_params` will ensure any additional parameters are unchanged.

If you need this for more than just the `show` action, you might move it to a separate method, perhaps used as a `before_filter`.
