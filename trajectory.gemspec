# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trajectory/version'

Gem::Specification.new do |gem|
  gem.name          = "trajectory"
  gem.version       = Trajectory::VERSION
  gem.authors       = ["Loïc Minaudier"]
  gem.email         = ["loic.minaudier@gmail.com"]
  gem.description   = %q{Ruby API Wrapper for Thoughbot Trajectory app}
  gem.summary       = %q{Ruby API Wrapper for Thoughbot Trajectory app}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency 'virtus', '~> 0.5.4'
  gem.add_runtime_dependency 'httparty', '~> 0.11.0'
end
