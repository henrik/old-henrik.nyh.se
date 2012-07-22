# This repo has been abandoned!

[Please see my new blog repo.](http://github.com/henrik/octopress)

# The Pug Automatic

This directory contains data for my blog, [The Pug Automatic](http://henrik.nyh.se).

It's automatically transformed by my mutated version of [Jekyll](http://github.com/henrik/jekyll) (Hyde? Mr. Haml?) into a static site. Jekyll was created by [Tom Preston-Werner](http://tom.preston-werner.com/).


## Setup

I keep my version of Jekyll in `~/Projects/jekyll` and add its `bin` dir to my `PATH`:

    export PATH=~/Projects/jekyll/bin:$PATH

Install gem dependencies:

    gem install bundler
    bundle

Install Pygments for syntax highlighting:

    sudo easy_install Pygments

Generate blog with:

    jekyll

The `config.ru` files means you can see the generated site locally with [Pow](http://pow.cx/) or any other Rack-compatible server. Or use Apache.

If it looks fine, generate and deploy with:

    tasks/deploy


## License

The following directories and their contents are copyrighted by me, Henrik Nyh, unless otherwise mentioned. You may not reuse anything in them without my permission:

* _posts/
* images/

All code of mine in the posts is under the MIT License unless otherwise mentioned.

The pug artwork is copyrighted by [Johanna Öst](http://johannaost.com), great illustrator and girlfriend.

All other directories and files are under the MIT License, but I ask that you do not use this exact design for another site (you can't have the pug, anyway). The design is based on MIT-licensed work by [Tom Preston-Werner](http://tom.preston-werner.com/).
