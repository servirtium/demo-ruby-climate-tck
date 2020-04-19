# frozen_string_literal: true

require_relative '../lib/../lib/climate_demo'
require 'rspec'
require 'servirtium/ruby/demo_server'

PORT = 61_417

RSpec.configure do |config|
  $server_thread = nil

  config.before(:suite) do
    $server_thread = Thread.new do
      Thread.current[:server] = Servirtium::Ruby::DemoServer.new PORT
      Thread.current[:server].start
    end
  end

  config.after(:suite) do
    s = $server_thread[:server]
    s.stop
    $server_thread.join 3
    Thread.kill $server_thread
  end
end
