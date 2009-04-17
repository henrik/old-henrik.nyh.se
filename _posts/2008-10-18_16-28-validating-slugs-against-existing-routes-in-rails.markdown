--- 
wordpress_id: 252
title: Validating slugs against existing routes in Rails
tags: 
- Ruby
- Ruby on Rails
---
On a web site, it's neat to provide URLs like <code>http://community.com/some_username</code> or <code>http://blog.com/some_category</code>. It's only slightly shorter than <code>/users/some_username</code> or <code>/u/some_username</code>, but looks much better.

Having usernames or tags directly under the root of the site means they can collide with other routes, though. If you're using <code>/login</code>, you don't want users to be able to have that username.

<!--more-->

The first thing to do is, of course, to put the username route at the very end. You will need to, or its wildcard nature will catch every request (well, every request not including the path separators <code>.</code> and <code>/</code>). This means that if a user would somehow end up with a name like "login", the login action will still work – but the less-important user page will be eclipsed.

Let's assume our routes are

{% highlight ruby %}
map.login 'login',     :controller => 'sessions', :action => 'new'
map.user  ':username', :controller => 'users',    :action => 'show'
{% endhighlight %}


You could then do this to avoid route collisions in usernames:

{% highlight ruby %}
class User < ActiveRecord::Base
  validates_format_of :name, :with => /\A[\w-]+\Z/
  validates_uniqueness_of :name
  validate :name_is_not_a_route
  
protected
  
  def name_is_not_a_route
    path = ActionController::Routing::Routes.recognize_path("/#{name}", :method => :get) rescue nil
    errors.add(:name, "conflicts with existing path (/#{name})") if path && !path[:username]
  end
  
end
{% endhighlight %}

<code>ActionController::Routing::Routes.recognize_path("/#{name}", :method => :get)</code> takes a path (must begin with a slash) and an optional environment hash. With the routes specified above, we could have left out the <code>:method</code>, but we'll need it for RESTful routes or other routes with method conditions (otherwise they may be recognized by the wildcard route instead, or fail to be recognized altogether).

If the method fails to match a route, you get an <code>ActionController::RoutingError</code>. If it succeeds, you get a hash. The inline rescue above ensures graceful handling even if recognition fails.

Note that the <code>user</code> wildcard route will recognize a lot of stuff (the controller, not the route, will then get to decide if there is such a user), so we actually shouldn't get routing errors, assuming we don't let usernames contain periods or slashes (path separators), but it's good to be defensive. Especially since the model above runs the route validation independent of the format validation.

So if the method succeeds in recognizing a route, you will get a hash:

{% highlight ruby %}
>> ActionController::Routing::Routes.recognize_path('/login')
=> {:controller=>"sessions", :action=>"new"}
>> ActionController::Routing::Routes.recognize_path('/some_username')
=> {:username=>"some_username", :controller=>"users", :action=>"show"}
{% endhighlight %}

If the hash has a value for the <code>:username</code> key, it was recognized by that route. That implies two things: no earlier route matched the username, and it has a format that means it can be properly routed as a username (again, usernames containing slashes or periods would fail here).

If you have other routes that also have a <code>:username</code> key, you may want to make this condition more strict, also confirming the controller and action. No need to worry about query strings, though – they're not part of the recognition process:

{% highlight ruby %}
>> ActionController::Routing::Routes.recognize_path('/login?username=foo', :method => :get)
# ActionController::RoutingError: No route matches "/login?username=foo" with {:method=>:get}
{% endhighlight %}

The uniqueness validation is there to make this point: the route validation only avoids collisions with earlier routes; it doesn't run any controller code, so it has no idea if the username is already taken. 

Another thing to note is that (non-wildcard) routing is case-sensitive, so if you have a <code>/login</code> page, a user could pick the name "LOGIN", and both would work. If you don't like this, downcase the slug before checking for a route. Mix-case routes would take more effort.

Of course, this code can't look into the future and prevent users from taking the names of routes you add later. You could run code on every deploy to check that there are no new collisions due to this.

A simpler, but limited, solution I've heard of is to keep all routes shorter than say six characters (<code>/login</code> is fine but <code>/logout</code> would be too long</code>) and only allow longer usernames.
