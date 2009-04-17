--- 
wordpress_id: 35
title: Quick keyword tagging in iPhoto
tags: 
- Ruby
- OS X
- AppleScript
---
Tagging in iPhoto is an annoying matter of dragging photos to fields or checking boxes. 

There is a <a href="http://homepage.mac.com/kenferry/software.html">Keyword Assistant</a> that does not run in Intel mode, and a <a href="http://www.versiontracker.com/dyn/moreinfo/macosx/25785">Keyword Tool</a> that didn't do it for me inbetween the crashes.

I wrote my own AppleScript (with some nested Ruby for string manipulation) that suits me better.


<!--more-->

<p class="updated"><span class="when">2006-09-12:</span> <a href="http://homepage.mac.com/kenferry/software.html">Keyword Assistant</a> now works with Intel.</p>

I hooked it to <code>&#x21E7;&#x2303;T</code> using <a href="http://quicksilver.blacktree.com/">Quicksilver</a>. Just select the images to tag or untag and run the script.

A dialog prompts for the keywords. Start with a minus to untag. Separate keywords with commas.

Keywords you use must exist within iPhoto already. The script tries matching what you type to extant keywords in two ways, in descending order of preference. Matching is case-insensitive.

The first method is a prefix match. "foo" is e.g. resolved to "Foobar".

The second method is an initials match. "fb" is e.g. resolved to "Foo Bar" unless there is e.g. a "Fbsomething" (prefix match).

If several keywords match using the same method (e.g. two keywords share a prefix) the alphabetically first one is used.

So If the iPhoto keywords available are "Henrik, Johan, Johanna, Linnea, Linnea K", I could type "h,j,lk" to tag with "Henrik,Johan,Linnea K". To tag with "Johanna" I'd need to type at least "Johann". To untag all, I could type "-h,j,lk".

The script doesn't handle non-ASCII well, because text encoding was too much pain in this case, and because I don't need it myself. 

Download <a href="http://henrik.nyh.se/uploads/iPhoto%20tag.scpt">iPhoto tag.scpt</a>. Code:

{% highlight applescript %}-- iPhoto quick keyword tagging
-- by Henrik Nyh <http://henrik.nyh.se> 2006-08-14
-- Free to modify, but please credit.
--
-- KNOWN ISSUES:
-- Does not handle non-ASCII very well.

tell app "iPhoto"
  -- Fetch keywords
  set the keys to the name of every keyword whose name is not "_Favorite_"
  
  -- Prompt
  activate
  set theDialog to display dialog "Tags to apply, comma-separated:" default answer "" buttons {"Cancel", "Tag"} default button "Tag"
  set tags to text returned of theDialog
end tell

-- Add or remove tags? 

set AppleScript's text item delimiters to ""
set charsTags to the text items of tags
set removeTags to (the first item of charsTags is "-")
if removeTags then set the tags to the rest of charsTags as string

-- Match abbreviated keywords to actual keywords in Ruby

set AppleScript's text item delimiters to "\",\""
set the keys to the keys as string

set the expandedTags to do shell script "ruby -e '
tags = \"" & tags & "\".split(/\\s*,\\s*/)
normalized = {}
[\"" & keys & "\"].each {|kw| normalized[kw.downcase] = kw}

tag_with = tags.map do |tag|
  normalized[
    normalized.keys.sort.find {|kw| kw.index(tag)==0} ||  # prefix match
    normalized.keys.sort.find {|kw| kw.gsub(/(\\w)\\w*\\s*/, %q{\\1}) == tag}  # initials match
  ]
end.compact.uniq.join(%{,})
puts tag_with
'"

-- Split keywords
set AppleScript's text item delimiters to ","
set expandedTags to the text items of expandedTags

-- Apply or remove keywords
repeat with tag in expandedTags
  if removeTags -- remove keywords
    tell app "iPhoto"
        repeat with pic in (selection as list)
          remove keyword tag from pic
        end repeat
    end tell
    -- iPhoto seems to need this to refresh the display
    tell app "SystemUIServer" to activate
    tell app "iPhoto" to activate
  else -- apply keywords
    tell app "iPhoto" to assign keyword string tag
  end if 
end repeat{% endhighlight %}
