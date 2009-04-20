--- 
wordpress_id: 179
title: Printing on a Windows shared HP PSC 950 from OS X
tags: 
- OS X
---
After seeing <a href="http://www.macosxhints.com/article.php?story=20070916131935539">this hint on macosxhints.com</a>, I can finally print from my computer.

Our setup is a Hewlett-Packard PSC 950 connected to a networked Windows computer; my computer is a Mac running OS X 10.4.10.

<!--more-->

Following the hint, I added a printer with a URI like <code>smb://username:password@computername/printername</code>.

My first attempts gave gibberish output starting with

{% highlight text %}
%!PS-Adobe-3.0
              %RBINumCopies: 1
{% endhighlight %}

followed by a few more lines in the same spirit and then a number of blank pages, at which point I cancelled printing.

After trying a couple of different printer models, selecting "HP" and then "HP LaserJet 6 series - Gimp-Print v5.0.0-beta2" worked. I'm sure others do also. I think the Gimp-Print drivers are bundled with OS X starting at 10.3 or so.

Before I realized the "LaserJet 6 series" model worked, I installed the <a href="http://www.linux-foundation.org/en/OpenPrinting/MacOSX/hpijs">HPIJS package (and its prerequisites ESP GS and Foomatic RIP)</a>. After installing that, there is a "HP PSC 950 Foomatic/hpijs" printer listed which obviously works well also. The "Printer Features" settings in the print dialog are perhaps more pertinent with the PSC 950 driver, offering printout modes ranging from "Draft" to "Photo (on photo paper)", as opposed to image types and resolutions.

I'd recommend avoiding the official "<a href="http://h10025.www1.hp.com/ewfrf/wc/softwareList?os=219&lc=en&cc=us&dlc=en&product=60259&lang=en">All-in-One web installer</a>". After installing 700(!) files, it couldn't find the printer, and no new printer models were listed in the Printer Browser. Luckily one of the several applications provided was an uninstaller.

I haven't looked into using the scanner or the card reader.
