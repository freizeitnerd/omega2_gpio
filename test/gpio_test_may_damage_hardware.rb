# coding: utf-8
require 'test_helper'
require 'minitest/hooks'

class MayDamageHardwareGpioTest < Minitest::Test
  include Minitest::Hooks

  before(:all) do
    puts "These test will actually trigger GPIO's and may damage your hardware"
    @default_mock = Omega2Gpio.configuration.mock
    Omega2Gpio.configuration.mock = false
    @default_messaging_level = Omega2Gpio.configuration.messaging_level
    Omega2Gpio.configuration.messaging_level = 2
  end

  after(:all) do
    Omega2Gpio.configuration.mock = @default_mock
    Omega2Gpio.configuration.messaging_level = @default_messaging_level
  end

  def test_several_ouput_gpios_and_switch_them_from_high_to_low
    gpio_numbers = [0,2,3,11,18,45,46]
    gpios = []

    gpio_numbers.each do |gpio_number|
      gpios.push(Omega2Gpio::Output.new(gpio_number).high)
    end

    gpios.each do |gpio|
      gpio.low
      sleep(0.3)
      gpio.high
    end

    gpios.each do |gpio|
      gpio.low
      sleep(0.1)
      assert gpio.low?
    end
  end
end