$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))

require 'version'

Gem::Specification.new do |spec|
  spec.name             = 'wiremock_mapper'
  spec.version          = WireMockMapper::VERSION
  spec.platform         = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.0.0'
  spec.authors          = ['Isaac Datlof']
  spec.email            = 'ike18t@gmail.com'

  spec.homepage         = 'http://github.com/ike18t/wiremock_mapper'
  spec.license          = 'MIT'
  spec.summary          = 'Ruby DSL for setting up WireMock mappings'
  spec.description      = spec.summary

  spec.files            = `git ls-files`.split($/)
  spec.test_files       = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables      = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.extra_rdoc_files = ['LICENSE.txt', 'README.md']
  spec.require_paths    = ['lib']

  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'require_all'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'webmock'
end
