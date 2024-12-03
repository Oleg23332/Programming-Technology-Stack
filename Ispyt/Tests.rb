require 'minitest/autorun'

def character_count(string)
  counts = Hash.new(0)
  string.each_char { |char| counts[char] += 1 }
  counts
end

class TestCountCharacters < Minitest::Test
  def test_empty_string
    assert_equal({}, character_count(""))
  end

  def test_single_character
    assert_equal({ "a" => 1 }, character_count("a"))
  end

  def test_repeated_characters
    assert_equal({ "a" => 3 }, character_count("aaa"))
  end

  def test_mixed_characters
    assert_equal({ "a" => 2, "b" => 1, "c" => 1 }, character_count("aabc"))
  end

  def test_with_spaces
    assert_equal({ " " => 3, "a" => 2, "b" => 1 }, character_count("a a b "))
  end

  def test_special_characters
    assert_equal({ "!" => 2, "@" => 1, "#" => 1 }, character_count("!@#!"))
  end
end
