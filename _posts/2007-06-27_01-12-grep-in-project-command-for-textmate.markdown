--- 
wordpress_id: 157
title: Grep in Project command for TextMate
tags: 
- Ruby
- OS X
- TextMate
---
<a href="http://henrik.nyh.se/uploads/grep-in-project.png"><img src="http://henrik.nyh.se/uploads/grep-in-project_mini.png" alt="[Grep in Project result listing]" /></a>

(Click the image for a larger screenshot.)

TextMate is an amazing editor, but its built-in "Find in Project" sucks. With larger projects, it's quite slow and will easily freeze the application for a good while.

<a href="http://en.wikipedia.org/wiki/Grep">grep</a> is better, but switching to the command line gets annoying, and it lacks integration with TextMate – you can't jump straight to a matching document.

What it lacks in project search, TextMate makes up for in extensibility, though, so I wrote a "Grep in Project" command that combines the speed of grep with a decent, well-integrated UI.

<!--more-->

Download here: <a href="http://henrik.nyh.se/uploads/Grep%20in%20Project.tmCommand">Grep in Project.tmCommand</a>

The command is by default bound to <code>&#x21E7;&#x2318;F</code>, essentially replacing the built-in "Find in Project". You can still access it through the menus or by hitting the keyboard shortcut in a HTML output window, such as the "Grep in Project" window – or just change the shortcut, if it bothers you.

Some other defaults: fixed string search (not regexp), substring search (doesn't match words only), case-insensitive, ignores <code>*.log</code> files and anything in directories named <code>.svn</code> or <code>vendor/rails</code>. These are good defaults for me (mainly working with Ruby on Rails apps). If you don't like them, alter the command. If your needs vary wildly, make multiple copies of the command or extend it (I likely won't) to use a dialog with options.

Some other things to note:

Each result row represents one matching line (except for binary file matches). Dark lines between rows separate files.

Overlong file names are ellipsized. Matching lines are ellipsized between keywords (and at the beginning and end) if necessary. Hover the mouse pointer over an ellipsis to display the missing text in a tooltip. Hover over file path links to display the un-ellipsized absolute path.

Click a file path link to visit that file and line in TextMate. For binary files, the link will reveal the file (open the directory and select the file) in Finder.

I've spent quite a lot of time making this command work well for me, but if your needs are greater, or just different, please do modify to taste and feel free to share your work in the comments.

<div class="updated">
<h5>Update 2007-06-27</h5>

Minor fixes: Colors look better with dark HTML window themes. Now works with single files (non-projects) as well. Some tidywork.
</div>

<div class="updated">
<h5>Update 2007-06-27b</h5>

Now properly shell-escapes single quotes in queries. Previously, any query containing single quotes would never return any results.
</div>

<div class="updated">
<h5>Update 2007-06-29</h5>

Now gets query from/writes query to <a href="http://macromates.com/blog/2005/the-shared-find-clipboard/">the shared find clipboard</a>. Thanks, Ciaran!
</div>

<div class="updated">
<h5>Update 2007-07-04</h5>

Web window automatically resizes to fit the results. Resizing web windows seems somewhat fragile, so it might not work all the time.
</div>
