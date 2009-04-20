--- 
wordpress_id: 112
title: Major update to the TextMate Greasemonkey bundle
tags: 
- Greasemonkey
- JavaScript
- OS X
- TextMate
---
I've made quite a few additions/changes to the Greasemonkey bundle for <a href="http://macromates.com/">TextMate</a>.

<p class="center"><img src="http://henrik.nyh.se/uploads/gmbundle-2.png" alt="" /></p>

The most exciting addition is probably the ability to upload scripts straight into <a href="http://userscripts.org/">Userscripts.org</a>.

<p class="center"><img src="http://henrik.nyh.se/uploads/gmbundle-2b.png" alt="" /></p>

<!--more-->

Download: <a href="http://henrik.nyh.se/uploads/Greasemonkey.tmbundle.zip">Greasemonkey.tmbundle.zip</a> (96 KB)

<div class="updated">
<h5>Update 2007-03-20</h5>

<p><a href="http://henrik.nyh.se/2007/03/textmate-greasemonkey-bundle-in-official-repository/">This bundle is now in the official repository</a>.</p>

</div>

Please comment with any bug reports or feature suggestions.

I made <a href="http://stp.lingfil.uu.se/~henrikn/gmbundle_screencast.mov">a screencast</a> (7 minutes 23 seconds, 14.45 MB streaming). No audio, but feel free to put on "<a href="http://youtube.com/watch?v=ODFzTRf-Nns">Greased Lightning</a>" in the background.

Around 2:00 in the movie, I forget to update the script metadata (write to the <code>config.xml</code> from the script metadata block), so things don't work as I planned until I fix it around 2:50. Sorry about that - might be a bit confusing.

I'll paste the bundle documentation (available through <code>Help</code> in the bundle menu) below, for your pleasure:

<h4>Template (&#x21E7;&#x2303;&#x2325;&#x2318;G)</h4>
<p>Select <code>File &gt; New From Template &gt; Greasemonkey &gt; Userscript</code> to create a new script from template. The template outputs this:</p>

{% highlight text %}
// ==UserScript==
// @name          Name
// @namespace     http://www.example.com
// @description   Description.
// @include       *
// ==/UserScript==



/* Your favorite functions go here. */
{% endhighlight %}

<p>The metadata block is a snippet, with placeholders. If you set a <code>TM_NAMESPACE</code> shell variable in the TextMate preferences (<code>Preferences &gt; Advanced &gt; Shell Variables</code>), this will be used as the default <code>@namespace</code>. If you have a page currently open in Firefox, that will be the default value for the <code>@include</code>.</p>

<p>You should change the <code>template.user.js</code> template to include whatever functions you commonly use. The snippet can be modified in the bundle editor (<code>File &gt; New From Template &gt; Edit Templates…</code>) as <code>snippet.user.js</code>.</p>

<p>Optionally, if you create a file <code>~/Library/Application Support/TextMate/Bundles/Greasemonkey.tmbundle.staples.user.js</code>, the <code>/* Your favorite functions go here. */</code> comment will be substituted with its contents whenever a new script is created. This might be useful if you want to version control your staple code.</p>

<p>Creating a template is available in the global scope &ndash; you don&#8217;t need to be editing a Greasemonkey script to invoke the keyboard shortcut.</p>



<h4>Snippets</h4>
<h5>Included URL and Excluded URL (i&#x21E5; and e&#x21E5;)</h5>
<p>Within the header block, the snippets <code>i</code> and <code>e</code> add <code>@include</code> and <code>@exclude</code> directives with <code>http://</code> as a preselected value. The next tab stop puts the caret after <code>http://</code>.</p>

<p>Sadly, TextMate doesn&#8217;t support snippets-within-snippets yet, so this does not work until after you&#8217;ve broken out of the <code>header</code> snippet. However, <a href='#continue_header_url'>Continue Header URL</a> works fine in snippets.</p>

<h5>Continue Header URL (&#x2305;) <span id="continue_header_url"></span></h5>
<p>Available when writing <code>@include</code> and <code>@exclude</code> directives. Hitting &#x2305; adds another of the same directive on the next line and moves the caret.</p>

<p>If you want to add another directive with a similar URL, consider using <code>Bundles &gt; Text &gt; Duplicate Line</code> (&#x2303;&#x21E7;D) instead.</p>

<p>Strictly speaking a command, but it fits with the snippets.</p>

<h5>GM_log (log&#x21E5;, logw&#x21E5; and loge&#x21E5;)</h5>
<p><code>log</code> inserts <code>GM_log("info")</code> with <code>"info"</code> pre-selected. The next tab stop selects just <code>ìnfo</code>. Start typing directly to log a variable, or tab once and then type, to input a string.</p>

<p><code>logw</code> and <code>loge</code> give warning and error level logging.</p>

<h5>GM&#95;setValue and GM&#95;getValue (set&#x21E5; and get&#x21E5;)</h5>
<p>Inserts those function calls. The contents of the key string are pre-selected. The next two tab stops select <code>"value"</code> and <code>value</code> in that order. Start typing at the first tab stop to specify a variable, and the second to specify a string.</p>

<h5>GM&#95;addStyle (css&#x21E5;)</h5>
<p>Expands to <code>GM_addStyle("CSS");</code> with the string contents pre-selected.</p>

<h5>GM&#95;xmlhttpRequest (xhr&#x21E5;)</h5>
<p>Inserts that function call, with a <code>GET</code> method (<code>POST</code> is messy).</p>

<p>Tab stops are in turn the url value, the url value string contents, the entire onload value and the body of a pre-defined onload callback function.</p>

<h5>GM&#95;registerMenuCommand (menu&#x21E5;)</h5>
<p>Inserts that function call, with tab stops selecting in turn the command name string contents, the entire callback function and the body of a pre-defined function.</p>

<h5>GM&#95;openInTab (tab&#x21E5;)</h5>
<p>Inserts that function call, with tab stops selecting in turn the entire URL string and the string contents.</p>



<h4>Commands</h4>
<h5>Open Installed Script&hellip; (&#x2303;&#x2325;&#x2318;G)</h5>
<p>Displays a dialog listing every installed userscript, with the choice of alphabetical or chronological (most recently installed first) ordering. Select a script and confirm to open it.</p>

<p>Available in the global scope &ndash; you don&#8217;t need to be editing a Greasemonkey script to invoke it.</p>

<h5>Install and Edit (&#x2318;B)</h5>
<p>If you write a new script and hit &#x2318;B, the script will be installed, the old file closed and the installed version opened for editing. This makes starting new scripts vastly less annoying.</p>

<p><strong>Caveat:</strong> &#8220;Enable access for assistive devices&#8221; must be toggled on in the Universal Access prefpane, otherwise closing the old file will not work.</p>

<p>When the old file is closed, any unsaved changes are discarded.</p>

<h5>Update Metadata (&#x2318;D)</h5>
<p>Hit &#x2318;D (conveniently next to the S of saving fame) to update the <code>config.xml</code> metadata from the values in the script file.</p>

<p>Greasemonkey writes the <code>@name</code>, <code>@include</code>, <code>@exclude</code> values and friends to <code>config.xml</code> when a script is installed. After that time, these values are not updated as the script file changes but must be changed in the &#8220;Manage User Scripts&#8221; window &ndash; or with this command.</p>

<p><strong>Caveats:</strong> The command replaces the metadata values with the script values. This means that if you&#8217;ve e.g. changed <code>@include</code>s in &#8220;Manage User Scripts&#8221; but not in the script itself, your modifications are lost.</p>

<p>Greasemonkey uses the <code>@name</code> and <code>@namespace</code> to uniquely identify a script. If you change these values in <code>config.xml</code>, it will be considered a different script than before &ndash; so if you later install a script with the old name, that script will not replace the one you have.</p>

<p> Also, it will not recognize any values defined with <code>GM_set()</code> using another script name.</p>

<h5>Uninstall Script</h5>
<p>Uninstalls the currently open script and moves it to Trash, then closes the buffer. Prompts for confirmation first.</p>

<p>No keyboard shortcut by default.</p>

<p><strong>Caveat:</strong> Doesn&#8217;t remove any data set by the script using <code>GM_setValue</code>.</p>

<h5>Upload to Userscripts.org (&#x2318;U)</h5>
<p>Sends the currently open script to <a href="http://userscripts.org">Userscripts.org</a>, as a new contribution or as an update.</p>

<p>You will be prompted for your log-in details the first time you run this command. After that, you are prompted only if a log-in fails.</p>

<p>If the name of the script matches the name of a single remote script, an update will be performed automatically. If there are no remote scripts, the script will automatically be posted as new. In all other cases &ndash; if there is no remote script with this name, or multiple remote scripts with this name &ndash; you will be prompted whether to add as new or update, with the most probable option pre-selected.</p>

<p>The list of remote scripts to update is sorted by increasing <a href="http://en.wikipedia.org/wiki/Damerau-Levenshtein_distance">minimum edit distance</a> &ndash; how similar the name is to that of the currently open script.</p>

<p><strong>Caveats:</strong> Your username and password are stored in plain text as <code>~/Library/Preferences/com.macromates.textmate.gmbundle.plist</code>, which is not the best of security.</p>

<p>There is currently no interface to reset or change valid log-in details. If you want to do those things, delete or modify the preference file manually, or trigger a failed log-in by temporarily changing your Userscripts.org password.</p>

<h5>Reload Firefox (&#x2318;R) <span id="reload_firefox"></span></h5>
<p>Hit &#x2318;R to activate Firefox and reload the current page, typically after making changes to a script. The file is saved automatically before reloading.</p>

<p><strong>Caveats:</strong> Either &#8220;Enable access for assistive devices&#8221; must be on, <em>or</em> Firefox should not be configured to open URLs from external applications in new tabs. If neither is true, the command will not be able to reload Firefox.</p>

<h5>Reload Firefox and Return (&#x21E7;&#x2318;R)</h5>
<p>Activates Firefox and reloads the current page, then returns focus to TextMate after 5 seconds. Useful to check the result of script changes that aren&#8217;t about lengthy interaction.</p>

<p>Modify the command with the bundle editor (<code>Bundles &gt; Bundle Editor &gt; Edit Commands…</code>) to change the delay.</p>

<p><strong>Caveats:</strong> Same as for <a href='#reload_firefox'>Reload Firefox</a>.</p>

<h5>Manage GM_Values</h5>
<p>Opens <code>about:config</code> in Firefox and filters by the script being edited, exposing any <code>GM_setValue()</code> values to view and edit.</p>

<p><strong>Caveats:</strong> &#8220;Enable access for assistive devices&#8221; must be toggled on in the Universal Access prefpane, otherwise filtering will not work.</p>

<p>Does not handle all weird characters properly.</p>

<h5>Comment/Uncomment GM_logs</h5>
<p>In the selection or else the entire document, all <code>GM_log()</code> function calls are commented out if any were uncommented; otherwise all <code>GM_log()</code> function calls are uncommented.</p>

<h5>Remove GM_logs</h5>
<p>Removes all <code>GM_log()</code> function calls in the selection or else the entire document.</p>

<h5>Documentation for Word / Selection (&#x2303;H) <span id="documentation_for_word_selection"></span></h5>
<p>Opens a web window with documentation for the currently focused or selected word.</p>

<p>This is an extended version of the command from the JavaScript bundle, but with support for Greasemonkey constructs.  </p>

<h5>Resources (&#x2303;&#x2325;&#x2318;H)</h5>
<p>Invoking &#x2303;&#x2325;&#x2318;H opens a menu where you can choose a help resource by clicking or pressing the listed number.</p>

<p>The resources are </p>

<ol>
<li><a href="http://developer.mozilla.org/en/docs/DOM:element#Properties">Gecko DOM Element</a></li>
<li><a href="http://www.w3schools.com/xpath/">XPath</a></li>
<li><a href="http://wiki.greasespot.net/Main_Page">GreaseSpot Wiki</a></li>
<li><a href="http://userscripts.org/forums/1">Forum: US.O Script Development</a></li>
<li><a href="irc://irc.freenode.net/javascript">IRC: #javascript@Freenode</a></li>
</ol>

<p>The Userscripts.org forum opens in your default browser, and the IRC link in your IRC client, if you have one. The other pages open in a web window.</p>

<h5>Help</h5>
<p>This document in a web window.</p>



<h4>Credits</h4>
<p><a href="http://adamv.com/dev/textmate/greasemonkey">Originally</a> by Adam Vandenberg, who wrote most of the grammar and a few snippets.</p>

<p>The <a href='#documentation_for_word_selection'>Documentation for Word / Selection</a> command is originally by <a href="http://subtlegradient.com/">Thomas Aylott</a>, I think.</p>

<p>Improved by and currently maintained by <a href="http://henrik.nyh.se/">Henrik Nyh</a> who added a bit of everything. </p>

<p>Any part of the bundle is free to modify and redistribute with due credit unless otherwise noted.</p>
