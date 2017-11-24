# coding: utf-8
module Omega2Gpio
  class Gpio
    attr_reader :gpio_number
    attr_reader :value
    attr_reader :direction

    def initialize(gpio_number, direction)
      @gpio_number = gpio_number
      @value = 0
      @direction = direction

      if Omega2Gpio.configuration.mock && gpio_number.between?(0, Omega2Gpio.configuration.highest_gpio_number)
        Omega2Gpio.messenger.debug "Init Fake-GPIO#{@gpio_number} and mock all interactions as valid"
      else
        set_direction(direction)
      end

      self
    end

    def self.is_mock?
      Omega2Gpio.configuration.mock
    end

    def read
      if Omega2Gpio.configuration.mock
        Omega2Gpio.messenger.debug "Mocked GPIO#{self.gpio_number} value is '#{@value}'"
      else
        stdout = execute_fast_gpio_command "fast-gpio read #{@gpio_number}"
        @value = stdout.gets.to_s.split.last.to_i
      end

      @value
    end

    def get
      read
    end

    def is_high?
      read == 1
    end

    def high?
      is_high?
    end

    def is_low?
      read == 0
    end

    def low?
      is_low?
    end

    private

    def execute_fast_gpio_command(command)
      stdin, stdout, stderr = Open3.popen3(command)
      if stderr.gets
        Omega2Gpio.raise_error(stderr.gets)
      end
      Omega2Gpio.messenger.debug "Fast-Gpio command: #{command}"
      Omega2Gpio.messenger.debug "  returns: #{stdout}"
      stdout
    end

    # Direction should be set via initialize-method only
    def set_direction(direction)
      execute_fast_gpio_command "fast-gpio set-#{direction} #{self.gpio_number}"
    end


  end
end
