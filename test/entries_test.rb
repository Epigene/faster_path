# encoding: UTF-8
require 'test_helper'
require_relative '../lib/faster_path/optional/refinements.rb'

class EntriesTest < Minitest::Test
  def test_it_returns_similar_results_to_pathname_entries_as_strings
    ['.', 'lib', 'src'].each do |pth|
      assert_equal Pathname.new(pth).entries.map(&:to_s).sort,
                   FasterPath.entries(pth).sort
    end
  end

  def test_entries_with_unicode_2014
    ['—'].each do |pth|
      assert_raises { Pathname.new(pth).entries }
      assert_raises do
        using FasterPath::RefinePathname
        Pathname.new(pth).entries
      end
      assert_raises { FasterPath.entries(pth) }
    end
  end
end
