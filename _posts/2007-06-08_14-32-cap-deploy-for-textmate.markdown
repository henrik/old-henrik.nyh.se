--- 
wordpress_id: 148
title: "\"cap deploy\" command for TextMate"
tags: 
- Ruby
- OS X
- TextMate
- Ruby on Rails
- Shell scripting
- Capistrano
---
<a href="http://www.capify.org/">Capistrano</a> allows you to, among other things, deploy a Ruby on Rails app with a simple <code>cap deploy</code>, abstracting away having to check out code, restart servers etc.

It's just ten characters to write in a terminal, but I still wanted a "cap deploy" command in TextMate, so I don't have to switch between apps. I was a bit surprised to find no one had made and shared such a command already, but I wrote one myself.

<p class="center"><img src="http://henrik.nyh.se/uploads/capmate-deploy.png" alt="" /></p>

The command can be downloaded as <a href="http://henrik.nyh.se/uploads/cap%20deploy.tmCommand">cap deploy.tmCommand</a>. Right-click and save, then double-click the downloaded file. It should slip into the Rails bundle.

After having written this command, I think I understand why no one had before. Assuming you want incremental output as the deployment progresses, things get a bit tricky.

<!--more-->

The code (with save: nothing, input: none, output: show as HTML, no scope selector) is

{% highlight bash %}
# By Henrik Nyh <http://henrik.nyh.se/> 2007-06-08
# Free to modify and redistribute with credit.
#
# If you get errors, make sure to set your PATH in ~/.bash_profile per
# http://www.macromates.com/textmate/manual/shell_commands#search_path.
# Adding /opt/local/bin (where it is for me) to avoid having to do this.
export PATH="/opt/local/bin/:$PATH"

. "${TM_SUPPORT_PATH}/lib/webpreview.sh"

html_header "CapMate" "$TM_PROJECT_DIRECTORY"

cd "$TM_PROJECT_DIRECTORY" 2> /dev/null
require_cmd cap
[ -d app/controllers ] || exit_show_html "Not in a Rails project!"

ruby -e 'class << STDERR; alias_method :old_puts, :puts; def puts(m); old_puts(m.strip); Kernel.puts; end; end; load(`which cap`.strip);' deploy | pre

html_footer
{% endhighlight %}

Capistrano buffers its output. After trying a whole lot of different things, the only thing that actually worked to get unbuffered, incremental output was the Ruby kludge above. <code>STDERR.puts</code>, which the Capistrano logger uses for output, is monkey-patched to run <code>Kernel.puts</code> after each piece of output.

I only started playing with Capistrano yesterday. If I find I use more of Capistrano regularly, I might write more TextMate commands, but I've no such plans at this time. If you need more commands, feel free to write and distribute your own with this as a starting point.

<div class="updated">
<h5>Update 2007-06-10</h5>
Added quotes around shell variables. Thanks, <a href="http://macromates.com/">Allan</a>.
</div>
