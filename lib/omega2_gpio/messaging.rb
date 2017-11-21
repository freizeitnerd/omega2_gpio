module Omega2Gpio
  class Messaging
    def debug(message)
      puts message if Omega2Gpio.configuration.messaging_level >= 2
    end

    def warn(message)
      puts message if Omega2Gpio.configuration.messaging_level >= 1
    end
  end

  def self.messenger
    @messenger ||= Messaging.new
  end
end