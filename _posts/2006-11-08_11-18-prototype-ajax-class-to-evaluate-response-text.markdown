--- 
wordpress_id: 78
title: Prototype Ajax class to evaluate response text
tags: 
- JavaScript
- Ajax
---
Using <a href="http://prototype.conio.net/">Prototype</a> (<a href="http://www.sergiopereira.com/articles/prototype.js.html">documentation</a>) for some Ajax work, I found myself repeatedly doing something like

{% highlight javascript %}
new Ajax.Request(some_url, {method:'post', parameters: some_parameters, onComplete:function(transport) {
  eval(transport.responseText);
}});
{% endhighlight %}

The effect is that the response text, the output of the backend (at <code>some_url</code>), is evaluated as JavaScript code on the requesting page.

Too much duplicated code, though.

<!--more-->

With <code>Ajax.Updater</code>, you can specify the option <code>evalScripts:true</code> to have script tag contents in the response text evaluated, but <code>Ajax.Updater</code> also updates some specified element with the non-script output. If I would use this, I would need some dummy element, and also to wrap the backend output in <code>script</code> tags.

Instead, I subclassed <code>Ajax.Request</code> with an <code>Ajax.Eval</code> class that does exactly what I want and nothing more. It takes an URL and some parameters, and evaluates the output as JavaScript.

Code:

{% highlight javascript %}
Ajax.Eval = Class.create();
Object.extend(Object.extend(Ajax.Eval.prototype, Ajax.Request.prototype), {
  initialize: function(url, pars) {
    this.transport = Ajax.getTransport();
    this.setOptions({method:'post', parameters:pars});
    this.options.onComplete = (function(transport) {
      eval(transport.responseText);
    });
    this.request(url);
  }
});
{% endhighlight %}

Now, I can simply do 

{% highlight javascript %}
new Ajax.Eval(some_url, some_parameters);
{% endhighlight %}
