--- 
wordpress_id: 265
title: Page numbers in Pages.app
tags: 
- OS X
- Pages.app
---
My girlfriend is writing an assignment in the iWork '08 Pages.app, and getting page numbers the way she wanted took some figuring out.

To get page numbers at all, put the caret in any page footer and <code>Insert &gt; Page Number</code>. You can style the footer like any other text, e.g. center it.

That was fairly straightforward; it was trickier to figure out how to start the numbering after the title page and table of contents. What we did was this:

Use <code>Insert &gt; Section Break</code> where you want the footer to start changing. In our case, this was after the table of contents. This will look much like a page break.

With the section break in place, put the caret somewhere inside the new section (after the table of contents) and open the Inspector. In the Layout pane (second from left), choose "Section".

<p class="center"><img src="http://henrik.nyh.se/uploads/pages-numbering.png" alt="[Screenshot]" /></p>

Now, if you uncheck the "Use previous headers & footers" box, the footers for the two sections are independent. So just uncheck it, make sure "Start at:" is set to 1, and then remove the footers from the first section if you don't want them.
