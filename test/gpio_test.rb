# coding: utf-8
require 'test_helper'
require 'minitest/hooks'

class GpioTest < Minitest::Test
  include Minitest::Hooks

  before(:all) do
    @default_mock = Omega2Gpio.configuration.mock
    Omega2Gpio.configuration.mock = true
    @default_messaging_level = Omega2Gpio.configuration.messaging_level
    Omega2Gpio.configuration.messaging_level = 0
  end

  after(:all) do
    Omega2Gpio.configuration.mock = @default_mock
    Omega2Gpio.configuration.messaging_level = @default_messaging_level
  end

  def test_new_output_gpio
    gpio_1 = Omega2Gpio::Output.new(1)
    assert gpio_1.gpio_number == 1
  end

  def test_read_output_gpio
    assert Omega2Gpio::Output.new(1).set(1).read == 1
  end

  def test_read_input_gpio
    assert Omega2Gpio::Input.new(1).read == 0
  end

  def test_get_output_gpio
    assert Omega2Gpio::Output.new(1).set(1).get == 1
  end

  def test_if_output_is_high
    high_output_gpio = Omega2Gpio::Output.new(1).set(1)
    assert high_output_gpio.is_high?
    assert high_output_gpio.high?
  end

  def test_if_output_is_low
    high_output_gpio = Omega2Gpio::Output.new(1).set(0)
    assert high_output_gpio.is_low?
    assert high_output_gpio.low?
  end

  def test_set_output_gpio
    assert Omega2Gpio::Output.new(1).set(1)
  end

  def test_high_method_on_output_gpio
    assert Omega2Gpio::Output.new(1).high.get == 1
  end

  def test_low_method_on_output_gpio
    assert Omega2Gpio::Output.new(1).low.get == 0
  end

  def test_get_value_via_value_method_on_output_gpio
    assert Omega2Gpio::Output.new(1).high.value == 1
  end

  def test_direction_of_output_gpio
    assert Omega2Gpio::Output.new(1).direction == 'output'
  end

  def test_direction_of_input_gpio
    assert Omega2Gpio::Input.new(1).direction == 'input'
  end

  def test_messaging_level_produces_output
    default_messaging_level = Omega2Gpio.configuration.messaging_level
    Omega2Gpio.configuration.messaging_level = 2
    assert_output(/GPIO1/) { Omega2Gpio::Output.new(1) }
    Omega2Gpio.configuration.messaging_level = default_messaging_level
  end

  def test_messaging_level_is_silent
    default_messaging_level = Omega2Gpio.configuration.messaging_level
    Omega2Gpio.configuration.messaging_level = 0
    assert_output("") { Omega2Gpio::Output.new(1) }
    Omega2Gpio.configuration.messaging_level = default_messaging_level
  end

  def test_error_reporting_if_not_existing_gpio_initialized
    assert_raises StandardError do
      Omega2Gpio::Output.new(Omega2Gpio.configuration.highest_gpio_number+1)
    end
  end

end
