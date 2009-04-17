--- 
wordpress_id: 194
title: Markdown with auto-title in Rails
tags: 
- Ruby
- Ruby on Rails
- Markdown
---
I really like the idea of using a writer's format like <a href="http://daringfireball.net/projects/markdown/">Markdown</a> for your site's terms of use, privacy policy etc. I just implemented that on our site, and it's so very sweet.

<!--more-->

<h3>Prerequisites</h3>

I should mention I'm on Rails edge, currently revision 8168. Might work in earlier versions, but I didn't try.

Install <a href="http://blog.rubygreenblue.com/project/markdown_on_rails">Markdown on Rails</a> and the <code>bluecloth</code> gem.

<h3>Configuration</h3>

I created a <code>config/initializers/template_handlers.rb</code> file (that will also contain some <a href="http://haml.hamptoncatlin.com/">Haml</a> configuration) with this inside:

{% highlight ruby %}
# Markdown on Rails

ActionView::Base.register_template_handler('markdown', MarkdownOnRails)
MarkdownOnRails::map_headings_down_by 1  # So '# Terms of Use' becomes a <h2> etc
{% endhighlight %}
If you installed Markdown on Rails as a gem (I have it <a href="http://piston.rubyforge.org/">pistonized</a>), I believe you need to require it first.

<h3>Routes and controller</h3>

Create whatever routes you want – perhaps

{% highlight ruby %}
map.info 'info/:action', :controller => 'info'
{% endhighlight %}
and create an <code>InfoController</code>. My controller reads like so:

{% highlight ruby %}
class InfoController < ApplicationController
  before_filter :set_title

protected

  def set_title
    file = @template.full_template_path(default_template_name, @template.pick_template_extension(default_template_name))
    self.title = $1 if File.read(file).match(/\A\s*#\s*(.+)\s*$/)
  end
    
end
{% endhighlight %}

The <code>set_title</code> method simply reads the view file, finds an initial header like

{% highlight text %}
# Privacy Policy
{% endhighlight %}
and sets that as the page title. It uses a <code>title=</code> helper that I've defined in <code>ApplicationController</code>. That method basically sets an instance variable that I display in my application layout. The net result is that the page <code>&lt;title&gt;</code> will be set automagically from the Markdown.

Writing <code>set_title</code> took some digging around inside Rails. There might be a nicer way to do this – let me know in the comments.

Markdown on Rails actually allows you to use erb in your templates, so if one doesn't mind mixing things up and repeating oneself, one could get rid of <code>set_title</code> and do e.g.

{% highlight rhtml %}
<% self.title = "Privacy Policy" -%>
# Privacy Policy
⋮
{% endhighlight %}
instead.

<h3>Views</h3>

With all this set up, you can just create an <code>app/views/info/privacy.html.markdown</code> like so:

{% highlight text %}
# Privacy Policy

Jeff Goldblum is watching *you* poop!
{% endhighlight %}
and similarly for terms of use etc.

The page title will be set and the Markdown is rendered all pretty inside the controller/application layout.
