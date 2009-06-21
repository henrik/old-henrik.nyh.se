var Blog = {
  
  getTwitter: function() {
    $("#tweets").getTwitter({
      userName: "henrik",
      numTweets: 3,
      slideIn: true,
      showHeading: true,
      headingText: 'Recently on <a href="http://twitter.com/henrik">Twitter</a>:',
      showProfileLink: false,
      rejectRepliesOutOf: 20
    });
  },
  

  addEditLinks: function() {
    if ($.cookie('editable') && $('#edit').length) {
      $('#edit a').text('Edit').before('[').after(']');
    }
  },
  

  relativizeAge: function() {
    $('#birthday').each(function() {
        var text  = $(this).text();
        var born  = new Date(text);
        var today = new Date();
        var ydiff = today.getFullYear() - born.getFullYear();
        var bday = new Date(text);
        bday.setFullYear(today.getFullYear());
        if (bday > today) ydiff -= 1;

        $(this).append(' ('+ydiff+' years old)');
    });
  },
  

  explainGlyphs: function() {
    var glyphs = {
      "␣": "Space",
      "↩": "Return",
      "⌅": "Enter",
      "⇥": "Tab",
      "⇤": "Backtab",
      "⌫": "Backspace",
      "⌦": "Forward Delete",
      "⌘": "Command",
      "⌥": "Option",
      "^": "Control",
      "⌃": "Control",
      "⇧": "Shift",
      "⇪": "Caps Lock",
      "←": "Left Arrow",
      "→": "Right Arrow",
      "↑": "Up Arrow",
      "↓": "Down Arrow",
      "↖": "Home",
      "↘": "End",
      "⇞": "Page Up",
      "⇟": "Page Down",
      "⎋": "Escape",
      "⏏": "Eject"
    };

    function glyphsToNames(text) {
      return text.split('').map(function(x) { return (glyphs[x] || x) }).join(" ");
    }
    $('.kb').each(function() {
      var text = $(this).text();
      this.title = "Key"+(text.length>1 ? "s" : "")+": " + glyphsToNames(text);
    });
  },
  

  init: function() {
    this.getTwitter();
    this.explainGlyphs();
    this.addEditLinks();
    this.relativizeAge();
  }
  
};

$(function() { Blog.init() });


// To show edit links:
//   javascript: edit(true)
// To hide edit links:
//   javascript: edit(false)
function edit(bool) {
  var value = bool ? 'true' : null;
  $.cookie('editable', value, { expires: 365*10 });
  location.reload();
}
