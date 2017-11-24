# Ruby Gem to control Omega2 GPIO

Control [Onion Omega2](https://onion.io/omega2/) GPIOs in ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omega2_gpio'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omega2_gpio


## Get Started
An Omega2 GPIO can be 
  - an Input
  - an Output or
  - a PWM-Output (not yet implemented in this Gem)
### Input GPIO
To use GPIO1 as an input, just instantiate an Omega2GPIO::Input using the `new`methode and pass in the number of the GPIO to use. (In this case 1 for GPIO1)
This will set the GPIO orientation to 'output'.
```ruby
gpio_number = 1
my_input_gpio = Omega2Gpio::Output.new(gpio_number)
```
Read the value of this GPIO as follows
```ruby
my_input_gpio_value = my_input_gpio.read
```

## Usage

TODO: Write usage instructions here


## Contributing

Bug reports and pull requests are welcome! This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Similar Gems
[@stevenocchipinti's onion_omega](https://github.com/stevenocchipinti/onion_omega) uses a slightly different approach to include GPIO control. It even supports stepper motors.
https://github.com/stevenocchipinti/onion_omega

[@glurp's ruby-onion-omega2](https://github.com/glurp/ruby-onion-omega2)
https://github.com/glurp/ruby-onion-omega2 uses Omega2 file system instead of fast-gpio to control GPIO's. It even allows PWM  and OLED access.