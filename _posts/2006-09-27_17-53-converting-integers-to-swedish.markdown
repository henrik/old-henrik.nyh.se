--- 
wordpress_id: 64
title: Converting integers to Swedish
tags: 
- Ruby
---
I wrote some Ruby code to convert positive decimal integers (like <code>123</code>) or strings (like <code>"123"</code>) into strings of Swedish (like <code>"etthundratjugotre"</code>).

<!--more-->

I was pleasantly surprised at how little code was needed. I suppose anything else would be odd (or contain redundant code), since it's a system of predictable patterns.

The code shouldn't be too hard to adapt for English or any other language with a similar numbers-to-words mapping to Swedish. Keep in mind that the names for large numbers vary even between American and British English.

The code was implemented as an <code>Integer.to_swedish</code> class method (e.g. <code>Integer.to_swedish("123")</code>), also available through an <code>Integer</code> instance method (e.g. <code>123.to_swedish</code>).

Every named power of ten listed in <a href="http://sv.wikipedia.org/wiki/R%C3%A4kneord#Lista_.C3.B6ver_r.C3.A4kneord">Swedish Wikipedia</a> is handled, except for googolplex and googolplexian, being <a href="http://en.wikipedia.org/wiki/Googolplex#How_big_is_a_googolplex.3F">too large to store within the known universe</a>.

Numbers recurse if necessary, so whereas the highest named number is "centiljard" (10<sup>603</sup>), you can have any number of those, limited only by available memory.

The use of whitespace (between parts except within hundreds and tens) is obviously debatable.

<h4>The algorithm</h4>

The input is turned into a reverse array of digits, so <code>"123"</code> becomes <code>[3,2,1]</code>.

That array is turned into output (a list of strings, eventually joined together) starting at the beginning (the left-hand side) and moving towards the end.

Zeroes and empty input are given special treatment: the program bails early, returning the proper value, if they are present.

A private class method, <code>Integer.below_thousand</code> handles the numbers 1&ndash;999. Its workings are rather obvious. If in the range 10&ndash;19, a stored "teen" value is chosen. If outside that range, singles and tens are appended to the output as appropriate. If there are any hundreds involved, those are appended to the output next.

The rest of the code basically consists of applying <code>Integer.unit</code> to various named powers of ten and their ranges, in the right order. The input of this method is the entire number (in that reverse array representation), the name, and the positions of the number that this name ranges over. So e.g. thousands range from 10<sup>3</sup> to 10<sup>5</sup> (i.e. 1000&ndash;999 000 are some number of thousands). 10<sup>6</sup> to 10<sup>8</sup> is the range for millions, and so on. How many thousands, millions etc is determined recursively.

For the most part, it's just ten to the power of some multiple of three, which is a reason you don't need a lot of code. There is the odd exception, though, that needs special handling.

For the largest implemented named power of ten, "centiljarder", the range is from 10<sup>603</sup> to the end of the input.

After joining the output together into a string, two regular expression substitutions are applied, to fix gender and number agreement issues.

<h4>The code</h4>

The code (<a href="http://henrik.nyh.se/uploads/numbers.rb">download</a>):

{% highlight ruby %}
#! /usr/bin/env ruby

# Henrik Nyh <http://henrik.nyh.se> 2006-09-27
# Free to modify and redistribute non-commercially with due credit.

# Turns integer strings into Swedish words. Handles units up to and including "centiljard", per <http://sv.wikipedia.org/wiki/R%C3%A4kneord#Lista_.C3.B6ver_r.C3.A4kneord>.

class Array
  def singles; slice(0); end
  def tens; slice(1); end
  def hundreds; slice(2);  end
  def tens?
    tens and tens.nonzero?
  end
  def hundreds?
    hundreds and hundreds.nonzero?
  end
  def contain_positive_integers?
    (1..9).any? {|int| self.include? int}
  end
end

class Integer
  SINGLES = %w{noll ett två tre fyra fem sex sju åtta nio}
  TEENS = %w{tio elva tolv tretton fjorton femton sexton sjutton arton nitton}
  TENS = %w{_ _ tjugo trettio fyrtio femtio sextio sjuttio åttio nittio}
  HUNDREDS, GOOGOLS, CENTILLIONS, CENTILLIARDS = %w{hundra googoler centiljoner centiljarder}
  CUBES = %w{tusen}
  %w{m b tr kvadr kvint sext sept okt non dec undec duodec tredec quattuordec quindec sexdec septendec octodec novemdec vigint}.each do |prefix|
    CUBES << "#{prefix}iljoner" << "#{prefix}iljarder"
  end
  
  def to_swedish
    Integer.to_swedish(self)
  end
  def self.to_swedish(string)
    number = string.to_s.scan(/\d/).map {|n| n.to_i}.reverse  # "00123" becomes [3,2,1,0,0]
    number.pop while number.size > 1 and number.last.zero?

    return nil if number.empty?
    return SINGLES[0] if number == [0]

    output = below_thousand(number)

    CUBES.each_with_index do |name,index|
      exponent = (index + 1) * 3
      case exponent
      when 99  # special treatment for sexdeciljard since 10^100 is googol
        output += unit(number, name, 99, 1)
        output += unit(number, GOOGOLS, 100, 2)
      when 123  # vigintiljard spans 10^123 - 10^599
        output += unit(number, name, 123..599)
      else
        output += unit(number, name, exponent)
      end
    end

    output += unit(number, CENTILLIONS, 600)
    output += unit(number, CENTILLIARDS, 603..-1)

    output = output.reverse.join(" ")

    # Fix singular determiners 
    output.gsub!(/\bett (\w+)er/, 'en \1')
    output.gsub!(/ett (\w+er)/, 'en \1')

    output
  end
  
  private  # Helper methods

  def self.below_thousand(number)  # Turns e.g. [3,2,1] (for 123) into words
    return [] unless number[0,3].contain_positive_integers?
    output = []
    if number.tens == 1
      output << TEENS[number.singles]
    else
      output << SINGLES[number.singles] unless number.singles.zero?
      output << TENS[number.tens] if number.tens?
    end
    output << HUNDREDS << SINGLES[number.hundreds] if number.hundreds?
    [output.reverse.join]
  end

  def self.unit(number, unit, exponent_or_range, places=3)  # The amount of a unit, ranging over part of the number
    list = if exponent_or_range.is_a?(Range) then number[exponent_or_range] else number[exponent_or_range,places] end
    return [] unless list and list.contain_positive_integers?
    [unit, to_swedish(list.reverse)]
  end
end

if __FILE__ == $0
  # Test run
  puts Integer.to_swedish("")
  puts 0.to_swedish
  puts Integer.to_swedish("000foo0001")
  puts Integer.to_swedish("1,024,908,267,229")
  puts Integer.to_swedish("1.#{"0"*1_205}1")
end
{% endhighlight %}

outputs:

{% highlight text %}
nil
noll
ett
en biljon tjugofyra miljarder niohundraåtta miljoner tvåhundrasextiosju tusen tvåhundratjugonio
en centiljard centiljarder ett
{% endhighlight %}
