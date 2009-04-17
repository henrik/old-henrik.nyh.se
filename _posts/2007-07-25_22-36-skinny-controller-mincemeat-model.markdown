--- 
wordpress_id: 165
title: Skinny controller, mincemeat model
tags: 
- Ruby
- OS X
- TextMate
- Ruby on Rails
---
I'm all for skinny controllers, but <a href="http://weblog.jamisbuck.org/2006/10/18/skinny-controller-fat-model">fat models</a> can get unmanageable. After adding a couple of methods for this, that and the other – perhaps a <code>User</code> with authorization, password reset and serialization – the model can be quite fat indeed.

There are many conceivable ways of making fat models more manageable. Something very simple I've been trying lately is to just group code in blocks, and <a href="http://macromates.com/textmate/manual/navigation_overview#collapsing_text_blocks_foldings">fold them in TextMate</a> as needed. The simplest way is to just use <code>begin</code>/<code>end</code>:

<!--more-->

{% highlight ruby %}
class User < ActiveRecord::Base

  def full_name
    [first_name, last_name].join(' ')
  end
  
  begin # authentication

    def self.authenticate(username, password)
      # do it
    end

  end

  begin # serialization

    def to_xml(options={})
      # do it
    end

  end

end
{% endhighlight %}

I prefer self-documenting code to comments, though. You can fake it by doing

{% highlight ruby %}
begin :authentication
  ⋮
end
{% endhighlight %}
The <code>:authentication</code> symbol isn't actually a method argument – this is equivalent to

{% highlight ruby %}
begin
  :authentication
  ⋮
end
{% endhighlight %}
so I suppose whether it can be described as more self-documenting than comments is debatable.

<h4>:foo.code do</h4>

Anyway, I do this instead:

As <code>lib/ar_groups.rb</code>:

{% highlight ruby %}
class Symbol
  def code(&block)
    block.call
  end
end
{% endhighlight %}

Added to <code>config/environment.rb</code>:

{% highlight ruby %}
require 'ar_groups'
{% endhighlight %}

And then you can do:

{% highlight ruby %}
class User < ActiveRecord::Base

  :authentication.code do

    def self.authenticate(username, password)
      # do it
    end

  end

end
{% endhighlight %}

<h4>category :foo do</h4>

If abusing symbols bothers you, try something like

{% highlight ruby %}
module ActiveRecord
  class Base
  protected
    def self.category(name=nil, &block)
      block.call
    end
  end
end
{% endhighlight %}
and

{% highlight ruby %}
class User < ActiveRecord::Base

  category :authentication do

    def self.authenticate(username, password)
      # do it
    end

  end

end
{% endhighlight %}

<h4>Highlighting</h4>

To make things more manageable still, TextMate can be made to highlight these blocks. Merge this rule into the Ruby grammar (with thanks to Ciarán Walsh):

{% highlight ruby %}
{ name = 'meta.code-cat';
  begin = '^(\s*)(:.+)\.code (do)\b.*';
  end = '^\1(end)\s*(#.*)?\n?';
  beginCaptures = {
    2 = { name = 'constant.other.symbol.ruby'; };
    3 = { name = 'keyword.control.ruby.start-block'; };
  };
  endCaptures = {
    1 = { name = 'keyword.control.ruby.end-block'; };
    2 = { name = 'comment.line.number-sign.ruby'; };
  };
  patterns = (
    { include = '$base'; }
  );
},
{% endhighlight %}
and <a href="http://macromates.com/textmate/manual/themes">theme</a> <code>source.ruby meta.code-cat</code> to taste. Et voilà:

<p class="center"><img src="http://henrik.nyh.se/uploads/ar-categories_tm.png" alt="[Screenshot]" /></p>

Adapting the grammar for other kinds of blocks should be pretty straightforward.
