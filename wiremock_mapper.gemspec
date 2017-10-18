$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))

Gem::Specification.new do |spec|
  spec.name             = 'wiremock_mapper'
  spec.version          = '1.2.0'
  spec.platform         = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 1.9.3'
  spec.authors          = ['Isaac Datlof']
  spec.email            = 'ike18t@gmail.com'

  spec.homepage         = 'http://github.com/ike18t/wiremock_mapper'
  spec.license          = 'MIT'
  spec.summary          = 'Ruby DSL for setting up WireMock mappings'
  spec.description      = spec.summary

  spec.files            = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.test_files       = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables      = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.extra_rdoc_files = ['LICENSE.txt', 'README.md']
  spec.require_paths    = ['lib']

  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'json', '1.8.3'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'require_all'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop', '0.41.2'
  # public_suffix needed to be included and locked down due to webmock
  spec.add_development_dependency 'public_suffix', '1.4.6'
  spec.add_development_dependency 'webmock', '2.2.0'
end
