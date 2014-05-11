# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ahoy_events/version'

Gem::Specification.new do |spec|
  spec.name          = "ahoy_events"
  spec.version       = AhoyEvents::VERSION
  spec.authors       = ["Andrew Kane"]
  spec.email         = ["andrew@chartkick.com"]
  spec.summary       = %q{Simple, powerful event tracking for Rails}
  spec.description   = %q{Simple, powerful event tracking for Rails}
  spec.homepage      = "https://github.com/ankane/ahoy_events"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "ahoy_matey", ">= 0.1.8"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
