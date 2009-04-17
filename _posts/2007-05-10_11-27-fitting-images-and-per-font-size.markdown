--- 
wordpress_id: 139
title: Fitting images in liquid columns with Prototype and per-font CSS font-size
tags: 
- JavaScript
- CSS
---
Thought I'd write up two things I implemented in a recent redesign of <a href="http://i.johannaost.com">my girlfriend's personal site</a>.

In both cases, I'm using the <a href="http://www.prototypejs.org/">Prototype JavaScript framework</a> with <a href="http://www.skyrocket.be/download/prototype.domReady.js">Vivabit's DOMReady extensions</a> (<a href="http://dean.edwards.name/weblog/2005/09/busted/">explained</a>).

<!--more-->

<h4>Fit images in liquid columns</h4>

Richard Rutter has done <a href="http://clagnut.com/blog/268/">some interesting experiments</a> on displaying images in liquid (variable-width) columns. One interesting technique he mentions for fitting images in such columns is to set the CSS <code>width</code> of the image to <code>100%</code> (to grow and shrink with the column) and the <code>max-width</code> to the actual width of the image in pixels (to never grow it beyond its original size).

I'm using this method for images in the LiveJournal entries displayed on the site.

One could have the web server retrieve each image prior to HTML output and check its dimensions. I thought a JavaScript solution would be nicer, though.

It should be noted that this won't work for users with JavaScript disabled. As a fallback, I have the CSS

{% highlight css %}
/* This is replaced in JS */
.lj-post img {
  max-width:100%;
}
{% endhighlight %}

which does almost the same thing, but does not work in IE6 (no IE7 handy) and can grow images beyond their original size. The JavaScript is simply this:

{% highlight javascript %}
Event.onDOMReady(function() {

  // Make images fit in columns
  // http://clagnut.com/blog/268/
  $$(".lj-post img").each(function(img) {
    Event.observe(img, 'load', function(event) {
      img.style.maxWidth = img.width + 'px';
      img.style.width = '100%';
    });
  });

});
{% endhighlight %}

The <code>$$</code> function finds the images using a CSS selector. You'd likely need to change that selector here and in the CSS above.

<h4>Different font, different font size</h4>

The headers on the site are in <span style="font-family:Helvetica Neue Light">Helvetica Neue Light</span> (which I think comes with OS X). If a visitor does not have that font, the fallback is plain <span style="font-family:Helvetica, Arial">Helvetica or Arial</span>.

A problem with this is that Helvetica and Arial are a lot wider at the same <code>font-size</code>, making things look worse than intended.

CSS allows for <code>font-family</code> fallbacks, but they will all share a <code>font-size</code>. However, I wrote some JavaScript code to fix this. It requires the user to have JavaScript activated, but it also degrades gracefully, if overlarge headers can be considered graceful. Without JavaScript, it'll just stay at the same size.

I use a slightly modified (to just return whether the font was detected) version of Lalit Patel's <a href="http://www.lalit.org/lab/fontdetect.php">JavaScript/CSS font detector</a>:

{% highlight javascript %}
/* http://www.lalit.org/lab/fontdetect.php */
var FontDetector = function() {
  var h = document.getElementsByTagName("BODY")[0];
  var d = document.createElement("DIV");
  var s = document.createElement("SPAN");

  d.appendChild(s);
  d.style.fontFamily = "sans-serif";    //font for the parent element DIV.
  s.style.fontFamily = "sans-serif";    //arial font used as a comparator.
  s.style.fontSize   = "72px";      //we test using 72px font size, we may use any size. I guess larger the better.
  s.innerHTML        = "mmmmmmmmmml";    //we use m or w because these two characters take up the maximum width. And we use a L so that the same matching fonts can get separated
  h.appendChild(d);
  var defaultWidth   = s.offsetWidth;    //now we have the defaultWidth
  var defaultHeight  = s.offsetHeight;  //and the defaultHeight, we compare other fonts with these.
  h.removeChild(d);

  /* test
   * params:
   * font - name of the font you wish to detect
   * return: 
   * f[0] - Input font name.
   * f[1] - Computed width.
   * f[2] - Computed height.
   * f[3] - Detected? (true/false).
   */
  function test(font) {
    h.appendChild(d);
    var f = [];
    f[0] = s.style.fontFamily = font;  // Name of the font
    f[1] = s.offsetWidth;        // Width
    f[2] = s.offsetHeight;        // Height
    h.removeChild(d);

    font = font.toLowerCase();
    if (font == "arial" || font == "sans-serif") {
      f[3] = true;  // to set arial and sans-serif true
    } else {
      f[3] = (f[1] != defaultWidth || f[2] != defaultHeight);  // Detected?
    }
    return f[3];
  }
  this.test = test;
}
{% endhighlight %}

Then, I add a class to the body element if Helvetica Neue Light is not present:

{% highlight javascript %}
Event.onDOMReady(function() {

  // Change header font sizes if Helvetica Neue Light is missing, since Arial/Helvetica is larger at the same percentage
  var detector = new FontDetector();
  if (!detector.test("Helvetica Neue Light"))
    document.body.addClassName('arial');

});
{% endhighlight %}

Finally, I have CSS selectors to change headers if this class is present:

{% highlight css %}
/* JS adds this class if Helvetica Neue Light is missing */
.arial h1 {
  font-size:170%;
}
.arial h2 {
  font-size:140%;
}
{% endhighlight %}

Enhancing a site when JavaScript is enabled, but not breaking it when its not, is a very cool thing.
