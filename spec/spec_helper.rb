require 'bundler/setup'
require 'webmock/rspec'

Bundler.require :development
SimpleCov.start

WebMock.disable_net_connect!(allow: 'codeclimate.com')

require_all 'lib'
