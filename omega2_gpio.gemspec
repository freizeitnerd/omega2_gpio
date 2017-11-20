# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omega2_gpio/version'

Gem::Specification.new do |spec|
  spec.name          = "omega2_gpio"
  spec.version       = Omega2Gpio::VERSION
  spec.authors       = ["Sönke Ohls"]
  spec.email         = ["s@ohls.eu"]

  spec.summary       = "Ruby wrapper to control Onion Omega2 GPIOs"
  spec.description   = "Ruby wrapper to control Onion Omega2 GPIOs"
  spec.homepage      = "https://github.com/freizeitnerd/omega2_gpio"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
