---
title: Tests on demand using Vimux and Turbux with Spork and Guard
tags:  [Testing, Ruby, Ruby on Rails, Vim, tmux]
---

![Screenshot](https://dl.dropbox.com/u/546793/blog/vimux-spork.png)

My development environment these days is [Vim](http://henrik.nyh.se/2011/01/textmate-to-vim-with-training-wheels) inside [tmux](http://blog.hawkhost.com/2010/06/28/tmux-the-terminal-multiplexer/).

Among other benefits (which I may write about later), this lets me split my terminal so I can run tests right next to my editor.

I used to run tests with [Guard](https://github.com/guard/guard/). You start it in a terminal with `guard`, and when it detects that you saved a file, it runs the corresponding test. In your project's `Guardfile`, you can map files to tests any way you please. Typically, you'll have `models/user.rb` trigger `spec/models/user_spec.rb` and so on. You might also, for example, have it run `user_spec.rb` whenever you modify `user_factory.rb`.

There's also [Spork](https://github.com/sporkrb/spork/), which loads your app up in a test server, so you don't have to wait for it to load on every test run. [Guard::Spork](https://github.com/guard/guard-spork) helps Guard make use of Spork.


## The downsides of Guard

While wonderful in theory, Guard can get annoying.

If you're fixing a failing integration test, you may alternate between that test and the integrating classes. Any time you modify and save one of the integrating classes, its tests will run. If they're not lightning-fast, it quickly gets frustrating waiting for them to complete so you can run the integration test.

Or perhaps you make some trivial change to a file, such as tweaking copy or stripping trailing whitespace, and that triggers a test run that you'd rather not wait for.

When you switch branches or rebase, Guard may detect changed files and cause their tests to run.

If you save one file while another test is running, it's queued up. This means that a series of small tweaks can cause a bunch of tests to run, whether you want them to or not.

Sometimes, Guard gets the idea that you probably want to run all the tests, when you really don't.

It happens that you accidentally forget you have a Guard running and start a second one, causing conflicts in tests that hit the database.

Also, sometimes Guard's file detection gets choked up for whatever reason and won't run tests immediately when you save a file, or at all.

All this is, of course, more of an annoyance if you have a slow test suite. But it gets pretty frustrating with sub-second tests as well, as you recalibrate your impatience.

As it turns out, there's a way to get the benefits of Guard and Spork without these downsides.


## Vimux

[Vimux](https://github.com/benmills/vimux/) is a Vim plugin that lets you send commands to another tmux pane without leaving Vim.

A simple example of what it lets you do is

{% highlight vim %}
:call VimuxRunCommand("rspec spec/my_spec.rb")
{% endhighlight %}

By default, Vimux opens a new pane (and then reuses it) to run the command. As I tend to manually set up my workspace with about 80% editor on the left, 20% test runner on the right, I've configured it to just use the nearest pane instead:

{% highlight vim %}
let g:VimuxUseNearestPane = 1
{% endhighlight %}

## Turbux

Then there's [Turbux](https://github.com/jgdavey/vim-turbux) ([author's blog post](http://joshuadavey.com/post/15619414829/faster-tdd-feedback-with-tmux-tslime-vim-and)), which builds on Vimux (or a Vimux alternative called tslime.vim). Turbux adds mappings to Vim to run the test you're currently editing, with RSpec (or test-unit or Cucumber), using Vimux. What's more, it uses some [rails.vim](https://github.com/tpope/vim-rails) magic to figure out that if you're in `models/user.rb`, you want to run `spec/models/user_spec.rb`.

As I already use `,t` and `,T` for [Command-T](https://github.com/wincent/Command-T), I remapped Turbux to `,m` and `,M`:

{% highlight vim %}
let g:no_turbux_mappings = 1
map <leader>m <Plug>SendTestToTmux
map <leader>M <Plug>SendFocusedTestToTmux
{% endhighlight %}

What does `,M` (`SendFocusedTestToTmux`) do? The same as `rspec spec/my_spec.rb:123` – it tells RSpec the current line number, so it can run only the test(s) encompassing that line, and not the entire file.

Another great feature of Turbux is that if it can't figure out a test to run, it will re-run the last one. So if you modify `user.rb` and trigger Turbux, it will run `user_spec.rb`. If you then open `en.yml` to localize some user attributes, triggering Turbux will run `user_spec.rb` again.


## The benefits of Vimux and Turbux over Guard

With Turbux, you're in control of when your tests run. You can save files all you want, and the tests will only run when you tell them to. And you can tell them with a simple mapping from inside Vim. You won't be waiting for tests you didn't want to run.

There's no confusion waiting for Guard to notice your changes. Tests run in a terminal window as if you typed the commands manually, so the current state is obvious.

If you want to tweak some RSpec options (perhaps to provide a random seed) or set some environment variables for the tests, just change the command Turbux sends:

{% highlight vim %}
let g:turbux_command_rspec = 'FOO=bar rspec --order rand:123'
{% endhighlight %}

You'd have to restart Guard (including the Guard::Spork app environment) to do the same.

And because the commands are just sent to a shell in another pane, you have a lot of flexibility. If you want to try some one-off modifications to the commands, you can just edit them in that pane, using the shell history.

If you have Rake tasks to run some subset of tests, just run that task in the same pane, manually or with Vimux. You can run tests any way you like and still see them in the same tmux pane.


## Vimux without Turbux

You can use Vimux without Turbux. It's great for one-off mappings. On my Swedish keyboard, `§` is conveniently located and underused, so I do things like:

{% highlight vim %}
:map § :call VimuxRunCommand("rspec spec/some_file.rb")<CR>
{% endhighlight %}

This can be useful if you're running one integration test over and over, while modifying a bunch of different files.

Or if you want a more permanent mapping, you could do something like:

{% highlight vim %}
:call VimuxRunCommand("rspec spec/some_file.rb")
:map ,x call VimuxRunLastCommand()<CR>
{% endhighlight %}

Vimux also lets you `:call VimuxPromptCommand()` if you prefer a prompt, though the function form lets you do things like refer to the current file dynamically:

{% highlight vim %}
:call VimuxRunCommand("cat ".expand("%"))
{% endhighlight %}

Once you have Vimux in your toolbox, you'll find it's not just for running tests. I used it recently to repeatedly run a script I was working on through `rails runner`:

{% highlight vim %}
:map § :call VimuxRunCommand("rails runner some_script.rb")<CR>
{% endhighlight %}


## Using Spork

With Turbux, you're effectively running your tests in a regular terminal. Compared to Guard with Spork, this is slow, as every test run needs to load your app environment.

Luckily, Spork works fine divorced from Guard. And, indeed, married to Turbux. Just start Spork (I like to put it in a small pane in the bottom-right) and then make sure your tests connect to it. I do this in my `~/.vimrc`:

{% highlight vim %}
let g:turbux_command_rspec = 'rspec --drb'
{% endhighlight %}

That's it. As long as you have a Spork running, your Turbux test runs will use it.

It's kind of nice to have Spork separate from your test runner. If you introduce an endless loop and a test hangs, just kill the test and run it again when the issue has been fixed. The app will remain loaded in Spork. If you make changes that require Spork to restart, just restart it. If you make many such changes and Spork gets in the way, just kill Spork and keep running the tests without it. With Guard::Spork, your test running and your test server are tied together.

Guard::Spork does offer the convenience of reloading Spork automatically when necessary, like when you modify `environment.rb`. It's not something I've been missing, though. It's easy enough to restart Spork yourself when you need to.


## Using Guard

But if you do want that convenience, you can even use Vimux with Guard.

This is not what I do myself – I just use Spork as described above – but it's an interesting option that I've looked into. It gets you the Guard::Spork autoreloading as well as any special file mapping you've set up in your `Guardfile`, while you still get to decide when to trigger a run.

After starting Guard, hit `p⏎` to pause the automatic "file modification listening".

Rather than trigger when it detects modified files, Guard will now only trigger *if you tell it a file has been modified*. Add a mapping like:

{% highlight vim %}
:map ,x :call VimuxRunCommand("change ".expand("%"))<CR>
{% endhighlight %}

Then when you hit `,x`, you will send the command `change current/file.rb` to Guard, filling in the current filename. Guard will see the file as modified and do its magic.
