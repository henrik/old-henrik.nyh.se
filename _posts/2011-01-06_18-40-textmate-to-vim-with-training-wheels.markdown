---
title: TextMate to Vim with training wheels
tags:  [Vim, TextMate]
---

![Screenshot](http://dl.dropbox.com/u/546793/blog/MacVim.png)

I switched from Windows to OS X four years ago mostly because of [TextMate](http://macromates.com).

Then of late I became increasingly curious about [Vim](http://en.wikipedia.org/wiki/Vim_%28text_editor%29).
Every now and then there's a blog post about someone switching from TextMate and loving it.
At work my Vim-wielding colleagues split windows with abandon.

So I tried Vim a few times, but never lasted the day.

It was less about the weird modal model (slicing and dicing text in command mode, writing new text in insert mode) and more that I couldn't get to the right file fast enough.
In TextMate, I would use <code class="kb">⌘T</code> to quickly jump to a deeply-nested file by name, or use project-wide search to get it by content. You can have both these things in Vim, but they were tricky to set up or to grasp. I'd feel unproductive enough that I couldn't make myself continue.

## MacVim and Janus

Then about a month ago, I read Daniel Fischer's ["A Starting Guide to VIM from TextMate"](http://blog.danielfischer.com/2010/11/19/a-starting-guide-to-vim-from-textmate/). He describes a setup with [MacVim](http://code.google.com/p/macvim/), a port of Vim that is well-integrated with OS X; and [Janus](https://github.com/carlhuda/janus), a "MacVim distro", or set of plugins and ready-made configurations.

In ["Everyone Who Tried to Convince Me to use Vim was Wrong"](http://yehudakatz.com/2010/07/29/everyone-who-tried-to-convince-me-to-use-vim-was-wrong/), Yehuda Katz, co-author of Janus (and Ruby on Rails, jQuery etc), echoes my experience. Coming from TextMate and starting out with plain Vim means starting out unproductive. Instead, use MacVim and various plugins so you can start out closer to where you are now. Then as you learn Vim better, you can shed the training wheels.

I've now been using Vim as my main editor for just over a month, following that method.

I was on the fence for a few weeks, but as I've learned Vim better, used more features and customized it further, I now feel at least as productive as I did in TextMate, and with much more room to grow.

I highly recommend everyone using TextMate to try MacVim with Janus.


## Training wheels

MacVim gives you OS X features like <code class="kb">⌘S</code> to save, <code class="kb">⌘C</code> and <code class="kb">⌘V</code> for copy and paste, a proxy icon in the menu bar to drag-and-drop or right-click for the folder hierarchy, a dot in the red "close" button to indicate unsaved changes. You can position your caret with the mouse, or drag to resize splits.

Do beware, though – if you get into the habit of saving with <code class="kb">⌘S</code>, you will be very annoyed when you use command-line Vim in Terminal.app and constantly trigger "Export Text As…" instead. And while the Vim model of copy and paste is confusing at first, with deletions being "copied" as well, and everything going into various registers, you should eventually try it out. Placing the caret by mouse is easy, but there is probably a Vim command that will get you there faster without your hands leaving the keyboard. Remember, training wheels.


## Equivalent features

MacVim with Janus has a lot of the features TextMate is known for.

There is a `mvim` command-line binary much like `mate`.

You have things like snippets, auto-balancing quotes, folds, macros, bookmarks. They're generally fairly easy to use in the way you would in TextMate, but have a lot more power if you want to take things to the next level.

As an example, `mm` will insert a bookmark named "m" and `'m` will jump back to it. This is about the feature set of TextMate, except that bookmarks have names. But then you have both file-local and global marks, can list marks, have various automatic marks such that e.g. `'.` will jump to the position where the last change was made, and more. See `:help mark-motions`.

Janus includes the NERDTree plugin which is similar to the TextMate drawer. You can move it around like any other Vim split. It is completely keyboard-driven, with commands like `o` to open a directory, `O` to recursively open, `p` to go to parent directory, `P` for root.

Instead of <code class="kb">⌘T</code> you have the Command-T plugin. Unlike TextMate, it lets you filter by directory, not just filename. So if you're looking for `my_controller/show.html.erb` and not the other dozen `show.html.erb` files, just filter with something like `my/sh`.

For searching in a project, there's the Ack.vim plugin. Project search is Vim's Achilles' heel, in my opinion. On the plus side, typing `:Ack "search term" app/models` (Janus lets you hit <code class="kb">⇧⌘F</code> to produce `:Ack `) to limit your search to a certain directory is very nice. Beats clicking a folder in the drawer. On the minus side, having to quote a multi-word search term is a little annoying. The list of results is not displayed as nicely as in TextMate. I've yet to find a project search-and-replace solution I like. Then again, I rarely used that in TextMate because its project search gets unusably slow for large projects.

Furthermore, when you use Vim's commands to search or search-and-replace within a single document, you have to use a weird regular expression flavor. An expression like `\bfoo\b` becomes `<foo>`, and that's assuming you've customized Vim to use "very magic" mode for search – otherwise you have to specify that (`\v<foo>`) or escape the brackets (`\<foo\>`). I'm guessing this is another case of "different but very powerful", but the transition is harsh.

That said, this has been a surprisingly minor annoyance so far, far outweighed by other things.


## Things to love about Vim

I fall in love with new Vim features every day. These are just a few of the things I love:

Vim has a **powerful, extensive and fairly memorable set of primitives with a combinatorial explosion of uses**. If I want a line of 80 dashes in TextMate, I might type ten dashes, copy it and paste seven more times. If I do it a lot, I may define a snippet or command. In a vanilla Vim:

    80i-<Esc>

That's not a special purpose plugin, just putting commands together. `i-<Esc>` goes into insert mode, writes a dash and then leaves insert mode again. An optional prepended count will repeat the action.

If I want to turn

    Hello world

into

    Hello world
    ===========

in Vim, I could type

    YpVr=

`Y` to copy (yank) the line, `p` to paste it below, `V` to select that line, `r=` to replace each character with "=".

And since you can do a lot of things with the primitives, there's little need for TextMate's modifier-heavy keyboard shortcuts.

Vim has **operators and motions**, which are particularly lovely primitives that let you manipulate text with a kind of action-object model. If I have the text

    function("some text")

and my caret is somewhere inside the quotes, `ci"` (change inside quotes) will delete the text inside the quotes and enter insert mode, so I can type something else. Like so:

    function("|")

If I instead do `ca"` (change around quotes), it will also delete the quotes:

    function(|)

I could achieve the same thing with `ci(` (change inside parentheses).

If I have the text

    Lorem ipsum dolor. Sic amet.

with my caret somewhere in "ipsum", I could do `ciw` (change in word) to delete that word and enter insert mode to type another word. Or maybe `daw` (delete around word) to delete the word and its trailing whitespace. Or `das` to delete the entire sentence, or `dap` to delete the entire paragraph.

So `c`(hange) or `d`(elete) is the operator, the action I want to perform; and `iw` is the motion, describing the scope or object of that action.

These are just some examples. Instead of `c`, I could invoke actions like `>` (indent), `gU` (make uppercase) and many more. Instead of the motion `iw`, I could use `tx` (till the next letter "x"), `/foo↩` (until the next match of a regular expression), `)` (until the end of the sentence), `'m` (until the mark "m") and more.

There are plugins that add motions like ["at this indentation level"](http://www.vim.org/scripts/script.php?script_id=3037) or ["in this Ruby block"](http://www.vim.org/scripts/script.php?script_id=3382).

And, of course, motions take a count, so `2c)` or `c2)` will change two sentences ahead.

See `:help motion.txt` for more.

Vim also has **cheap splits**. I can very easily open multiple files side by side, or even different parts of the same file.

This is incredibly handy for things like editing code and test, controller and view, a set of translation files or anything else you want to see at the same time.

Plugins like Command-T and Rails.vim let you easily open splits. In Command-T, finding a file and hitting `⌃s` will open it in a split. In Rails.vim, e.g. `:AS` will open a related test in a split.

While TextMate does let you open files in a new window, it's far from as convenient and pervasive.


## Installation

I recommend installing MacVim with the [Homebrew](http://mxcl.github.com/homebrew/) package manager. [Install Homebrew](https://github.com/mxcl/homebrew/wiki/installation) if you don't have it, then just

    brew install macvim

If you're not happy with the default icon, I like this one by [Miguel A. Cardona Jr.](http://sketchbooked.net/):

<p class="center">
  <a href="http://dl.dropbox.com/u/546793/blog/MacVim.icns"><img src="http://dl.dropbox.com/u/546793/blog/MacVim.icns.png" alt="Download"></a>
</p>

You'll find MacVim.app under `~/.homebrew/Cellar/macvim/HEAD`.

If you will use Vim on the command line as well, I'd recommend making sure you use MacVim's version of Vim instead of the one that ships with OS X. Not only is it a newer version (7.3 instead of 7.2), but it's also compiled with more features like support for writing Vim commands in Ruby.

Get MacVim's Vim binary on the command line by symlinking the `mvim` binary to `vim`, e.g.:

    ln -s ~/.homebrew/bin/mvim ~/.homebrew/bin/vim

Make sure this directory is earlier in your `$PATH` path than `/usr/bin` is.

Install Janus with

    curl https://raw.github.com/carlhuda/janus/master/bootstrap.sh -o - | sh

The install script will rename (not overwrite) any pre-existing Vim dotfiles.

Though I started out with Janus, I have made a lot of customizations.
[My dotfiles](https://github.com/henrik/dotfiles) are available on GitHub.
If you see something you like, you can create a `~/.vimrc.local` or `~/.gvimrc.local` which Janus will load. Or just fork and modify the existing dotfiles.

If you set up your own dotfiles from scratch, I very much recommend using [Pathogen](http://www.vim.org/scripts/script.php?script_id=2332) so each plugin keeps to its own directory instead of putting files all over the place. It goes well with Git submodules.


## Learning Vim

Give it a few days. It's very different paradigm, but you will get used to it, and probably come to love it.

For an interactive tutorial to get you started, try this from the command line:

    vimtutor

Once you have the basics down, push yourself to use new Vim motions and commands, even though it may slow you down at first. If you don't think you're doing something in the optimal way, you're probably right – look it up.

One of the best features of Vim is the thorough help system. In Vim, just type e.g. `:help x` (`:h x` for short) to learn more about some command or topic.

There are tons of resources. Read blog posts, see the [Vim Tips Wiki](http://vim.wikia.com/), get help on the friendly `#vim` IRC channel on Freenode, learn new things from the [Vimcasts](http://vimcasts.org/) videos.

When you feel up to it, challenge yourself with some [VimGolf](http://vimgolf.com/). It's fun, instructive and quite addictive.

If you do switch to Vim after reading this, or already switched, I'd love to hear about it in the comments!
