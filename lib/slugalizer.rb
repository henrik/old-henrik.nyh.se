#!/usr/bin/env ruby
# encoding: utf-8
#
# Slugalizer
# http://github.com/henrik/slugalizer

require "rubygems"
gem "activesupport", "< 2.2"
require "active_support/multibyte"


module Slugalizer
  extend self
  SEPARATORS = %w[- _ +]
  
  def slugalize(text, separator = "-")
    unless SEPARATORS.include?(separator)
      raise "Word separator must be one of #{SEPARATORS}"
    end
    re_separator = Regexp.escape(separator)
    result = ActiveSupport::Multibyte::Handlers::UTF8Handler.normalize(text.to_s, :kd)
    result.gsub!(/[^\x00-\x7F]+/, '')                      # Remove non-ASCII (e.g. diacritics).
    result.gsub!(/[^a-z0-9\-_\+]+/i, separator)            # Turn non-slug chars into the separator.
    result.gsub!(/#{re_separator}{2,}/, separator)         # No more than one of the separator in a row.
    result.gsub!(/^#{re_separator}|#{re_separator}$/, '')  # Remove leading/trailing separator.
    result.downcase!
    result
  end
end


if __FILE__ == $0
  require "test/unit"
  
  class SlugalizerTest < Test::Unit::TestCase
    def assert_slug(expected_slug, *args)
      assert_equal(expected_slug, Slugalizer.slugalize(*args))
    end
    
    def with_kcode(kcode, &block)
        old_kcode = $KCODE
        $KCODE = kcode
        block.call
      ensure
        $KCODE = old_kcode
    end
    
    def test_converting_to_string
      assert_slug("", nil)
      assert_slug("1", 1)
    end
    
    def test_identity
      assert_slug("abc-1_2_3", "abc-1_2_3")
    end
    
    def test_accented_characters
      assert_slug("acegiklnuo", "āčēģīķļņūö")
    end
    
    def test_downcasing
      assert_slug("raksmorgas", "RÄKSMÖRGÅS")
    end
    
    def test_special_characters_outside
      assert_slug("raksmorgas", " räksmörgås!?.")
    end
    
    def test_special_characters_inside
      assert_slug("raka-smorgas-nu", "räka@smörgås.nu")
    end
    
    def test_no_leading_or_trailing_separator
      assert_slug("i-love-c++", "I love C++")
      assert_slug("i-love-c", "I love C--")
    end
    
    def test_chinese_text
      assert_slug("chinese-text", "chinese 中文測試 text")
    end
    
    def test_stripped_character_then_whitespace
      assert_slug("abc", "! abc !")
    end
      
    def test_single_whitescape
      assert_slug("smorgasbord-e-gott", "smörgåsbord é gott")
    end
    
    def test_surrounding_whitescape
      assert_slug("smorgasbord-e-gott", " smörgåsbord é gott ")
    end
    
    def test_excessive_whitescape
      assert_slug("smorgasbord-ar-gott", "smörgåsbord  \n  är  \t   gott")
    end
    
    def test_squeeze_separators
      assert_slug("a-b", "a - b")
      assert_slug("a-b", "a--b")
    end
    
    def test_separator_parameter
      assert_slug("smorgasbord-ar-gott", "smörgåsbord är gott", "-")
      assert_slug("smorgasbord_ar_gott", "smörgåsbord är gott", "_")
      assert_slug("smorgasbord+ar+gott", "smörgåsbord är gott", "+")
    end
    
    def test_invalid_separator
      assert_raise(RuntimeError) do
        Slugalizer.slugalize("smörgåsbord är gott", "@")
      end
    end
    
    def test_handling_of_separator_chars
      assert_slug("abc_-_1_2_3", "abc - 1_2_3", "_")
    end
    
    def test_other_separators_are_left_alone
      assert_slug("foo-+-b_a_r", "foo + b_a_r")
    end
    
    def test_with_kcode_set_to_none
      with_kcode('n') do
        assert_slug("raksmorgas", "räksmörgås 中")
      end
    end
    
    def test_with_kcode_set_to_utf_8
      with_kcode('u') do
        assert_slug("raksmorgas", "räksmörgås 中")
      end
    end

  end
end
