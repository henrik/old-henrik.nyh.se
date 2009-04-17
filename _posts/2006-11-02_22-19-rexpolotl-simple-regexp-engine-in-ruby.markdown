--- 
wordpress_id: 76
title: "Rexpolotl \xE2\x80\x94 simple regexp engine in Ruby "
tags: 
- Ruby
- Regexps
---
I wrote a very basic, not very efficient (not intended to be) regular expression engine in Ruby for a class I'm taking.

<!--more-->

Coming up with regexp engine names is a lot of fun. I call this one Rexpolotl, named after the amazing <a href="http://en.wikipedia.org/wiki/Axolotl">axolotl</a>. Some other names I considered were "Rexp, drugs and rock'n'roll" and "Tyrannosaurus Rexp".

Rexpolotl matches entire strings, so it will tell you if some string corresponds in its entirety to some regular expression (i.e. if the string is part of the regular language expressed). It does not extract or replace.

It handles 8-bit characters (e.g. ASCII and Latin-1), grouping (parentheses), repetition (the Kleene star), concatenation (characters/groups/repetitions in sequence) and alternation (the pipe character). So <code>(a|b)*c</code> is handled, as well as more (or less) complex expressions made out of the same sub-expression types.

I wrote it mainly to get some idea of how a regexp engine works. There is a lot of stuff that could be more efficient, but hopefully the lack of optimization makes the implementation more readable and easier to grasp.

The code is available as a <a href="http://stp.lingfil.uu.se/~henrikn/rexpolotl/rexpolotl.zip">zip archive</a>. <code>rexpolotl.rb</code> will run a test case if executed directly.
