require 'cgi'

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
  
  def tag_links(array, has_tag=true)
    links = array.map { |tag|
      qs = %{site:henrik.nyh.se "tag: #{tag}"}
      url = "http://www.google.com/search?q=#{url_encode qs}"
      text = has_tag ? %{<span class="tag-meta">tag:</span> #{h tag}} : h(tag)
      link_to(text, url)
    }
    array_to_sentence(links)
  end

end
