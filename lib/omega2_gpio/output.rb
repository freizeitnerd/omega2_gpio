module Omega2Gpio
  class Output < Gpio

    def set(value)
      if Omega2Gpio.configuration.mock
        @value = value
        Omega2Gpio.messenger.debug "Mocked GPIO#{self.gpio_number} is set to '#{@value}'"
      else
        stdin, stdout, stderr = Open3.popen3("fast-gpio set #{self.gpio_number} #{value}")
        if stderr.gets
          raise_error(stderr.gets)
        else
          @value = value
        end
      end

      self.read == value
    end

  end
end
