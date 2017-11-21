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
        set_mode('output')
      end

      self
    end

    def self.is_mock?
      Omega2Gpio.configuration.mock
    end

    def set_mode(direction)
      stdin, stdout, stderr = Open3.popen3("fast-gpio set-#{direction} #{self.gpio_number}")
      if stderr.gets
        Omega2Gpio.raise_error(stderr.gets)
      end
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

  end
end