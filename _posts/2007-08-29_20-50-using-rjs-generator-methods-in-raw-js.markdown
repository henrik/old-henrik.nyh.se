--- 
wordpress_id: 171
title: Using RJS generator methods in raw JS
tags: 
- JavaScript
- Ruby
- Ruby on Rails
- Ajax
---
<a href="http://www.codyfauser.com/2005/11/20/rails-rjs-templates">RJS</a> (<a href="http://api.rubyonrails.com/classes/ActionView/Helpers/PrototypeHelper/JavaScriptGenerator/GeneratorMethods.html">generator methods docs</a>) is pretty cool.

In one RJS template, I wanted to (visually) remove an element with an animation, and then regenerate the entire list of elements when the animation completed. (I regenerate it because it is a top list, that should always have a certain number of elements if possible.)

Now, one can't do

{% highlight ruby %}
page.visual_effect :puff, @element_id
page.replace 'the_id', :partial => 'list'
{% endhighlight %}
since visual effects are asynchronous – the next line of code is executed straight away, not when the effect completes.

<!--more-->

Effects have callbacks, such as <code>afterFinish</code>, but in RJS, you specify the callbacks as strings, not blocks of code. And you can't do

{% highlight ruby %}
page.visual_effect :puff, @element_id, :afterFinish => "function() { " + page.replace('the_id', :partial => 'list') + " }"
{% endhighlight %}
because even though <code>page.replace</code> <em>will</em> return the generated JS as a string, it also appends that string to the returned JS, so one will end up with something like

{% highlight javascript %}
Element.replace(…);
new Effect.Puff("the_element_id", {afterFinish:'function() { Element.replace(…); }'});
{% endhighlight %}

This is one situation where RJS can seem pretty limited, but this is actually very easily solved.

One can use <code>page#&lt;&lt;</code> to inject raw JS into the page, just as the other generator methods generate JS and inject into the page. So one can simply wrap the generated JS in a function definition using <code>page#&lt;&lt;</code>, and then register that function for the callback:

{% highlight ruby %}
page << "function updateList() {"
page.replace 'the_id', :partial => 'list'
page << "}"
page.visual_effect :puff, @element_id, :afterFinish => 'updateList'
{% endhighlight %}

I suppose this is fairly obvious, but I didn't realize it right away.
