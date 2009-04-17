--- 
wordpress_id: 204
title: IMDB Trivia & Goofs Growler
tags: 
- Ruby
- Hpricot
---
While watching "The Neverending Story", my girlfriend asked me to read the <a href="http://imdb.com">IMDB</a> trivia page for that movie to her.

Naturally I didn't do anything of the sort and also stopped watching the movie to instead program a general solution for this kind of craving.

My girlfriend finished the movie and went to bed before I was done, so this isn't thoroughly tested – please point out any issues. ;)

I give you: the <a href="http://henrik.nyh.se/uploads/trivia">IMDB Trivia &amp; Goofs Growler</a> (<a href="http://pastie.textmate.org/144152">highlighted</a>).

<a href="http://henrik.nyh.se/uploads/imdbtrivia.png"><img src="http://henrik.nyh.se/uploads/imdbtrivia-thumb.png" alt="[Screenshot]" /></a>

I'll make this quick since I need to hit the hay. Download that file and read the comment block at the top.

It's a Ruby script that should work on OS X Leopard with <a href="http://growl.info">Growl and growlnotify</a>.

It takes an IMDB URL (or just the movie ID) as input; looks up the trivia, goofs, and duration of the movie; figures out suitable intervals; and gets growling.

I should mention that it seems Growl can't display on top of Front Row, so it doesn't work there. But you probably want ready access to the terminal anyway, so you can easily pause/resume the trivia.

Enjoy!
