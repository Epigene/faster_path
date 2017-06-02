# encoding: UTF-8
require 'test_helper'

class BasenameTest < Minitest::Test
  def test_nil_inputs
    assert_nil FasterPath.basename(nil, nil)
    assert_equal FasterPath.basename('', nil), ""
    assert_nil FasterPath.basename(nil, '')
    assert_equal FasterPath.basename('asdf', nil), "asdf"
    assert_nil FasterPath.basename(nil, 'asdf')
  end

  # Tests copied from https://searchcode.com/codesearch/view/12785140/
  def test_it_creates_basename_correctly
    assert_equal FasterPath.basename('/home/gumby/work/ruby.rb'),        'ruby.rb'
    assert_equal FasterPath.basename('/home/gumby/work/ruby.rb', '.rb'), 'ruby'
    assert_equal FasterPath.basename('/home/gumby/work/ruby.rb', '.*'),  'ruby'
    assert_equal FasterPath.basename('ruby.rb',  '.*'),  'ruby'
    assert_equal FasterPath.basename('/ruby.rb', '.*'),  'ruby'
    assert_equal FasterPath.basename('ruby.rbx', '.*'),  'ruby'
    assert_equal FasterPath.basename('ruby.rbx', '.rb'), 'ruby.rbx'
    assert_equal FasterPath.basename('ruby.rb', ''),      'ruby.rb'
    assert_equal FasterPath.basename('ruby.rbx', '.rb*'), 'ruby.rbx'
    assert_equal FasterPath.basename('ruby.rbx'), 'ruby.rbx'

    # Try some extensions w/o a '.'
    assert_equal FasterPath.basename('ruby.rbx', 'rbx'), 'ruby.'
    assert_equal FasterPath.basename('ruby.rbx', 'x'),   'ruby.rb'
    assert_equal FasterPath.basename('ruby.rbx', '*'),   'ruby.rbx'

    # A couple of regressions:
    assert_equal FasterPath.basename('', ''),           ''
    assert_equal FasterPath.basename('/'),              '/'
    assert_equal FasterPath.basename('//'),             '/'
    assert_equal FasterPath.basename('//dir///base//'), 'base'
    assert_equal FasterPath.basename('.x', '.x'), '.x'

    # returns the basename for unix suffix
    assert_equal FasterPath.basename("bar.c", ".c"), "bar"
    assert_equal FasterPath.basename("bar.txt", ".txt"), "bar"
    assert_equal FasterPath.basename("/bar.txt", ".txt"), "bar"
    assert_equal FasterPath.basename("/foo/bar.txt", ".txt"), "bar"
    assert_equal FasterPath.basename("bar.txt", ".exe"), "bar.txt"
    assert_equal FasterPath.basename("bar.txt.exe", ".exe"), "bar.txt"
    assert_equal FasterPath.basename("bar.txt.exe", ".txt"), "bar.txt.exe"
    assert_equal FasterPath.basename("bar.txt", ".*"), "bar"
    assert_equal FasterPath.basename("bar.txt.exe", ".*"), "bar.txt"
    assert_equal FasterPath.basename("bar.txt.exe", ".txt.exe"), "bar"
  end

  def test_it_does_the_same_as_file_basename
    assert_equal File.basename('/home/gumby/work/ruby.rb'),        'ruby.rb'
    assert_equal File.basename('/home/gumby/work/ruby.rb', '.rb'), 'ruby'
    assert_equal File.basename('/home/gumby/work/ruby.rb', '.*'),  'ruby'
    assert_equal File.basename('ruby.rb',  '.*'),  'ruby'
    assert_equal File.basename('/ruby.rb', '.*'),  'ruby'
    assert_equal File.basename('ruby.rbx', '.*'),  'ruby'
    assert_equal File.basename('ruby.rbx', '.rb'), 'ruby.rbx'
    assert_equal File.basename('ruby.rb', ''),      'ruby.rb'
    assert_equal File.basename('ruby.rbx', '.rb*'), 'ruby.rbx'
    assert_equal File.basename('ruby.rbx'), 'ruby.rbx'

    # Try some extensions w/o a '.'
    assert_equal File.basename('ruby.rbx', 'rbx'), 'ruby.'
    assert_equal File.basename('ruby.rbx', 'x'),   'ruby.rb'
    assert_equal File.basename('ruby.rbx', '*'),   'ruby.rbx'

    # A couple of regressions:
    assert_equal File.basename('', ''),           ''
    assert_equal File.basename('/'),              '/'
    assert_equal File.basename('//'),             '/'
    assert_equal File.basename('//dir///base//'), 'base'
  end

  def test_basename_handles_unicode_2014
    assert_equal File.basename('/home/gumby/work/r—y.rb'),       'r—y.rb'
    assert_equal File.basename('/home/gumby/work/ruby.—', '.—'), 'ruby'
  end
end
