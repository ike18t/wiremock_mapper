require 'bundler/setup'
require 'webmock/rspec'

Bundler.require :development
CodeClimate::TestReporter.start

WebMock.disable_net_connect!(allow: 'codeclimate.com')

require_all 'lib'
