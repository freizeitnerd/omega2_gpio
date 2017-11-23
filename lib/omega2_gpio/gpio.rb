# coding: utf-8
module Omega2Gpio
  class Gpio
    attr_reader :gpio_number
    attr_reader :value

    def initialize(gpio_number)
      @gpio_number = gpio_number
      @value = 0

      if Omega2Gpio.configuration.mock and gpio_number.between?(0, Omega2Gpio.configuration.highest_gpio_number)
        Omega2Gpio.messenger.debug "Init Fake-GPIO#{@gpio_number} and mock all interactions as valid"
      else
        set_direction('output')
      end

      self
    end

    def self.is_mock?
      Omega2Gpio.configuration.mock
    end

    def set_direction(direction)
      execute_fast_gpio_command "fast-gpio set-#{direction} #{self.gpio_number}"
    end

    def read
      if Omega2Gpio.configuration.mock
        Omega2Gpio.messenger.debug "Mocked GPIO#{self.gpio_number} value is '#{@value}'"
      else
        stdin, stdout, stderr = Open3.popen3("fast-gpio read #{@gpio_number}")
        if stderr.gets
          raise_error(stderr.gets)
        else
          @value = stdout.gets.to_s.split.last.to_i
        end
      end

      @value
    end

    def get
      read
    end

    def is_high?
      self.read == 1
    end

    def is_low?
      self.read == 0
    end

    private

    def execute_fast_gpio_command(command)
      stdin, stdout, stderr = Open3.popen3(command)
      if stderr.gets
        Omega2Gpio.raise_error(stderr.gets)
      end
    end
  end
end
