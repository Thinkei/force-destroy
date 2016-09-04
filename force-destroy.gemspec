# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'force/destroy/version'

Gem::Specification.new do |spec|
  spec.name          = "force-destroy"
  spec.version       = Force::Destroy::VERSION
  spec.authors       = ["Thu Kim"]
  spec.email         = ["kimthu.bui@gmail.com"]

  spec.summary       = %q{A small gem that forces deleting a record together with its associations}
  spec.description   = %q{same as summary. Note: it does not trigger any callbacks.}
  spec.homepage      = "https://github.com/thukim/force-destroy"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org/"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency('activesupport', '>= 3.2.3')

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.0'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'factory_girl_rails'
  spec.add_development_dependency 'database_cleaner', '1.5.3'

  spec.add_development_dependency 'byebug'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'sqlite3'
end
