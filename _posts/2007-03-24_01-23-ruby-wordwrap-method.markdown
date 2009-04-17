--- 
wordpress_id: 119
title: Ruby wordwrap method
tags: 
- Ruby
- Ruby on Rails
---
I wrote a Ruby method (for use as a Rails helper) to wordwrap text. It does not wrap within <code>&lt;pre&gt;&lt;/pre&gt;</code>, as those elements are styled with

{% highlight css %}
max-width:100%;
overflow-x:auto;
{% endhighlight %}
to get scrollbars if their content is overlong. Also, it does not wrap inside HTML tags, since long <code>src</code> or <code>href</code> attributes shouldn't be broken up.

<!--more-->

Perhaps there is a better solution, but I kind of like this:

{% highlight ruby %}
class String
  # Replace the second of three capture groups with the given block.
  def midsub(regexp, &block)
    self.gsub(regexp) { $1 + yield($2) + $3 }
  end
end

def wordwrap(text, width=80, string="<wbr />")
  text.midsub(%r{(\A|</pre>)(.*?)(\Z|<pre(?: .+?)?>)}im) do |outside_pre|  # Not inside <pre></pre>
    outside_pre.midsub(%r{(\A|>)(.*?)(\Z|<)}m) do |outside_tags|  # Not inside < >, either
      outside_tags.gsub(/(\S{#{width}})(?=\S)/) { "#$1#{string}" }
    end
  end
end

test = "Lorem ipsum dolor sit amet, <pre>consectetur</pre> adipisicing elit, sed do eiusmod tempor <pre class='longlatinwordicus'>incididunt</pre> ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo <a href='longlatinwordicus'>consequat</a>. Duis aute irure dolor in <pre class='longlatinwordicus'><code>reprehenderit</code></pre> in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

puts wordwrap(test, 5)
{% endhighlight %}

which outputs

{% highlight html %}
Lorem ipsum dolor sit amet, <pre>consectetur</pre> adipi<wbr />sicin<wbr />g elit, sed do eiusm<wbr />od tempo<wbr />r <pre class='longlatinwordicus'>incididunt</pre> ut labor<wbr />e et dolor<wbr />e magna aliqu<wbr />a. Ut enim ad minim venia<wbr />m, quis nostr<wbr />ud exerc<wbr />itati<wbr />on ullam<wbr />co labor<wbr />is nisi ut aliqu<wbr />ip ex ea commo<wbr />do <a href='longlatinwordicus'>conse<wbr />quat</a>. Duis aute irure dolor in <pre class='longlatinwordicus'><code>reprehenderit</code></pre> in volup<wbr />tate velit esse cillu<wbr />m dolor<wbr />e eu fugia<wbr />t nulla paria<wbr />tur. Excep<wbr />teur sint occae<wbr />cat cupid<wbr />atat non proid<wbr />ent, sunt in culpa qui offic<wbr />ia deser<wbr />unt molli<wbr />t anim id est labor<wbr />um.
{% endhighlight %}
