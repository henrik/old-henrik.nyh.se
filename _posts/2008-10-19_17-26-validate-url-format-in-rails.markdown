--- 
wordpress_id: 253
title: Validate URL format in Rails
tags: 
- Ruby
- Ruby on Rails
---
To my surprise, I couldn't find a decent Ruby on Rails plugin for validating URLs by format.

The ones I found suffered from some combination of bad coverage, no test suite, unpleasant implementation and not being in git, so I made <a href="http://github.com/henrik/validates_url_format_of/">validates_url_format_of</a>.

It's not perfect, but better than any other plugin for the purpose I could find. Please do send patches or pull requests if you find a URL it does not validate correctly.

A nice touch, if I may say so myself, is that the default error message is different depending on whether or not the attribute name contains the word "URL". So you'd get "Homepage URL does not appear to be valid" but "Homepage does not appear to be a valid URL" out of the box.
