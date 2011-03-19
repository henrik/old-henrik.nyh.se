---
title: Vim Ruby Runner
tags:  [Vim, Ruby]
---

When I [switched to Vim from TextMate](/2011/01/textmate-to-vim-with-training-wheels), I missed TextMate's <code class="kb">⌘R</code> command to execute a Ruby script and show the output.

There are ways to execute Ruby code from a Vim buffer, such as `:w ! ruby` or `:! ruby %`, which you could map to any shortcut, but they have annoying limitations.

Hence, I've been tinkering with a better solution for a while in [my dotfiles](https://github.com/henrik/dotfiles). It finally felt mature enough to pack into a plugin, so I did:

[![Screenshot](http://dl.dropbox.com/u/546793/blog/RubyRunner.png)](https://github.com/henrik/vim-ruby-runner)

Get it from GitHub: <https://github.com/henrik/vim-ruby-runner>


## Usage

The default keybindings are only available in buffers with filetype `ruby`. I recommend defining a command in your `~/.vimrc` like

    command! FR set filetype=ruby

so you can set that filetype with a simple `:FR`.

When you have a Ruby buffer, <code class="kb">⌘r</code> (lowercase r) will execute its contents (even if it is an unnamed, unsaved buffer) as Ruby code and output the results into a new split buffer.

The output buffer gains focus, and you can hit <code class="kb">⌘r</code> again to close it.

<code class="kb">⌘R</code> (capital R, so <code class="kb">⇧⌘r</code>) will keep focus in the input buffer.
If you're in input mode, you'll even stay in that mode. So you can keep hitting <code class="kb">⌘R</code> as you type, any time you have valid Ruby code.

Just like with `:help`, one and the same output buffer is reused per tab page.


## Comparison and caveats

The main benefit in comparison to the TextMate command is, of course, that it runs in Vim ;)

In some ways, though, this plugin compares unfavorably to TextMate.

Whereas TextMate will show you output incrementally, I [haven't been able](http://stackoverflow.com/questions/5329931/in-vim-can-i-stream-the-output-of-e-g-w-ruby-into-a-buffer-line-by-line) to find a good way to achieve that in Vim.
The Vim window will be unresponsive while the script executes, and will only show the output all at once after completion.

Also, script execution does not wait for `gets`. The value of any `gets` will be nil.


## Alternatives

If you need to see incremental output, you could instead do

    :w ! ruby

That very command is at the heart of the plugin, but it only outputs incrementally when run on its own.
Be aware that you get the output below the command line, not in a buffer, and have to discard it to be able to continue using Vim.

You could also write to an output file on disk and tail that from a terminal, with e.g. (in Vim):

    :w ! ruby > /tmp/out.txt

and (in a terminal):

    tail -f /tmp/out.txt

Or you could [tail in Vim](http://stackoverflow.com/questions/5329931/in-vim-can-i-stream-the-output-of-e-g-w-ruby-into-a-buffer-line-by-line/5330279#5330279), but that doesn't seem to work perfectly.

The Vim wiki has [an article](http://vim.wikia.com/wiki/Preview_output_from_interpreter_in_new_window) on a command a little like this plugin, but that lets you run only visually selected lines. I may attempt to copy that feature.

A completely different approach is [to launch Vim from IRB](http://vimcasts.org/episodes/running-vim-within-irb/), edit in Vim and execute in IRB. I've had that set up for a while, but haven't found myself using it in practice.


Please try the plugin and suggest or contribute improvements. If you use something else, feel free to share in the comments.
