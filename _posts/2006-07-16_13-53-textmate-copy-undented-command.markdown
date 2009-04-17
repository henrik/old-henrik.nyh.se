--- 
wordpress_id: 6
title: "TextMate: \"Copy undented\" command"
tags: 
- Ruby
- OS X
- TextMate
---
I wrote <a href="http://macromates.com/textmate/manual/commands">a command script</a> for <a href="http://www.macromates.com">TextMate</a> to copy the selected text (or current line) to the clipboard with any initial (but not internal) whitespace removed.

This is the behaviour I want when sharing code; when you share an excerpt, it usually doesn't benefit from non-internal indentation.

<!--more-->

<h3>Command script</h3>

I put this in my own bundle:

Save: Nothing
Command(s):

{% highlight ruby %}
#!/usr/bin/ruby
#
# Copies the selection (or else the line) to 
# clipboard, but with any initial indentation
# stripped, so that the actual text is flush left.
#
# Because of the "re-indented paste" feature you might
# not notice this effect if you paste it back into TM.
#
# Code considers spaces and tabs equal, so two spaces 
# are considered further indented than one tab. This
# will probably only cause problems if you indent with
# mixed tabs and spaces.
#
# By Henrik Nyh <http://henrik.nyh.se>.
# Free to modify, though please credit me.

lines = STDIN.readlines()

shortest_indent_length = lines.reject { |line| line =~ /^\s*$/ }.map {|line| line.scan(/^\s*/)[0].size }.min
lines.map! {|line| line[Range.new(shortest_indent_length, -1)] || "\n" }

IO.popen("pbcopy", "w") { |copier| copier.puts lines.join }

puts "Undented copy has been placed in clipboard."
{% endhighlight %}

Input: Selected Text or Line
Output: Show as Tool Tip 

Activation: Key Equivalent <code>⌥⌘C</code>, or whatever you fancy.

Leave Scope Selector empty.

<h3>Usage</h3>

Simply highlight some text and hit <code>⌥⌘C</code> to copy the selection undented. A tooltip will appear to confirm that this has been done.
