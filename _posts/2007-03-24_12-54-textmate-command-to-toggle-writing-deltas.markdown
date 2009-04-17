--- 
wordpress_id: 120
title: TextMate command to toggle writing deltas
tags: 
- OS X
- TextMate
---
<img src="http://henrik.nyh.se/filer/TMBundle.png" alt="" class="left" />

<a href="http://macromates.com/">TextMate</a>'s bundle system is pretty cool. If you make modifications to bundles, the difference is written as deltas to <code>~/Library/Application Support/<wbr />TextMate/<wbr />Bundles</code>. The original bundle is kept in its unchanged, pristine state – inside the TextMate application, in <code>~/Library/Application Support/<wbr />TextMate/<wbr />Pristine Copy/Bundles</code> if downloaded and installed, or in <code>/Library/Application Support/<wbr />TextMate/<wbr />Bundles</code> if you did a SVN checkout. (See <a href="http://blog.circlesixdesign.com/2007/03/02/textmate-bundles-explained/">this post</a> for a fuller explanation of where bundles go and why.)

Since your local changes are kept apart from the distributed bundle, updates by the bundle author do not overwrite your own changes, and all is well.

But what if you <em>are</em> the bundle author?

<!--more-->

<h4>Developing bundles</h4>

If you distribute the bundle as a web download, you can just drag-and-drop it from the Bundle Editor to the desktop, zip it up and share. The bundle you share will include any local changes.

If you version control a bundle you're developing, though, you probably don't want deltas, but to have any changes made in the Bundle Editor written directly to the bundle itself. This is achieved by keeping the bundle in <code>~/Library/Application Support/<wbr />TextMate/<wbr />Bundles</code> (which is, incidentally, where bundles go when you do "New Bundle" in the Bundle Editor). No deltas are created; all changes are written directly to the bundle.

But sometimes you <em>do</em> want deltas. For my <a href="http://henrik.nyh.se/2007/03/textmate-greasemonkey-bundle-in-official-repository/">Greasemonkey bundle</a>, I want TextMate-global keyboard shortcuts for some stuff (creating a new userscript from template, opening an installed userscript), but bundles should not be <em>distributed</em> with TextMate-global keyboard shortcuts unless it's necessary (e.g. the Subversion bundle).

To be able to easily switch between writing changes as deltas and writing changes to the bundle proper would be quite useful. So I wrote a TextMate command for this.

<h4>The command</h4>

Download: <a href="http://henrik.nyh.se/filer/MyBundle%20Toggle%20Deltas.tmCommand">MyBundle Toggle Deltas.tmCommand</a>.

<img src="http://henrik.nyh.se/filer/gm_toggle_deltas-growl.png" alt="" class="right" />

The command assumes you keep the bundle in <code>~/Library/Application Support/<wbr />TextMate/<wbr />Bundles</code>. When run, the command switches the deltas and the complete bundle between that directory and <code>Pristine Copy/Bundles</code>. When the deltas are in the non-pristine directory, any changes you make become deltas, and local changes (e.g. my global keyboard shortcuts) are available to use and modify. When the deltas are in the pristine directory, they are ignored. Changes are written directly to the bundle, and your personal, local changes are not available.

The command requires you have <a href="http://growl.info/">Growl</a> installed, with <a href="http://growl.info/documentation/growlnotify.php">growlnotify</a> – it informs you of the current editing mode with a Growl notification. The notification is sticky, meaning it doesn't go away until you click it. The idea is to keep you aware of the current mode.

You need to edit the command to specify the name of the bundle in question. I only maintain one bundle, so the command only handles one. You can simply create several copies of the command, one for each bundle.

The code:

{% highlight ruby %}
#!/usr/bin/env ruby
require "#{ENV['TM_SUPPORT_PATH']}/lib/escape"

BUNDLE = "MyBundle"

GROWLNOTIFY = "/usr/local/bin/growlnotify"
TM_SUPPORT_DIR = "#{ENV['HOME']}/Library/Application Support/TextMate"
DIRTY = "#{TM_SUPPORT_DIR}/Bundles/#{BUNDLE}.tmbundle/"
PRISTINE = "#{TM_SUPPORT_DIR}/Pristine Copy/Bundles/#{BUNDLE}.tmbundle/"
LIMBO = "#{TM_SUPPORT_DIR}/#{BUNDLE}.tmbundle/"

def writing_deltas?
  not `find #{e_sh DIRTY} -regex ".*\.tmDelta$"`.empty?
end
def reload_bundles!
  `osascript -e 'tell app "TextMate" to reload bundles'`
end
def mv(from, to)
  `mv #{e_sh from} #{e_sh to}` if File.exist?(from)
end

reload_bundles!  # Reload before moving, so any pending changes are (I hope) written to the right place
mv(DIRTY, LIMBO); mv(PRISTINE, DIRTY); mv(LIMBO, PRISTINE)
reload_bundles!

title = "#{BUNDLE}: #{writing_deltas? ? "Deltas" : "Distribution"}"
message = if writing_deltas? 
  "Changes become deltas and are only available locally."
else
  "Changes are written directly to the distributed bundle; local changes are unavailable."
end

`#{e_sh GROWLNOTIFY} -s --icon="tmbundle" -t #{e_sh title} -m #{e_sh message}`
{% endhighlight %}

Bug reports and suggestions are very welcome.

<div class="updated">
<h5>Update 2007-03-31</h5>

Switching the bundles does not reload the grammar used for currently open documents: if you've made local grammar modifications, switching into or out of those modifications won't actually change any scopes (or highlighting) in open documents. You have to open the Bundle Editor and click "Test" next to the grammar to change scopes/highlighting. This is a TextMate limitation.
</div>
