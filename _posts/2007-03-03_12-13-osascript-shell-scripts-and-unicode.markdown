--- 
wordpress_id: 111
title: osascript, shell scripts and Unicode
tags: 
- OS X
- AppleScript
- Shell scripting
---
I spent some time in encoding hell the other day, trying to read a UTF-8 encoded text file with <code>osascript</code> in a bash shell script.

Despite its preference for the MacRoman encoding, <a href="http://www.satimage.fr/software/en/unicode_and_applescript.html">AppleScript does handle Unicode</a>, but ironically, to get that to work, I had to include the string "«class utf8»" &ndash; the chevrons in which must of course be encoded just right.

After much pain, I came to realize it'd be best to just create a separate <code>.scpt</code> file for the AppleScript, encoded in its native MacRoman, and call that from the shell script, i.e.

{% highlight bash %}
osascript saviour.scpt
{% endhighlight %}

Before that moment of zen, I did this, which also works but is rumoured to kill kittens:

{% highlight bash %}
DIE_ENCODINGS_DIE=$(printf 'set file_contents to read (POSIX file "/tmp/some.file")  as \307class utf8\310')
osascript -e "$DIE_ENCODINGS_DIE" -e "-- Do something with file_contents"
{% endhighlight %}
