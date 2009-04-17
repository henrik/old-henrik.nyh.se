--- 
wordpress_id: 147
title: Filter del.icio.us dailies from RSS feed using Yahoo pipes
tags: 
- RSS
---
Among others, I subscribe to the RSS feeds for <a href="http://infix.se">Filip's blog</a> and <a href="http://del.icio.us/network/malesca">my del.icio.us network</a>.

Filip has his RSS feed set up to include daily summaries of his del.icio.us activity. But I already get that data through my network feed. I just want his regular blog posts.

So I created <a href="http://pipes.yahoo.com/pipes/pipe.info?_id=fq_KwTUT3BG9vIuJEpPZnA">a Yahoo pipe</a> that filters them out. It was insanely simple.

I generalized this into <a href="http://pipes.yahoo.com/pipes/pipe.info?_id=WmRPGDkT3BG4Umrxl7okhQ">another pipe</a> that takes any feed URL as input. So to create your own del.icio.us-less ("disagreeable"<footnote>
<blockquote>
<strong>delicious</strong> <em>adj</em>
Definition: pleasing, especially to the taste
Antonyms: disagreeable, distasteful, horrible, unpleasant, unsavory
</blockquote>
</footnote>?) feeds, that pipe is probably the easiest way. Or just clone the first pipe and modify it.
