--- 
wordpress_id: 107
title: Snippet-power templates in TextMate
tags: 
- OS X
- TextMate
---
<a href="http://macromates.com/">TextMate</a> has powerful <a href="http://macromates.com/textmate/manual/snippets">snippets</a>, where you can input a keyword and press tab to expand it to some piece of code with tab stops and placeholders (and transformations, interpolated shell code, smoke and mirrors).

TextMate's <a href="http://macromates.com/textmate/manual/templates">templates</a>, however, are seemingly a lot less powerful. It's pretty much just a text file which allows placeholder strings that are replaced with the author name, year or date as a new file is created.

If one wants a template with tab stops, placeholders et cetera (a snipplate?), one solution is to first create a snippet (named e.g. <code>template</code>) and then create a template containing just that snippet tab trigger keyword, e.g.

{% highlight text %}
template
{% endhighlight %}

 Then you can manually move the caret to after the trigger and expand it every time you create a new file.

However, there are a couple of ways to include a snippet that expands <em>automatically</em> as a new file is created from template.

<!--more-->

<h4>The shell script</h4>

The placeholder replacement is possible because each template is in effect a shell script preprocessor in addition to the template files. This shell script can actually be used to add snippet powers to templates.

For a new template, the default script is:

{% highlight bash %}
if [[ ! -f "$TM_NEW_FILE" ]]; then
   TM_YEAR=`date +%Y` \
   TM_DATE=`date +%Y-%m-%d` \
   TM_USERNAME=`niutil -readprop / /users/\$USER realname` \
   perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' \
      < template_in.txt > "$TM_NEW_FILE"
fi
{% endhighlight %}

<h4>Sending keystrokes</h4>

If a template includes a snippet tab trigger keyword, e.g. <code>template</code>, automatically moving the caret to after that keyword and sending a &#x21E5; keystroke will expand it.

That can be achieved by adding this after the default contents of the shell script:

{% highlight bash %}
{ # Detach a process
  osascript -e 'tell app "System Events" to keystroke "e" using {control down}' -e 'tell app "System Events" to keystroke tab'
END
} &>/dev/null &
{% endhighlight %}

The <code>osascript</code> line runs AppleScript code to jump to the end of the line by emulating pressing &#x2303;E, and then perform a &#x21E5; keystroke to expand the snippet. 

The curly brackets and whatnot run the contained commands in a detached process (or something like that), which in this case means it will run slightly <em>after</em> the new file has been opened.

This solution is simple, but it has some caveats:

It's not quite instantaneous. On my MacBook, it takes something like half a second until the caret is moved and the snippet expanded.

The snippet will not be expanded if you're pressing other keys as the tab keystroke is sent. So if you use some key equivalent to create a new file from template, the snippet will not be auto-expanded unless you've released those keys by then. In that sense, the delay mentioned in the previous paragraph is a good thing.

Solving this without generating keystrokes would seem preferable. And it can be done, by using a perhaps little-known TextMate AppleScript command.

<h4>Insert as snippet</h4>

In the AppleScript dictionary for TextMate, there is a command <code>insert Unicode text [as snippet boolean]</code> that will insert a piece of text into the active document, interpreting it as a snippet. This is quite useful.

The new code to add to the shell script is this:

{% highlight bash %}
{ # Detach a process
  osascript "${TM_BUNDLE_SUPPORT}/load_snippet.scpt" "mysnippet.code"
} &>/dev/null &
{% endhighlight %}

The <code>load_snippet.scpt</code> file contains the following AppleScript (and must be encoded in MacRoman, for the sake of the chevrons):

{% highlight applescript %}
on run args
  set loaded_snippet to read (POSIX file (item 1 of args)) as «class utf8»
  tell app "TextMate" to insert loaded_snippet as snippet true
end run
{% endhighlight %}

The AppleScript goes into the bundle support directory. <code>mysnippet.code</code> is an additional template file that contains the actual snippet, e.g.

{% highlight text %}
Foo ${1:bar}.
{% endhighlight %}

What happens is quite simply that the AppleScript is passed the name of the snippet file as an argument, reads the contents of that file and tells TextMate to insert that string as a snippet.

The benefits of this solution to the keystroke one is that it works even if you're slow on releasing the key equivalent after creating a new file, and that you won't have a snippet in your bundle for all to see that is just for setting up the template. It's tucked away inside the support folder, safe and warm.

Install the <a href="http://henrik.nyh.se/uploads/Snipplate.tmbundle.zip">Snipplate bundle</a> and create a new file from its template, for a demonstration.

<div class="updated">
  <h5>Update 2007-03-02</h5>
  <p>Thoroughly rewritten again, merging all edits. Sorry.</p>
</div>

<div class="updated">
  <h5>Update 2007-03-02b</h5>
  <p>Added downloadable example bundle. Realized the AppleScript shouldn't be in the template directory, and that the snippet file should.</p>
</div>
