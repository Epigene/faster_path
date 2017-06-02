# encoding: UTF-8
require 'test_helper'

class AddTrailingSeparatorTest < Minitest::Test
  def target_method; :add_trailing_separator end
  def test_it_handles_nil
    refute FasterPath.add_trailing_separator nil
  end

  def test_add_trailing_separator
    assert_equal FasterPath.add_trailing_separator(''), ''
    assert_equal FasterPath.add_trailing_separator('/'), '/'
    assert_equal FasterPath.add_trailing_separator('//'), '//'
    assert_equal FasterPath.add_trailing_separator('hello'), 'hello/'
    assert_equal FasterPath.add_trailing_separator('hello/'), 'hello/'
    assert_equal FasterPath.add_trailing_separator('/hello/'), '/hello/'
    assert_equal FasterPath.add_trailing_separator('/hello//'), '/hello//'
    assert_equal FasterPath.add_trailing_separator('.'), './'
    assert_equal FasterPath.add_trailing_separator('./'), './'
    assert_equal FasterPath.add_trailing_separator('.//'), './/'
  end

  def test_add_trailing_separator_in_dosish_context
    if File.dirname('A:') == 'A:.'
      assert_equal FasterPath.add_trailing_separator('A:'), 'A:/'
      assert_equal FasterPath.add_trailing_separator('A:/'), 'A:/'
      assert_equal FasterPath.add_trailing_separator('A://'), 'A://'
      assert_equal FasterPath.add_trailing_separator('A:.'), 'A:./'
      assert_equal FasterPath.add_trailing_separator('A:./'), 'A:./'
      assert_equal FasterPath.add_trailing_separator('A:.//'), 'A:.//'
    end
  end

  def test_add_trailing_separator_against_pathname_implementation1
    assert_equal(*result_pair(''))
    assert_equal(*result_pair('/'))
    assert_equal(*result_pair('//'))
    assert_equal(*result_pair('hello'))
    assert_equal(*result_pair('hello/'))
    assert_equal(*result_pair('/hello/'))
    assert_equal(*result_pair('/hello//'))
  end

  def test_add_trailing_separator_against_pathname_implementation2
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

  def test_add_trailing_separator_against_pathname_implementation3
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

  def test_add_trailing_separator_with_unicode_2014
    assert_equal(*result_pair("2g—63b@%TY25GHawe—b3/g3qb"))
  end
end
