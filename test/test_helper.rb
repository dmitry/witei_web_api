$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

if ENV["COV_ENABLED"]
  require 'minitest/benchmark'
  require 'simplecov'
  SimpleCov.start
  SimpleCov.merge_timeout 3600
end

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'witei_web_api'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

if ENV["COV_ENABLED"]
  require "minitest/hell"
  
  class Minitest::Test
    # See: https://gist.github.com/chrisroos/b5da6c6a37ac8af5fe78
    parallelize_me! unless defined? WebMock
  end
else
  require "minitest/pride"
end

WiteiWebApi.login = ENV['LOGIN']
WiteiWebApi.password = ENV['PASSWORD']

if defined? WebMock 
  allow = ['codeclimate.com:443']
  WebMock.disable_net_connect!(allow_localhost: false, allow: allow)
end

class WiteiWebApi::Test < MiniTest::Test
  VCR_RECORD_MODE = (ENV['VCR_RECORD_MODE'] || 'once').to_sym
end

