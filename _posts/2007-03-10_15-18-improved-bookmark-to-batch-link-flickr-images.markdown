--- 
wordpress_id: 113
title: Improved bookmark to batch link Flickr images
tags: 
- JavaScript
- Firefox
- Bookmarklets
---
A couple of months ago, I wrote <a href="http://henrik.nyh.se/2006/09/bookmarklet-to-blog-all-images-from-a-flickr-page/">a bookmarklet to blog all images from a Flickr page</a>. The idea is that you can go to pretty much any Flickr page &ndash; perhaps the images you uploaded today &ndash; and get the code to post all of them in a blog or forum without having to manually copy that information from each image in turn.

Flickr have since changed their image naming scheme so that the URLs of full-size images are not predictable (in any obvious way) from any property of smaller images.

I've now rewritten it into a pretty big bookmarklet (4 912 bytes when URL encoded &ndash; does this make it a regular bookmark? A supermarklet?) that uses the Flickr <a href="http://bob.pythonmac.org/archives/2005/12/05/remote-json-jsonp/">JSONP</a> <a href="http://www.flickr.com/services/api/">API</a> to look up the names of full-size images.

<p class="center"><img src="http://henrik.nyh.se/uploads/bookmarklet-fbat.png" alt="" /></p>

Output can be provided as linked HTML images, linked HTML images within a LiveJournal LJ-cut, or forum <a href="http://en.wikipedia.org/wiki/BBCode">BBCode</a>. Unlike that of the old bookmarklet, the output is presented in a pretty overlay that can be discarded for further browsing.

Using API calls to look up the URL of the full-size image is somewhat slower than the old bookmarklet (which no longer works), but in return, you get fancy visuals &ndash; images scheduled for look-up are faded in opacity, and return to full opaqueness once the information is retrieved. If an image stays opaque, that suggests the image in question is non-public.

<!--more-->

It works in Firefox. I've confirmed it does not work in Safari. I won't spend time making it compatible, but if someone else wants support in other browsers, please do investigate and post a patch in the comments.

Bookmark this: <a href="javascript:function%20%24%28id%29%20%7B%20return%20document.getElementById%28id%29%3B%20%7D%0Afunction%20destroy%28el%29%20%7B%20el.parentNode.removeChild%28el%29%3B%20%7D%0A%0Afunction%20get_source_for%28id%29%20%7B%0A%09var%20request%20%3D%20document.getElementsByTagName%28%22head%22%29%5B0%5D.appendChild%28document.createElement%28%22script%22%29%29%3B%0A%09request.id%20%3D%20%22fbat_request_%22%20%2B%20id%3B%0A%09request.src%20%3D%20%22http%3A%2F%2Fapi.flickr.com%2Fservices%2Frest%2F%3Fmethod%3Dflickr.photos.getSizes%26format%3Djson%26api_key%3D58b74bb27f70254a67c34ed95710bc12%26photo_id%3D%22%20%2B%20id%3B%0A%09%24%28%22fbat_%22%20%2B%20id%29.style.opacity%20%3D%200.3%3B%0A%7D%0A%0Afunction%20jsonFlickrApi%28json%29%20%7B%0A%09counter%20-%3D%201%3B%0A%09%0A%09if%20%28json%5B%22stat%22%5D%20%3D%3D%20%22fail%22%29%20return%3B%0A%09%0A%09var%20source%2C%20sizes%20%3D%20json%5B%22sizes%22%5D%5B%22size%22%5D%3B%0A%09for%20%28var%20i%3D0%3B%20i%20%3C%20sizes.length%3B%20i%2B%2B%29%20%7B%0A%09%09source%20%3D%20sizes%5Bi%5D%5B%22source%22%5D%3B%0A%09%09if%20%28sizes%5Bi%5D%5B%22label%22%5D%3D%3D%22Original%22%29%20break%3B%0A%09%7D%0A%09var%20id%20%3D%20source.match%28%2F%5C%2F%28%5Cd%2B%29_%2F%29%5B1%5D%3B%0A%0A%09%24%28%22fbat_%22%20%2B%20id%29.style.opacity%20%3D%201%3B%0A%09destroy%28%24%28%22fbat_request_%22%20%2B%20id%29%29%3B%0A%09%0A%09results%5Bid%5D%5B%22source%22%5D%20%3D%20source%3B%0A%09if%20%28%21counter%29%20finish%28%29%3B%0A%7D%0A%0Afunction%20finish%28%29%20%7B%0A%09var%20key%2C%20image%2C%20images%20%3D%20%5B%5D%3B%0A%09for%20%28i%3D0%3B%20i%3Cordered_keys.length%3B%20i%2B%2B%29%20%7B%0A%20%20%20%20%09image%20%3D%20results%5Bordered_keys%5Bi%5D%5D%3B%0A%09%09if%20%28%21image%5B%22source%22%5D%29%20continue%3B%0A%09%09if%20%28format.match%28%2F%5Eb%2Fi%29%29%20%20%2F%2F%20b%2C%20BB%2C%20BBcode%2C%20...%0A%09%09%09images.push%28%27%5Bimg%5D%27%20%2B%20image%5B%22source%22%5D%20%2B%20%27%5B%2Fimg%5D%27%29%3B%0A%09%09else%0A%09%09%09images.push%28%27%3Ca%20href%3D%22%27%20%2B%20image%5B%22href%22%5D%20%2B%20%27%22%20title%3D%22%27%20%2B%20image%5B%22alt%22%5D%20%2B%20%27%22%3E%3Cimg%20src%3D%22%27%20%2B%20image%5B%22source%22%5D%20%2B%20%27%22%20alt%3D%22%27%2B%20image%5B%22alt%22%5D%20%2B%27%22%20%2F%3E%3C%2Fa%3E%27%29%3B%0A%09%7D%0A%09%0A%09var%20output%2C%20output_prefix%2C%20output_suffix%3B%0A%09output_prefix%20%3D%20output_suffix%20%3D%20%22%22%3B%0A%09if%20%28format.match%28%2F%5El%2Fi%29%29%20%7B%20%20%2F%2F%20l%2C%20LJ%2C%20LJcut%2C%20...%0A%09%09output_prefix%20%3D%20%22%3Clj-cut%20text%3D%5C%22The%20photos.%5C%22%3E%5Cn%5Cn%22%3B%0A%09%09output_suffix%20%3D%20%22%5Cn%5Cn%3C%2Flj-cut%3E%22%3B%0A%09%7D%0A%09output%20%3D%20output_prefix%20%2B%20images.join%28%22%5Cn%5Cn%22%29%20%2B%20output_suffix%3B%0A%09%0A%09present%28output%29%3B%0A%7D%0A%0Afunction%20present%28output%29%20%7B%0A%09var%20overlay%20%3D%20document.createElement%28%22div%22%29%3B%0A%09with%20%28overlay.style%29%20%7B%0A%09%09position%20%3D%20%27fixed%27%3B%0A%09%09top%20%3D%20left%20%3D%200%3B%0A%09%09width%20%3D%20height%20%3D%20%27100%25%27%3B%0A%09%09textAlign%20%3D%20%27center%27%3B%0A%09%09backgroundColor%20%3D%20%27%23FFF%27%3B%0A%09%7D%0A%09document.body.appendChild%28overlay%29%3B%0A%09overlay.innerHTML%20%3D%20%22%3Ch3%3ECopy%20this%20code%2C%20then%20click%20without%20the%20box%20to%20discard.%3C%2Fh3%3E%3Ctextarea%20style%3D%27width%3A90%25%3Bheight%3A80%25%3Bborder%3A1px%20solid%20%23000%3Bbackground%3A%23FEFEFE%3Bpadding%3A1em%3B%27%20id%3D%27fbat_output%27%3E%22%20%2B%20output%20%2B%20%22%3C%2Ftextarea%3E%22%3B%0A%09%24%28%27fbat_output%27%29.select%28%29%3B%0A%09content.addEventListener%28%27click%27%2C%20function%28%29%20%7B%20destroy%28overlay%29%3B%20%7D%2C%20false%29%3B%0A%09%24%28%27fbat_output%27%29.addEventListener%28%27click%27%2C%20function%28e%29%20%7B%20e.stopPropagation%28%29%3B%20%7D%2C%20false%29%3B%0A%7D%0A%0Avar%20counter%20%3D%200%2C%20fail%20%3D%200%2C%20ordered_keys%20%3D%20%5B%5D%2C%20results%20%3D%20%7B%7D%3B%0Avar%20m%2C%20id%2C%20image%2C%20images%20%3D%20document.images%3B%0Avar%20format%20%3D%20%22%s%22%3B%0A%0Afor%20%28i%3D0%3B%20i%3Cimages.length%3B%20i%2B%2B%29%20%7B%0A%09image%20%3D%20images%5Bi%5D%3B%0A%09if%20%28%0A%09%09%28m%20%3D%20image.src.match%28%2Fhttp%3A%5C%2F%5C%2F.%2A%3Fstatic%5C.flickr%5C.com%5C%2F%5Cd%2B%5C%2F%28%5Cd%2B%29_%5Ba-z%5Cd%5D%2B%28%3F%3A_%5Ba-z%5D%29%3F%5C.jpg%2F%29%29%20%26%26%0A%09%09%21image.className.match%28%2F%5Cb%28setThumb%7Cnextprev_thumb%29%5Cb%2F%29%20%26%26%0A%09%09image.id%20%21%3D%20%22primary_photo_img%22%0A%09%29%20%7B%0A%09%09id%20%3D%20m%5B1%5D%3B%0A%09%09image.id%20%3D%20%22fbat_%22%20%2B%20id%3B%0A%09%09ordered_keys.push%28id%29%3B%0A%09%09results%5Bid%5D%20%3D%20%7B%22alt%22%20%3A%20image.alt%2C%20%22href%22%20%3A%20image.parentNode.href%7D%3B%0A%09%09counter%20%2B%3D%201%3B%0A%09%09get_source_for%28id%29%3B%0A%09%7D%0A%7D%0A%0Avoid%280%29%3B">Flickr batch linker</a>. I suggest using "bat" for a bookmark keyword.

Pass the bookmarklet a (case-insensitive) argument beginning with <code>L</code> to get an LJ-cut, or <code>B</code> for BBCode. Anything else, or no argument, will give you HTML. So usage could e.g. be either of

{% highlight text %}
bat
bat html
bat bb
bat lj
{% endhighlight %}

The un-encoded code follows. It should be URL encoded before bookmarking it, but the "%s" is a Firefox quick-search placeholder (for argument passing) that should <em>not</em> be encoded.

As far as I could figure out, Flickr API keys are per application rather than per user, so it's included in the code.

{% highlight javascript %}
function $(id) { return document.getElementById(id); }
function destroy(el) { el.parentNode.removeChild(el); }

function get_source_for(id) {
  var request = document.getElementsByTagName("head")[0].appendChild(document.createElement("script"));
  request.id = "fbat_request_" + id;
  request.src = "http://api.flickr.com/services/rest/?method=flickr.photos.getSizes&format=json&api_key=58b74bb27f70254a67c34ed95710bc12&photo_id=" + id;
  $("fbat_" + id).style.opacity = 0.3;
}

function jsonFlickrApi(json) {
  counter -= 1;
  
  if (json["stat"] == "fail") return;
  
  var source, sizes = json["sizes"]["size"];
  for (var i=0; i < sizes.length; i++) {
    source = sizes[i]["source"];
    if (sizes[i]["label"]=="Original") break;
  }
  var id = source.match(/\/(\d+)_/)[1];

  $("fbat_" + id).style.opacity = 1;
  destroy($("fbat_request_" + id));
  
  results[id]["source"] = source;
  if (!counter) finish();
}

function finish() {
  var key, image, images = [];
  for (i=0; i<ordered_keys.length; i++) {
      image = results[ordered_keys[i]];
    if (!image["source"]) continue;
    if (format.match(/^b/i))  // b, BB, BBcode, ...
      images.push('[img]' + image["source"] + '[/img]');
    else
      images.push('<a href="' + image["href"] + '" title="' + image["alt"] + '"><img src="' + image["source"] + '" alt="'+ image["alt"] +'" /></a>');
  }
  
  var output, output_prefix, output_suffix;
  output_prefix = output_suffix = "";
  if (format.match(/^l/i)) {  // l, LJ, LJcut, ...
    output_prefix = "<lj-cut text=\"The photos.\">\n\n";
    output_suffix = "\n\n</lj-cut>";
  }
  output = output_prefix + images.join("\n\n") + output_suffix;
  
  present(output);
}

function present(output) {
  var overlay = document.createElement("div");
  with (overlay.style) {
    position = 'fixed';
    top = left = 0;
    width = height = '100%';
    textAlign = 'center';
    backgroundColor = '#FFF';
  }
  document.body.appendChild(overlay);
  overlay.innerHTML = "<h3>Copy this code, then click without the box to discard.</h3><textarea style='width:90%;height:80%;border:1px solid #000;background:#FEFEFE;padding:1em;' id='fbat_output'>" + output + "</textarea>";
  $('fbat_output').select();
  content.addEventListener('click', function() { destroy(overlay); }, false);
  $('fbat_output').addEventListener('click', function(e) { e.stopPropagation(); }, false);
}

var counter = 0, fail = 0, ordered_keys = [], results = {};
var m, id, image, images = document.images;
var format = "%s";

for (i=0; i<images.length; i++) {
  image = images[i];
  if (
    (m = image.src.match(/http:\/\/.*?static\.flickr\.com\/\d+\/(\d+)_[a-z\d]+(?:_[a-z])?\.jpg/)) &&
    !image.className.match(/\b(setThumb|nextprev_thumb)\b/) &&
    image.id != "primary_photo_img"
  ) {
    id = m[1];
    image.id = "fbat_" + id;
    ordered_keys.push(id);
    results[id] = {"alt" : image.alt, "href" : image.parentNode.href};
    counter += 1;
    get_source_for(id);
  }
}

void(0);
{% endhighlight %}
