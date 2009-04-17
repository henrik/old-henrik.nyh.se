--- 
wordpress_id: 213
title: Rails model extensions (mincemeat models revisited)
tags: 
- Ruby
- Ruby on Rails
---
My last stab at <a href="http://henrik.nyh.se/2007/07/skinny-controller-mincemeat-model">mincemeat models</a> wasn't very pretty – wrapping different method sets in blocks and folding them.

This is what I've been doing lately instead, to keep fat Rails models manageable.

<!--more-->

<h4>Background</h4>

In Ruby, there is the concept of the load path. Basically, if you <code>require "foo"</code>, Ruby will first look for "foo.rb" in your current directory, then in each of the directories in the load path.

Rails adds several directories to your load path, such as <code>"#{RAILS_ROOT}/lib"</code> and <code>"#{RAILS_ROOT}/app/models"</code>.

Furthermore, Rails does some magic with <code>Module#const_missing</code>: if you use a module (classes are modules, too, by inheritance) that isn't known, Rails will automatically try to <code>require</code> a file.

The filename is assumed to be the name of the module. If the module is nested in other modules, any but the right-most module are assumed to be directories. CamelCase is converted to snake_case. So <code>FooBar::Baz</code> translates to <code>foo_bar/baz.rb</code>.

This is why you don't have to explicitly require your models or controllers: their directories are in the load path, and their files follow this naming convention.

<h4>Extensions</h4>

To break some code out of a model, create a directory under <code>app/models</code> with the same name as the model, then put your extension files in this directory, and name them according to the convention.

So to extend the <code>User</code> model, you could create <code>app/models/user/authentication_extension.rb</code>:

{% highlight ruby %}
class User
  module AuthenticationExtension
    def self.included(klass)
      klass.instance_eval do
        attr_reader :password
        validates_presence_of :password_hash

        extend  ClassMethods
        include InstanceMethods
      end
    end

    module ClassMethods
       def authenticate(email, password)
         # ...
       end
    end

    module InstanceMethods
       def password=(value)
         # ...
       end
    end

  end
end
{% endhighlight %}

Though this file is automatically loaded when you refer to the module, you still have to refer to it, and explicitly include it in the model class. Like so:

{% highlight ruby %}
class User < ActiveRecord::Base
  include AuthenticationExtension
end
{% endhighlight %}

The module we defined is <code>User::AuthenticationExtension</code>, but within the <code>User</code> class you don't have to fully qualify the name. Note that this means you have to be careful what names you use: if you define a <code>User::Forum</code> module for code related to a forum system, and also have a <code>Forum</code> model, you will have to use <code>::Forum</code> to refer to the latter from within the <code>User</code> model.

I use the <code>FooExtension</code> naming scheme to avoid these conflicts.

<h4>Constant repositories</h4>

In addition to including modules, you can also use the same idea to e.g. store a bunch of related constants. 

If you, say, find yourself using a lot of raw SQL in a model, you could create a class

{% highlight ruby %}
class User
  module SQL

    SOME_QUERY = "#{User.table_name}.foo IS NOT NULL AND ..."
    # ...    

  end
end
{% endhighlight %}

and then refer to the constants as e.g. <code>User::SQL::SOME_QUERY</code>, or just <code>SQL::SOME_QUERY</code> from within the model.

The same caveat about class name conflicts applies.

<h4>In closing</h4>

As was brought up in comments on my last post on this subject, keep in mind that it is sometimes better to create more models, rather than fattening the ones you have. But if they must be fat, cut them up.
