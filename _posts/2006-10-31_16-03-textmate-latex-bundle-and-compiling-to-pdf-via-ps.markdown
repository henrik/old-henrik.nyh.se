--- 
wordpress_id: 75
title: TextMate LaTeX bundle and compiling to PDF via PS
tags: 
- OS X
- TextMate
- LaTeX
---
I'm very far from a <a href="http://en.wikipedia.org/wiki/LaTeX">LaTeX</a> expert, but I thought I'd write this up for googleability.

If, when using the "Typeset and View (PDF)" command in the TextMate LaTeX bundle, you get error messages like

{% highlight text %}
./myfile.tex:123: Undefined control sequence. \c@lor@to@ps 
./myfile.tex:123: Undefined control sequence.\XC@@usecolor ...expandafter \c@lor@to@ps #1#2\@@ 
{% endhighlight %}

the problem can well be that that you are directly or indirectly (e.g. through <a href="http://igm.univ-mlv.fr/~lombardy/Vaucanson-G/">Vaucanson-G</a>) using the pstricks package.

<!--more-->

As implied by the name, this package needs you to turn the tex into PostScript format before turning it into a PDF (manually by e.g. <code>latex myfile.tex && dvips myfile.dvi -o myfile.ps && ps2pdf myfile.ps</code>). The TextMate command turns the tex into PDF directly using <code>pdflatex</code>.

The command has now been fixed <a href="http://macromates.com/textmate/manual/bundles#getting_more_bundles">in SVN</a> to take the long way around whenever pstricks is used. However, one important thing to note is that the command only checks in the file being typeset directly. If pstricks is only being used in some third-party package, you must let the command know by e.g. adding a comment

{% highlight text %}
%\usepackage{pstricks}
{% endhighlight %}

to your file.
