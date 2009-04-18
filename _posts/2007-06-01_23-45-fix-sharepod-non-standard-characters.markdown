--- 
wordpress_id: 144
title: Fix SharePod "non-standard" characters
tags: 
- Ruby
- Windows
---
I recently needed to copy all songs from an iPod to iTunes on a computer running Windows XP. I also wanted to keep the ratings.

After some trial-and-ctrl-alt-del, I ended up with <a href="http://www.sturm.net.nz/website.php?Section=iPod+Programs&Page=SharePod">SharePod</a>. It will copy the songs to your computer as well as create an XML file containing the ratings. iTunes can then read the XML file to import the songs including ratings.

SharePod has an annoying bug, though: file paths in the XML file are URL-encoded from Latin-1 rather than the UTF-8 encoding iTunes expects. This means iTunes will fail to import songs containing non-ASCII characters, i.e. a lot of Swedish songs.

The SharePod site says that

> If iTunes says it 'couldn't find all the files', check your music for non-standard characters,
> like accented characters (Á, ö, etc) as these will often cause problems for iTunes to import. 

I think "non-standard characters" is a rather inaccurate turn of phrase. Anyway, I solved this problem (which is really a SharePod bug, not an iTunes issue) with a small Ruby script.

<!--more-->

<a href="http://henrik.nyh.se/uploads/sharepod_fixer.rb">Download the script</a> and use it like <code>ruby sharepod_fixer.rb SharePod_iTunes_Import.xml</code>. It will create a file <code>SharePod_iTunes_Import_fixed.xml</code> that should work fine for those "non-standard characters".

I should mention I ran this script under OS X and then moved the output file to the Windows computer. Running the script should work as well under Windows, but I haven't actually tried it.

The code:

{% highlight ruby %}
%w{cgi iconv rexml/document}.each { |lib| require lib }

unless ARGV[0]
    STDERR.puts %{Usage: ruby "#{$0}" "/Some/Dir/SharePod_iTunes_Import.xml"}
    exit
end

puts "Processing..."
doc = REXML::Document.new(ARGF)

# Loop over location strings, recoding them from encoded Latin-1 to encoded UTF-8
doc.elements.each('//key[.="Location"]/following-sibling::string') do |node|
    source = CGI.unescape(node.text)  # Unescape into Latin-1
    recoded_source = CGI.escape(Iconv.iconv('utf8', 'latin1', source).first)  # Convert to UTF-8 and re-escape
    node.text = recoded_source.gsub('+', '%20').gsub('%2F', '/').sub('file%3A//', 'file://')  # Fix stuff iTunes would choke on
end

output_file = ARGV[0].sub(/(\.xml)?$/i, '_fixed.xml')
File.open(output_file, 'w') { |f| f.print doc }

puts "Done."
{% endhighlight %}
