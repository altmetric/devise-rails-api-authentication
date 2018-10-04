# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'devise_rails_api_authentication/version'

Gem::Specification.new do |spec|
  spec.name = 'devise_rails_api_authentication'
  spec.version = DeviseRailsApiAuthentication::VERSION
  spec.authors = ['Jakub Pawlowicz', 'Matthew MacLeod', 'Paul Mucur']
  spec.email = %w(jakub@altmetric.com matt@matt-m.co.uk paul@altmetric.com)
  spec.summary = %q{Token-based rails-api authentication with Devise}
  spec.homepage = 'https://github.com/altmetric/devise-rails-api-authentication'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'actionpack', '~> 4.2'
  spec.add_dependency 'devise', '~> 3.5'
  spec.add_dependency 'responders', '~> 2.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.49'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'guard-rspec'
end
