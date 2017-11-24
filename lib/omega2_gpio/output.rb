# coding: utf-8
module Omega2Gpio
  class Output < Gpio
    def initialize(gpio_number)
      super(gpio_number, "output")
    end

    def set(value)
      command = "fast-gpio set #{self.gpio_number} #{value}"
      if Omega2Gpio.configuration.mock
        mock_fast_gpio_command command
      else
        execute_fast_gpio_command command
      end
      @value = value

      self
    end

    def high
      set(1)
    end

    def low
      set(0)
    end

  end
end
