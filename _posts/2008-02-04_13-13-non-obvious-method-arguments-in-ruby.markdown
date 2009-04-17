--- 
wordpress_id: 209
title: Non-obvious method arguments in Ruby
tags: 
- Ruby
---
I really dislike non-obvious method arguments in Ruby (and elsewhere).

Ruby doesn't have named arguments, but the idiom is to fake that with a hash argument:

{% highlight ruby %}
colonel_mustard.do_it(:with => :icepick, :in => :rumpus_room)
{% endhighlight %}

Methods can take non-named arguments that are still pretty obvious. This is true for most one-argument methods like <code>print</code>. Another example is <code>alias_method</code> where the mnemonic is in the name – specify the alias, then the method (though a lot of people don't seem to get this).

Some methods take very non-obvious arguments, though. <code>Module#attr</code> takes a boolean second argument to specify whether the attribute should be writable or not. So you might do

{% highlight ruby %}
attr :name, true
{% endhighlight %}

Thankfully, in many cases there are wrapper methods that abstract the non-obvious arguments into method names: in this case,

{% highlight ruby %}
attr_accessor :name
{% endhighlight %}
will in effect run

{% highlight ruby %}
attr :name, true
{% endhighlight %}

When there's no wrapper method, though, and you don't want to make your own, here's a tip: simply use throw-away local variables to make your code more readable. So instead of

{% highlight ruby %}
do_cryptic_stuff(true, false, 5)
{% endhighlight %}
consider

{% highlight ruby %}
do_cryptic_stuff(indefinitely = true, with_flair = false, minutes = 5)
{% endhighlight %}

That's it. Quite obvious, but perhaps the kind of obvious you never realize.
