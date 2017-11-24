# coding: utf-8
module Omega2Gpio
  class Output < Gpio
    def initialize(gpio_number)
      super(gpio_number, "output")
    end

    def set(value)
      if Omega2Gpio.configuration.mock
        Omega2Gpio.messenger.debug "Mocked GPIO#{self.gpio_number} is set to '#{value}'"
      else
        execute_fast_gpio_command "fast-gpio set #{self.gpio_number} #{value}"
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
