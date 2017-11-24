# coding: utf-8
module Omega2Gpio
  class Input < Gpio
    def initialize(gpio_number)
      super(gpio_number, "input")
    end
  end
end