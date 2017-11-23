# coding: utf-8
module Omega2Gpio
  class Configuration

    # Controls whether the GPIO shall be controlled on Onion Omegas file system
    # or just mocked/faked as valid to allow development on systems that
    # do not support Omega's GPIO control and would raise errors constantly
    # Defaults to `false`. Set to `true` to mock Onion Omega GPIO
    attr_accessor :mock

    # Controls whether the Gem shall write debug messages
    # to standard out.
    # This can be helpful messages like file system commands that are mocked
    # Defaults to :debug.
    # Defined are
    #   2  ==> puts all messages
    #   1  ==> puts warnings
    #   0  ==> no messages at all
    attr_accessor :messaging_level

    # depends on Onion Omega2 hardware,
    # needed to raise error in mock-mode
    attr_accessor :highest_gpio_number

    def initialize
      @mock = false
      @messaging_level = 2
      @highest_gpio_number = 46
    end
  end

  # @return [Omega2Gpio::Configuration] Omega2Gpio's current configuration
  def self.configuration
    @configuration ||= Configuration.new
  end

  ## Set Omega2Gpio's configuration
  ## @param config [Omega2Gpio::Configuration]
  def self.configuration=(config)
    @configuration = config
  end

  # Modify Omega2Gpio's current configuration
  # @yieldparam [Omega2Gpio::Configuration] config current Omega2Gpio config
  # ```
  # Omega2Gpio.configure do |config|
  #   config.routes = false
  # end
  # ```
  def self.configure
    yield configuration
  end
end

# Configuration pattern stolen from Thoughtbot's Clearance
# https://github.com/thoughtbot/clearance/blob/master/lib/clearance/configuration.rb
