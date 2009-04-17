--- 
wordpress_id: 84
title: Scroll window when dragging Scriptaculous Sortables to edges
tags: 
- JavaScript
---
I'm using <a href="http://wiki.script.aculo.us/scriptaculous/show/Sortable.create">Scriptaculous Sortables</a> for the admin pages of an artist's portfolio: you can drag-and-drop sections, categories and images to change their displayed order, copy images between categories and so on.

When the list of images or categories grows long, sometimes you need to drag something vertically across several screenfuls. Alas, whereas Sortables allegedly have some support for scrolling containers, there is nothing built-in to scroll the entire viewport when necessary, which is what I wanted.

Google led me to <a href="http://wiki.script.aculo.us/scriptaculous/discuss/Sortables#discuss_3347">one solution by Josh Goldberg</a>. I implemented it, but it didn't quite do what I want.

For one, it would check whether to scroll the viewport on the <code>onChange</code> event, which for Sortables is only triggered when the sort order changes. Also, whether to scroll at this time was determined by whether the <em>top</em> of the element was at a certain proximity to the top or bottom of the viewport, so the tops of tall elements would never get close enough to the bottom of the viewport to trigger the scroll.

So I made some modifications. Much of this code is by Mr. Goldberg. I'm assuming I am free to modify and redistribute it.

<!--more-->

When creating Sortables, define the <code>starteffect</code> and <code>endeffect</code> like so:

{% highlight javascript %}
Sortable.create('drag_images', {
  …
  starteffect: scrollStart,
  endeffect: scrollEnd
});
{% endhighlight %}

That defines the functions to be run when the drag starts and ends.

The rest of the code follows. The idea of it is this:

When you start dragging, what element is being dragged is stored, and a function is triggered at short intervals (every 100 milliseconds) until the dragging stops.

Each time it is triggered, that function checks whether the top of the element is close (20 pixels) to the top of the viewport, or else if the bottom of the element is close to the bottom of the viewport. If so, it scrolls a ways (30 pixels) in that direction.

Code:

{% highlight javascript %}
var itemBeingDragged;
var scrollPoll;

function getWindowScroll() {
  var T, L, W, H;
  var w = window;
  with (w.document) {
    if (w.document.documentElement && documentElement.scrollTop) {
      T = documentElement.scrollTop;
      L = documentElement.scrollLeft;
    } else if (w.document.body) {
      T = body.scrollTop;
      L = body.scrollLeft;
    }
    if (w.innerWidth) {
      W = w.innerWidth;
      H = w.innerHeight;
    } else if (w.document.documentElement && documentElement.clientWidth) {
      W = documentElement.clientWidth;
      H = documentElement.clientHeight;
    } else {
      W = body.offsetWidth;
      H = body.offsetHeight
    }
  }
  return { top: T, left: L, width: W, height: H };
}

function findTopY(obj) {
  var curtop = 0;
  if (obj.offsetParent) {
    while (obj.offsetParent) {
      curtop += obj.offsetTop;
      obj = obj.offsetParent;
    }
  }
  else if (obj.y)
    curtop += obj.y;
  return curtop;
}

function findBottomY(obj) {
  return findTopY(obj) + obj.offsetHeight;
}

function scrollSome() {
  var scroller = getWindowScroll();
  var yTop = findTopY(itemBeingDragged);
  var yBottom = findBottomY(itemBeingDragged);

  if (yBottom > scroller.top + scroller.height - 20)
    window.scrollTo(0,scroller.top + 30);
    else if (yTop < scroller.top + 20)
    window.scrollTo(0,scroller.top - 30);
}

function scrollStart(e) {
  itemBeingDragged = e;
  scrollPoll = setInterval(scrollSome, 100);
}

function scrollEnd(e) {
  clearInterval(scrollPoll);
}
{% endhighlight %}

I'm assuming this works with pure Draggables (that are not Sortables) as well, but I haven't actually tested that.

I've tested this code in Firefox 2.0 and Safari 2.0.4 for OS X, since that's all I needed it for. If it breaks in other browsers, let me know.
