# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'devise_rails_api_authentication/version'

Gem::Specification.new do |spec|
  spec.name = 'devise_rails_api_authentication'
  spec.version = DeviseRailsApiAuthentication::VERSION
  spec.authors = ['Jakub Pawlowicz', 'Matthew MacLeod', 'Paul Mucur']
  spec.email = %w(jakub@altmetric.com matt@matt-m.co.uk paul@altmetric.com)
  spec.summary = %q{Rails-api authentication using devise}
  spec.homepage = ''
  spec.license = 'MIT?'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'actionpack', '~> 4.1.0'
  spec.add_dependency 'activerecord', '~> 4.1.0'
  spec.add_dependency 'devise', '~> 3.4.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
end
