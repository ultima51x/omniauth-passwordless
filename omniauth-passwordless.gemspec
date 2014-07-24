# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + '/lib/omniauth-passwordless/version'

Gem::Specification.new do |gem|
  gem.add_runtime_dependency 'omniauth', '~> 1.0'

  gem.name = 'omniauth-passwordless'
  gem.version = OmniAuth::Passwordless::VERSION
  gem.description = %q{Internal passwordless authentication handlers for OmniAuth.}
  gem.summary = gem.description
  gem.email = ['david@getsmartify.com']
  gem.authors = ['David Hwang']
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') if gem.respond_to? :required_rubygems_version=
end
