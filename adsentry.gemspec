# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'adsentry/version'

Gem::Specification.new do |spec|
  spec.name          = "adsentry"
  spec.version       = Adsentry::VERSION
  spec.authors       = ["Justin Litchfield"]
  spec.email         = ["justin@ownlocal.com"]
  spec.description   = %q{Monitor the states of ads in AdForge}
  spec.summary       = %q{This uses Redis to store sets of ads that need processing along various steps}
  spec.homepage      = "http://github.com/OwnLocal/adsentry"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"

  spec.add_runtime_dependency "redis", "~> 3.0.5"
  spec.add_runtime_dependency "hiredis", "~> 0.4.5"
  spec.add_runtime_dependency "redis-namespace", "~> 1.3.2"
  spec.add_runtime_dependency "raygun4ruby"
end
