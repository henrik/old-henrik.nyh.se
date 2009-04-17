--- 
wordpress_id: 70
title: Autologin script gets extraction tool
tags: 
- Greasemonkey
- JavaScript
- OS X
- Firefox
---
Before I switched to Firefox, I was using <a href="http://www.flashpeak.com/sbrowser/">SlimBrowser</a>.

Though comparably sucky (no Greasemonkey!), it has something Firefox doesn't: an autologin feature. Basically you fill out a log-in form on some page, select a menu command, and an autologin will be created. Running that autologin, e.g. through something similar to Firefox bookmark keywords, will direct you to that page, fill out the form and submit it.

Firefox can auto-fill form values, but doesn't submit the form afterwards. Though that's <a href="http://www.userscripts.org/scripts/show/750">easily greasemonkeyed</a>, it only works if you've a single account.

About a year ago, I first released the <a href="http://www.userscripts.org/scripts/show/1595">Autologin</a> userscript, that worked somewhat like the SlimBrowser autologin.

Today, I updated the script, making it a lot easier to use.

<!--more-->

With <a href="http://www.userscripts.org/scripts/show/1595">the new script</a>, you can add an autologin by simply filling out the log-in form, making sure the focus (typically the caret) is in the form, and selecting <code>Tools &gt; User Script Commands &gt; Create autologin from form</code>. Previously, you had to poke through the page source and compose the autologin URL yourself.

<h4>Behind the code</h4>

Detecting the focused form with JavaScript was pretty interesting.

There is, to my knowledge, no obvious way to check for focus on a form (or otherwise) element.

One way of achieving this would be to add <code>focus</code> event handlers to every form element, so that every time a form element gains focus, it stores itself into some variable.

I went with another, rather clever solution. The idea is to use the CSS <code>:focus</code> pseudo-class to set some attribute value on the focused element, and then sniff for that attribute. 

This idea was suggested by <a href="http://ecmanaut.blogspot.com">ecmananut</a>. In the original suggestion, the dummy attribute to set was <a href="http://developer.mozilla.org/en/docs/CSS:azimuth">azimuth</a> (being unlikely to clash with actual attributes set); for whatever reason, using that particular attribute didn't work, so I went with <code>background-attachment:fixed</code> instead. Though less uncommon than <code>azimuth</code>, it's probably very rare that the <code>background-attachment</code> of a (non-textarea) form field is set to <code>fixed</code>.

The pertinent code follows. <code>with_each()</code> wraps a <code>for</code> loop applying a callback function to each element matched by some XPath expression.

{% highlight javascript %}
function get_focused_form() {
	GM_addStyle("input:focus, select:focus {background-attachment:fixed;}");
	var result;
	with_each("//input | //select", function(element) {
		var bAt = window.getComputedStyle(element, null).backgroundAttachment;
		if (bAt == "fixed")
			return (result = element);  // Return into get_focused_form
	});	
	if (result)
		return result.form;
}
{% endhighlight %}
