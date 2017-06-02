# encoding: UTF-8
require 'test_helper'

class AbsoluteTest < Minitest::Test
  def target_method; :absolute? end
  def test_it_safely_takes_nil
    refute FasterPath.absolute? nil
  end

  def test_it_determins_absolute_path
    assert FasterPath.absolute?("/hello")
    refute FasterPath.absolute?("goodbye")
  end

  def test_it_returns_similar_results_to_pathname_absolute?
    ["", ".", "/", ".asdf", "/asdf/asdf", "/asdf/asdf.asdf", "asdf/asdf.asd"].each do |pth|
      assert_equal(*result_pair(pth))
    end
  end

  def test_it_can_perform_the_same_with_unicode
    [".a—f", "/a—f/a—f", "/a—f/a—f.a—f", "a—f/a—f.a—"].each do |pth|
      assert_equal(*result_pair(pth))
    end
  end
end
