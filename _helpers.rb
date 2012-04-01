require 'cgi'
require_relative 'lib/slugalizer'

FEED_URL = "/atom.xml"

# Force Haml to use RDiscount for the :markdown filter.
# Can actually be a Markdown module in any namespace, but that's just dirty.
module Haml
  module Markdown
    include Haml::Filters::Base
    def render(text)
      ::RDiscount.new(text).to_html
    end
  end
end


module Helpers

  def array_to_sentence(array)
    connector = "and"
    case array.length
    when 0
      ""
    when 1
      array[0].to_s
    when 2
      "#{array[0]} #{connector} #{array[1]}"
    else
      "#{array[0...-1].join(', ')} #{connector} #{array[-1]}"
    end
  end

  def header(text)
    "<h1>%s</h1>" % link_to(text, '/')
  end

  def post_link(post)
    link_to(h(post.title), post.url)
  end

  def tag_link(name, link_name=nil)
    link_name ||= name
    link_to(h(name), "/tag##{slug(link_name)}")
  end

  def tag_links(array)
    links = array.map { |tag| tag_link(tag) }
    array_to_sentence(links)
  end

  def slug(text)
    Slugalizer.slugalize(text)
  end

  def tag_cloud(tags, from=1, unto=6)
    return @@tag_cloud if defined?(@@tag_cloud)

    tag_counts = tags.map {|tag,posts| [tag, posts.length] }.sort_by {|tag, count| tag.downcase }
    min = tag_counts.min { |a,b| a.last <=> b.last }.last
    max = tag_counts.max { |a,b| a.last <=> b.last }.last
    tag_counts_sizes = tag_counts.map { |tag, count|
      # http://blogs.dekoh.com/dev/2007/10/29/choosing-a-good-font-size-variation-algorithm-for-your-tag-cloud/
      weight = (Math.log(count)-Math.log(min))/(Math.log(max)-Math.log(min))
      weight = 1 if weight.nan?  # e.g. same max as min
      size = from + ((unto-from)*weight).round
      [tag, count, size]
    }

    @@tag_cloud = ['<ol id="tag-cloud">',
        tag_counts_sizes.map {|t,c,s|
          title = c == 1 ? "1 post" : "#{c} posts"
          %{<li class="tier-#{s}" title="#{title}">#{tag_link(t)}</li>}
        }.join(' '),
      '</ol>'
    ].join
  end

end
