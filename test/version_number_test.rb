# coding: utf-8
require 'test_helper'

class VersionTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Omega2Gpio::VERSION
  end
end
