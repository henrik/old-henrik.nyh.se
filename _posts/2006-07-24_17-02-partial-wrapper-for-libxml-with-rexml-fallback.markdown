--- 
wordpress_id: 11
title: Partial wrapper for libxml with REXML fallback
tags: 
- Ruby
---
I'm currently working on Ruby code to parse XMLTV data, apply a set of "favorite shows" rules, and export the intersection as an iCalendar file with alarms, to be used in iCal.

This might ship with <a href="http://www-und.ida.liu.se/~gusax840/xmltv/">the Swedish Xmltv widget</a> somewhere along the road, so ideally it should not require any module that does not ship with OS X/Ruby. However, <a href="http://www.ruby-doc.org/stdlib/libdoc/rexml/rdoc/">REXML</a>, which ships with Ruby, is many times slower than <a href="libxml.rubyforge.org/">libxml</a>, which doesn't. Parsing the data with REXML takes around 11 seconds on my computer, whereas using libxml is a one second job.

My solution was to write a wrapper that uses libxml when available, and REXML as fallback when it's not.


<!--more-->

This wrapper is only adapted for my needs for this project, and thus only covers the very basics of reading XML data &ndash; just a small part of what libxml and REXML can do. Still, I'm posting it here in case it's of use to someone else.

The interface is part libxml/part REXML/part whatever I figured was nicer than what either provided.

Usage examples are comments in the code.

{% highlight ruby %}# LEXML by Henrik Nyh <http://henrik.nyh.se> 2006-07-24
# Free to modify, but please credit.
#
# Very simple wrapper that uses the fast libxml
# <http://libxml.rubyforge.org/> if available, otherwise the slower
# but bundled-with-Ruby-1.8+ REXML 
# <http://www.ruby-doc.org/stdlib/libdoc/rexml/rdoc/>. Handles the
# very basics of reading XML data.

class LEXML

  begin
    require "rubygems"
    require "xml/libxml"
    GOT_LIBXML = true
    XML::Parser.default_warnings = false
  rescue LoadError  # Fall back to REXML
    require "rexml/document"
    GOT_LIBXML = false
  end
  
  def self.libxml?
    # e.g:
    # puts LEXML::libxml? ? "Using libxml" : "Using REXML"
    GOT_LIBXML
  end

  def initialize(file)
    # e.g:
    # xml = LEXML.new("file.xml")
    if LEXML::libxml?
      @handle = XML::Document.file(file)
    else  # Fall back to REXML
      @handle = REXML::Document.new File.new(file)
    end
  end

  def root
    Node.new(@handle.root)
  end
  
  class Nodeset < Array
  end
  
  class Node < String
    # For a node <dog size="small" cute="true">pug</dog>:
    #   node => "pug"
    #   node[:size] => "small"; node["size"] => "small"
    #   size, cute = node[:size, :cute]
    # For a node <animals><dogs><dog>Fabulous</dog><dog>Spanko</dog></dogs>:
    #   node.child("dogs") => the dogs node
    #   node.children("dogs/dog") => both dog nodes
    def initialize(node)
      @node = node
      super((LEXML::libxml? ? @node.content : @node.text) || "")
    end
    def [](*attributes)
      list = attributes.map { |attribute| LEXML::libxml? ? @node[attribute.to_s] : @node.attributes[attribute.to_s]  }
      list.size == 1 ? list.first : list
    end
    def children(type)
      if LEXML::libxml?
        LEXML::Nodeset.new(@node.find(type.to_s).map{ |e| Node.new(e)})
      else
        kids = []
        @node.elements.each(type.to_s) {|e| kids << Node.new(e)}
        LEXML::Nodeset.new(kids)
      end
    end
    def child(type)
      children(type).first
    end
  end  
  
end
{% endhighlight %}
