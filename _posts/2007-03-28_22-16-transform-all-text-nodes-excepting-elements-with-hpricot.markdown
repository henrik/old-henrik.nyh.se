--- 
wordpress_id: 121
title: Transform all text nodes (excepting elements) with Hpricot
tags: 
- Ruby
- Hpricot
---
Christoffer Sawicki wrote a useful <a href="http://code.whytheluckystiff.net/hpricot/">Hpricot</a> extension, <a href="http://termos.vemod.net/hpricot-goodies">Hpricot Text GSub</a>, to <code>gsub!</code> in HTML text nodes only.

Though I love an overextended regexp as much as the next guy, I realized that I should use an actual HTML parser for things like <a href="http://henrik.nyh.se/2007/03/ruby-wordwrap-method/">wordwrapping in text nodes outside of <code>pre</code> elements</a>.

So I wrote my own extension, <code>HpricotTextTransform</code>, based on Christoffer's code. It works much the same way, but rather than being limited to <code>gsub!</code> ((Which you could arguably do anything with, though:

{% highlight ruby %}
gsub!(/.*/m) { anything($&) }
{% endhighlight %})) you can put whatever text transformations you want in a block – text nodes are passed as arguments to that block. This is useful to e.g. apply an autolink method to text nodes. Also, you can specify elements whose descendant text nodes should <em>not</em> be transformed.

<!--more-->

This is the wordwrap method using <code>HpricotTextTransform</code>:

{% highlight ruby %}
def wordwrap(text, width=70, string="<wbr />")
  return nil unless text
  Hpricot(text).text_transform!(:except => :pre) do |text|
    text.gsub(/(\S{#{width}})(?=\S)/) { "#$1#{string}" }
  end.to_s
end
{% endhighlight %}

This is the extension itself (<a href="http://henrik.nyh.se/uploads/hpricot_text_transform.rb">download</a>), including some tests:

{% highlight ruby %}
# By Henrik Nyh <http://henrik.nyh.se> 2007-03-28.
# Based on http://vemod.net/code/hpricot_goodies/hpricot_text_gsub.rb.
# Licensed under the same terms as Ruby.

require "rubygems"
require "hpricot"

module HpricotTextTransform
  module NodeWithChildrenExtension
    def text_transform!(options={}, &block)
      return if defined?(name) and Array(options[:except]).include?(name.to_sym)
      children.each { |c| c.text_transform!(options, &block) }
    end
  end
  
  module TextNodeExtension
    def text_transform!(options={}, &block)
      content.replace yield(content)
    end
  end

  module BogusETagExtension
    def text_transform!(options={}, &block)
    end
  end
end

Hpricot::Doc.send(:include,  HpricotTextTransform::NodeWithChildrenExtension)
Hpricot::Elem.send(:include, HpricotTextTransform::NodeWithChildrenExtension)
Hpricot::BogusETag.send(:include, HpricotTextTransform::BogusETagExtension)
Hpricot::Text.send(:include, HpricotTextTransform::TextNodeExtension)


if __FILE__ == $0
  require "test/unit"
  
  class HpricotTextTransformTest < Test::Unit::TestCase
    def assert_hpricot_transform(expected, input, options={}, &block)
      doc = Hpricot(input)
      doc.text_transform!(options, &block)
      assert_equal(expected, doc.to_s)
    end
    
    def test_with_gsub
      input    = '<a href="xxx">xxx</a>'
      expected = '<a href="xxx">yyy</a>'
      assert_hpricot_transform(expected, input, {}) { |text| text.gsub("x", "y") }
    end

    def test_with_reverse
      input    = '<a href="attribute">hello</a> world from <code>ruby</code>'
      expected = '<a href="attribute">olleh</a> morf dlrow <code>ybur</code>'
      assert_hpricot_transform(expected, input, {}) { |text| text.reverse }
    end

    def test_with_reverse_exclude_one_tag
      input    = '<a href="attribute">hello</a> world from <code>ruby</code>'
      expected = '<a href="attribute">olleh</a> morf dlrow <code>ruby</code>'
      assert_hpricot_transform(expected, input, {:except => :code}) { |text| text.reverse }
    end

    def test_with_reverse_exclude_multiple_tags
      input    = '<a href="attribute">hello</a> world from <code>ruby</code>'
      expected = '<a href="attribute">hello</a> morf dlrow <code>ruby</code>'
      assert_hpricot_transform(expected, input, {:except => [:a, :code]}) { |text| text.reverse }
    end

    def test_with_reverse_exclude_nested_tag
      input    = '<a href="attribute">hello</a> world from <pre><code><a>ruby</a></code></pre>'
      expected = '<a href="attribute">olleh</a> morf dlrow <pre><code><a>ruby</a></code></pre>'
      assert_hpricot_transform(expected, input, {:except => :code}) { |text| text.reverse }
    end

  end
end
{% endhighlight %}
