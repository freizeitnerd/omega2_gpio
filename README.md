# Ruby Gem to control Omega2 GPIO

Control [Onion Omega2](https://onion.io/omega2/) GPIOs in ruby
TODO: Discribe mocking

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omega2_gpio'
```
And then execute in Omega2's console
```
bundle
```

Or install it yourself in Omega2's console
```
gem install omega2_gpio
```
use following to install latest, likely broken pre-release
```
gem install omega2_gpio --pre
```


## Get Started
### Get the System ready
Make sure Ruby is installed on your Omega2 with all needed extensions
Execute following in Omega2's console:
```
opkg update
opkg install ruby
opkg install ruby-gems ruby-enc-extra ruby-openssl ca-certificates
```
Install this Gem, still in Omega2's console:
```
gem install omega2_gpio
```
If you want to play around in the Ruby Console (IRB), like in the GIF below
install the IRB
```
opkg update
opkg install ruby-irb
```

### Start playing
Execute following in Omega2's console to run the Ruby Console (IRB):
```
irb
```
Ruby console looks like Omega's console but the line should start like this
````ruby
irb(main):001:0>
````
go ahead and play around with one GPIO.
Use one GPIO where nothing is connected to, to not damage your hardware.
It is important to first require the gem, even though it is installed.
````ruby
require "omega2_gpio"
````
This way you switch Omega's GPIO1 from low to high
````ruby
my_gpio = Omega2Gpio::Output.new(1).low
my_gpio.high
````
![alt text](https://github.com/freizeitnerd/omega2_gpio_examples/blob/master/media/omega2_gpio_irb.gif?raw=true "IRB Example to play with Omega2 GPIO in Ruby")

## Usage
TODO: There will be more detailed documentation!!!

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

## Configuration
The Gem can be configured with following the ``Omega2Gpio.configuration`` Object
````ruby
Omega2Gpio.configuration.messaging_level = 0 # silent: No messages to STDOUT (puts)
Omega2Gpio.configuration.messaging_level = 1 # warn: puts only warnings
Omega2Gpio.configuration.messaging_level = 2 # debug: puts hints and fast-gpio commands

Omega2Gpio.configuration.mock = true  # mocks all Omega2 depending commands as valid, like fast-gpio commands
Omega2Gpio.configuration.mock = false # no mock
````

Create a ``config.rb`` to your project to configure omega2_gpio like described above.
Add the file to your ``.gitignore`` file. This way you can have devise dependent configuration.
- On your Omega2 set ``mock`` to ``false`` and ``messaging_level`` to ``0``
- On your development computer  set ``mock`` to ``true`` and ``messaging_level`` to ``2`` to conveniently develop you business logic without touching Omega2 all the time.

## Versioning
[Semantic Versioning](http://semver.org/) versioning is used. For the versions available, see the [tags on this repository](https://github.com/your/project/tags) or
[https://rubygems.org/gems/omega2_gpio](https://rubygems.org/gems/omega2_gpio).

## Contributing
Bug reports and pull requests are welcome! Feel free to refactor! This is my first Gem, I'll be glad to learn!
Please write tests! (see section testing)

## Testing (TDD)
Run ```Rake``` to run all save tests that don't touch your hardware. They are all mocked.
Tests that may damage hardware belong to files ending with ```_test_may_damage_hardware.rb``` in the ```test``` folder.
Run tests that may damage hardware on Omega2 with ```rake damagingtest```.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Similar Gems
[@stevenocchipinti's onion_omega](https://github.com/stevenocchipinti/onion_omega) uses a slightly different approach to include GPIO control. It even supports stepper motors.
https://github.com/stevenocchipinti/onion_omega

[@glurp's ruby-onion-omega2](https://github.com/glurp/ruby-onion-omega2)
https://github.com/glurp/ruby-onion-omega2 uses Omega2 file system instead of fast-gpio to control GPIO's. It even allows PWM  and OLED access.