# encoding: UTF-8
require 'test_helper'

class BlankTest < Minitest::Test
  def test_it_is_blank?
    assert FasterPath.blank? "  "
    assert FasterPath.blank? ""
    assert FasterPath.blank? nil
  end

  def test_blank_can_check_unicode_2014
    refute FasterPath.blank? " — "
  end
end
