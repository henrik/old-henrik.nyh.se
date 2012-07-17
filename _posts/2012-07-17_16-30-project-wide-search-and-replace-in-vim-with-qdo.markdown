---
title: Project-wide search-and-replace in Vim with Qdo
tags:  [Vim]
---

In [my blog post about switching to Vim](/2011/01/textmate-to-vim-with-training-wheels), I mentioned that I had yet to find a project-wide search-and-replace solution that I like.

Now I have: I use [git-grep-vim](https://github.com/henrik/git-grep-vim) for project-wide search, then [vim-qargs](https://github.com/henrik/vim-qargs) to run a vim search-and-replace command over every result file.


## Less convenience, more power

I think it's unlikely that Vim will have a solution any time soon fully as convenient and well-integrated as in more modern editors. The per-buffer find-and-replace in Vim is dusted with enough special Vim magic that it won't match up perfectly with the syntax of project-wide search tools like ack, grep or git-grep. And in a large project, you need fast tools like those.

So while I don't know of a solution that is on par with the convenience of search-and-replace in other editors, I do consider this one more convenient than switching to another editor – for a while I used TextMate alongside Vim for project-wide find-and-replace.

And as usual with Vim, you get a lot of power you may not find in those other editors.


## Project-wide search with git-grep

I use [my fork of git-grep-vim](https://github.com/henrik/git-grep-vim) for project-wide search in Vim.

It's based on [ack.vim](https://github.com/mileszs/ack.vim/) but uses git-grep instead of ack.

You search like this:

{% highlight vim %}
:GitGrep some.*pattern
{% endhighlight %}

You can optionally specify one or several directories to limit the search to:

{% highlight vim %}
:GitGrep some.*pattern app/models lib spec
{% endhighlight %}

And pass in flags (`-w` makes it match only at word boundaries):

{% highlight vim %}
:GitGrep -w hello
{% endhighlight %}

Add the results of a new search to the existing result list:

{% highlight vim %}
:GitGrep hello
:GitGrepAdd goodbye
{% endhighlight %}

With multiple words or some special characters, quote the search string:

{% highlight text %}
:GitGrep "hello there"
{% endhighlight %}

Or cheat to save some typing (the regex `.` matches any character, including a space):

{% highlight vim %}
:GitGrep hello.there
{% endhighlight %}

To save some typing, this line in my `~/.vimrc` brings up the search prompt when I hit `,a` (the "a" was for "ack", once):

{% highlight vim %}
" We want the trailing space.
exe "nnoremap <leader>a :GitGrep "
{% endhighlight %}

As long as you're in a Git repository, I much prefer git-grep to ack. It's faster, and [ack will ignore unknown filetypes (like Haml) unless reconfigured](https://github.com/protocool/ack-tmbundle/wiki/recognizing-files).

That said, git-grep can also mislead. It won't find results in new files before they've been added to Git, or in `.gitignore`d files, and as mentioned, it only works in directories managed by Git. You can trade in some speed for removing these gotchas with the [flags](http://www.kernel.org/pub/software/scm/git/docs/git-grep.html) `--untracked`, `--no-exclude-standard` and `--no-index`.

I use project-wide search all the time. It's not just for search-and-replace, of course.


## The quickfix window

![Screenshot](https://dl.dropbox.com/u/546793/blog/git-grep-quickfix.png)

The search results end up in [the quickfix window](http://vimdoc.sourceforge.net/htmldoc/quickfix.html), a split window in Vim that you can move through like any Vim buffer. Hitting `⏎` will show the result from the current line.

There's a bunch of commands to open items from the quickfix list, without even needing to have it open (close it with `:cclose`).

I've mapped the `+` and `-` keys to `:cnext` and `:cprevious`, for skipping one item at the time. I've mapped `g+` and `g-` to `:cpfile` and `:cnfile`, for skipping one *file* at the time.

Some of my favorite commands for the quickfix list are `:colder` and `:cnewer`, to revisit the previous or next item list. This means you can run one project search for "foo", notice some issue with bars, search for "bar", do stuff, then run `:colder` and you're back in the "foo" search. It's effectively a stack of project searches to pop and push at leisure.


## Qdo

Vim has a couple of commands like `:bufdo` and `:windo`, which let you run a command in every open buffer or window. Drew Neil (of [Vimcasts](http://vimcasts.org/) and [Practical Vim](http://pragprog.com/book/dnvim/practical-vim)) with other contributors [wrote a :Qargdo](http://stackoverflow.com/a/5686810/6962) for when you want to run a command against every file in the quickfix list.

[My fork of vim-qargs](https://github.com/henrik/vim-qargs) uses the conveniently short `:Qdo` for the same.

For project-wide search-and-replace, then, you would simply do something like this:

{% highlight text %}
:GitGrep foo.*bar
:Qdo %s/foo.*bar/baz
{% endhighlight %}


## The upside of separate steps

It is, of course, a bit inconvenient to repeat the search string. But because the syntax of git-grep (or some other tool) will often diverge from the Vim search syntax, I've settled for typing the search string twice rather than having it automatically reused.

While I would prefer to only type the search string once in the common case, there is an upside to having separate steps for the global find and the local search-and-replace, and that's flexibility.

You have your choice of global search tool, with their different features and trade-offs. The raw speed of git-grep in a Git repository is a wonderful thing. With `:GitGrepAdd` you can search for "x" in directory a plus "y" in directory b.

And on the other end, you get all the magic (or nomagic) of Vim. Though I don't think I've used it with `:Qdo` yet, you could apply some complex macro and not just a substitution.

One thing I have done is chain multiple substitutions (replace "a" with "b" if present and then "c" with "d" if present), which I think would be more difficult with a more convenient but less flexible setup.


## Fin

I'm curious to hear what others use. Let me know!
