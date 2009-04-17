--- 
wordpress_id: 271
title: Non-restricting scope and the UserSession class in Rails
tags: 
- Ruby
- Ruby on Rails
---
Just a quick Ruby on Rails tip. This is how I implemented a method to either return a scoped subset of a table or all records:

{% highlight ruby %}
class UserSession
  def viewable_posts
    admin? ? Post.scoped({}) : Post.published
  end
end
{% endhighlight %}

By using <code>Post.scoped({})</code> rather than <code>Post.all</code>, you get a named scope proxy back, meaning that you can chain other scopes onto it and that the query is not executed until necessary.

The <code>UserSession</code> class, by the way, is a nice idea I picked up somewhere. It's a model without an underlying table that you initialize with the Rails <code>session</code> and that encapsulates simple authentication/session logic.

<!--more-->

The model:

{% highlight ruby %}
class UserSession
  
  def initialize(session)
    @session = session
  end
  
  def login(params)
    @session[:is_admin] = !Site.password.blank? && Site.password==params[:password]
  end
  
  def logout
    @session[:is_admin] = nil
  end
  
  def admin?
    !!@session[:is_admin]
  end
  
  def viewable_posts
    admin? ? Post.scoped({}) : Post.published
  end
  
end
{% endhighlight %}

<code>Site</code> is a configuration object.

The controller defines methods to access an instance of this object from controller instances and views:

{% highlight ruby %}
class ApplicationController < ActionController::Base
 
  def user_session
    @user_session ||= UserSession.new(session)
  end
  helper_method :user_session

end
{% endhighlight %}

Used like e.g. <code>user_session.admin?</code>.
