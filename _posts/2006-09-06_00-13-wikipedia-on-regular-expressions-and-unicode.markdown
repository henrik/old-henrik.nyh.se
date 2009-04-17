--- 
wordpress_id: 48
title: Wikipedia on Regular expressions and Unicode
tags: 
- Facts
- Interesting
---
<blockquote><p>A third issue is variation in how ASCII-oriented constructs are extended to Unicode. For example, in ASCII-based implementations, character ranges of the form [x-y] are valid wherever x and y are codepoints in the range [0x00,0x7F] and codepoint(x) &lt;= codepoint(y). The natural extension of such character ranges to Unicode would simply change the requirement that the endpoints lie in [0x00,0x7F] to the requirement that they lie in [0,0x1FFFFF]. However, in practice this is often not the case. Some implementations, such as that of gawk, do not allow character ranges to cross Unicode blocks. A range like [0x61,0x7F] is valid since both endpoints fall within the Basic Latin block, as is [0x0530,0x0560] since both endpoints fall within the Armenian block, but a range like [0x0061,0x0532] is invalid since it includes multiple Unicode blocks. Other engines, such as that of the Vim editor, allow block-crossing but limit the number of characters in a range to 128.</p></blockquote>

&ndash; <a href="http://en.wikipedia.org/wiki/Regexp#Regular_expressions_and_Unicode">Wikipedia</a>
