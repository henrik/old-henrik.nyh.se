require 'cgi'
require 'lib/slugalizer'

FEED_URL = "http://feeds.feedburner.com/ThePugAutomatic"

module Helpers

  def url_encode(input)
    CGI.escape(input)
  end

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
      "#{array[0...-1].join(', ')}, #{connector} #{array[-1]}"
    end
  end
  
  def tag_links(array)
    links = array.map { |tag| link_to(h(tag), "/tag/##{slug(tag)}") }
    array_to_sentence(links)
  end
  
  def slug(text)
    Slugalizer.slugalize(text)
  end
  
  def tag_cloud(tags, from=1, unto=6)
    tag_counts = tags.map {|tag,posts| [tag, posts.length] }.sort_by {|tag, count| tag.downcase }
    min = tag_counts.min { |a,b| a.last <=> b.last }.last
    max = tag_counts.max { |a,b| a.last <=> b.last }.last
    tag_counts_sizes = tag_counts.map { |tag, count|
      # http://blogs.dekoh.com/dev/2007/10/29/choosing-a-good-font-size-variation-algorithm-for-your-tag-cloud/
      weight = (Math.log(count)-Math.log(min))/(Math.log(max)-Math.log(min))
      size = from + ((unto-from)*weight).round
      [tag, count, size]
    }
    
    ['<ul id="list">',
        tag_counts_sizes.map {|t,c,s|
          %{<li class="tier-#{s}">#{link_to("#{h(t)}&nbsp;<span>(#{c})</span>", "##{slug(t)}")}</li>}
        }.join(' '),
      '</ul>'
    ].join  
  end

end
