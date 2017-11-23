# coding: utf-8
require 'test_helper'

class ConfigurationTest < Minitest::Test
  def test_configuration_mock_default
    assert Omega2Gpio.configuration.mock == false
  end

  def test_configuration_highest_gpio_number_default
    assert Omega2Gpio.configuration.highest_gpio_number == 46
  end
end
