--- 
wordpress_id: 237
title: Simple double form submission prevention with jQuery
tags: 
- JavaScript
- jQuery
---
If an impatient user clicks "Submit" multiple times, a form may be submitted multiple times, causing issues.

I recently ran into <a href="http://blog.insoshi.com/2008/06/26/working-around-the-validates_uniqueness_of-bug-in-ruby-on-rails/">one such issue</a>.

I've seen solutions that show an alert dialog with a message like "Already being submitted. Close this dialog and wait." I don't think that's very good UI. Better to silently discard extra submits.

Other solutions invalidate the "Submit" button and change its text to something like "Submitting…". This has some issues. Forms can be submitted without touching the submit button, e.g. with the Enter key, so disabling the button doesn't necessarily prevent multiple submissions. Also, sometimes you don't use a regular submit button, but instead an image submit button, or something fancy involving JavaScript, that is less straightforward to disable.

This is my simple solution, using <a href="http://jquery.com/">jQuery</a>:

<!--more-->

{% highlight javascript %}
jQuery.fn.preventDoubleSubmit = function() {
  jQuery(this).submit(function() {
    if (this.beenSubmitted)
      return false;
    else
      this.beenSubmitted = true;
  });
};
{% endhighlight %}

Use like

{% highlight javascript %}
jQuery('#my_form').preventDoubleSubmit();
{% endhighlight %}

The code simply stores within the form object itself whether it has been submitted before. If it has, submission is silently aborted.

Ajax forms would, of course, also require <code>beenSubmitted</code> to be reset after the server response is received or timed out. Leaving that as an exercise for the reader.

Also note that if the user doesn't have JavaScript enabled, they will be able to double submit, so don't rely solely on client-side code.
