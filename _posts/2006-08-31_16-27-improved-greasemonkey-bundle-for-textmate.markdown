--- 
wordpress_id: 43
title: Improved Greasemonkey bundle for TextMate
tags: 
- Greasemonkey
- JavaScript
- Ruby
- OS X
- TextMate
- Firefox
---
I extended <a href="http://adamv.com/dev/textmate/greasemonkey">Adam V's TextMate Greasemonkey bundle 1.0</a> with some useful commands, modified the snippets and template slightly and also added <code>unsafeWindow</code>, <code>GM_setValue()</code> and friends to the language grammar.

<p class="center"><img src="http://henrik.nyh.se/uploads/greasemonkeybundle.png" alt="[Screenshot]" style="border:1px solid #000;" /></p>

<!--more-->

<a href="http://henrik.nyh.se/filer/Greasemonkey.tmbundle.zip">Download</a> (16 KB).

The grammar and the snippets are mainly by Adam.

This is what the bundle currently contains, other than the grammar.

<h4>Template</h4>

Select <code>File &gt; New From Template &gt; Greasemonkey &gt; Userscript</code> to create a new script from template. The template outputs this:

{% highlight javascript %}header

/* Your favorite functions go here */{% endhighlight %}
You should change the template (<code>File &gt; New From Template &gt; Edit Templates&hellip;</code>) to include whatever functions you commonly use. I decided against including mine to make the bundle less controversial. I will probably blog them at a later date.

The <code>header</code> bit is to be used with a snippet. Hopefully, TextMate will support snippety placeholders in templates directly at some point.

<h4>Snippets</h4>

The <code>header</code> snippet outputs a userscript header with placeholders, like this:

{% highlight javascript %}// ==UserScript==
// @name          Name
// @namespace     http://www.example.com
// @description   Description.
// @include       *
// ==/UserScript=={% endhighlight %}If you set a <code>TM_NAMESPACE</code> shell variable in the TextMate preferences, this will be used as the default <code>@namespace</code>.

Within the header, the snippets <code>i</code> and <code>e</code> add <code>@include</code> and <code>@exclude</code> directives. Sadly, TextMate doesn't support snippets-within-snippets yet, so this does not work until after you've broken out of the <code>header</code> snippet. However, the "Continue Header URL" command works fine.

<h4>Commands</h4>

<h5>Continue Header URL</h5>

Available when writing <code>@include</code> and <code>@exclude</code> directives. Hitting <code>&#x2305;</code> will add another of the same directive on the next line, moving the caret as appropriate.

<h5>Install and Edit</h5>

If you start writing a new script and then hit <code>&#x2318;B</code>, the script will be installed, closed and the installed version opened for editing. This makes starting new scripts vastly less annoying.

Caveats: "Enable access for assistive devices" must be toggled on in the Universal Access prefpane, otherwise closing the old file will not work. The command assumes the file is unsaved. If it is not, you will hear a system beep as it fails to click "Don't Save Changes".

<h5>Update Metadata</h5>

Hit <code>&#x2318;D</code> (conveniently next to the <code>S</code> of saving fame) to update the metadata from the values in the script file.

Greasemonkey stores the <code>@name</code>, <code>@include</code> and <code>@exclude</code> values and friends when a script is installed. After that time, these values must be changed in the "Manage User Scripts" window &ndash; unless you use this command.

Caveat: The command replaces the metadata values with the script values. This means that if you've e.g. changed <code>@include</code>s in "Manage User Scripts" but not in the script itself, your modifications are lost.

<h5>Uninstall Script</h5>

Uninstalls the currently open script. Has no keyboard shortcut by default. Prompts for confirmation.

<h5>Open Installed Script&hellip;</h5>

Displays a dialog listing every installed userscript, ordered alphabetically. Select one and confirm to open it. Has no keyboard shortcut by default.

<h5>Reload Firefox</h5>

Hit <code>&#x2318;R</code> to activate Firefox and reload the current page. Caveats: Either "Enable access for assistive devices" must be on, or Firefox should <em>not</em> be set to open URLs from external applications in new tabs.

<h5>References</h5>

There are also three commands to look up more information on XPath expressions, the Gecko DOM or Greasemonkey-specific functions. These are all bound by default to <code>&#x2303;&#x2325;&#x2318;H</code>. 

<h4>To do</h4>

Suggestions are very welcome. Some things I am considering adding are:

A command like "Open Installed Script..." but with the scripts sorted in reverse chronological order of installation, or modifying this command to offer that choice.

Submit (as new or an update) the current script to <a href="http://userscripts.org/">userscripts.org</a>.

Updating metadata on <code>&#x2318;S</code> along with saving a script.

<p class="updated"><a href="http://henrik.nyh.se/2006/09/minor-updates-to-greasemonkey-bundle/">Some updates have been made.</a></p>
