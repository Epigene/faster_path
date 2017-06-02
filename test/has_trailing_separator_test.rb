# encoding: UTF-8 
require 'test_helper'

class HasTrailingSeparatorTest < Minitest::Test
  def target_method; :has_trailing_separator? end
  def test_has_trailing_separator_against_pathname_implementation1
    assert_equal(*result_pair(''))
    assert_equal(*result_pair('/'))
    assert_equal(*result_pair('//'))
    assert_equal(*result_pair('///'))
    assert_equal(*result_pair('hello'))
    assert_equal(*result_pair('hello/'))
    assert_equal(*result_pair('/hello/'))
    assert_equal(*result_pair('/hello//'))
  end

  def test_has_trailing_separator_against_pathname_implementation2
    assert_equal(*result_pair('.'))
    assert_equal(*result_pair('./'))
    assert_equal(*result_pair('.//'))
    assert_equal(*result_pair("aa/a//a"))
    assert_equal(*result_pair("/aaa/a//a"))
    assert_equal(*result_pair("/aaa/a//a/a"))
    assert_equal(*result_pair("/aaa/a//a/a"))
    assert_equal(*result_pair("a//aaa/a//a/a"))
    assert_equal(*result_pair("a//aaa/a//a/aaa"))
    assert_equal(*result_pair("/aaa/a//a/aaa/a"))
    assert_equal(*result_pair("a//aaa/a//a/aaa/a"))
    assert_equal(*result_pair("a//aaa/a//a/aaa////"))
    assert_equal(*result_pair("a/a//aaa/a//a/aaa/a"))
    assert_equal(*result_pair("////a//aaa/a//a/aaa/a"))
    assert_equal(*result_pair("////a//aaa/a//a/aaa////"))
  end

  def test_has_trailing_separator_against_pathname_implementation3
    assert_equal(*result_pair("."))
    assert_equal(*result_pair(".././"))
    assert_equal(*result_pair(".///.."))
    assert_equal(*result_pair("/././/"))
    assert_equal(*result_pair("//../././"))
    assert_equal(*result_pair(".///.../.."))
    assert_equal(*result_pair("/././/.//."))
    assert_equal(*result_pair("/...//../././"))
    assert_equal(*result_pair("/..///.../..//"))
    assert_equal(*result_pair("/./././/.//..."))
    assert_equal(*result_pair("/...//.././././/."))
    assert_equal(*result_pair("./../..///.../..//"))
    assert_equal(*result_pair("///././././/.//..."))
    assert_equal(*result_pair("./../..///.../..//././"))
    assert_equal(*result_pair("///././././/.//....///"))
    assert_equal(*result_pair("http://www.example.com"))
    assert_equal(*result_pair("foor for thought"))
    assert_equal(*result_pair("2gb63b@%TY25GHawefb3/g3qb"))
  end

  def test_has_trailing_separator_with_nil
    refute FasterPath.has_trailing_separator?(nil)
  end

  def test_has_trailing_separator_with_unicode_2014
    assert_equal(*result_pair("http://www.ex—ample.com"))
    assert_equal(*result_pair("foor for thou—ght"))
    assert_equal(*result_pair("2gb63b@%TY25G—Hawefb3/g3qb"))
  end
end
