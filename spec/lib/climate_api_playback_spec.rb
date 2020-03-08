# frozen_string_literal: true

require_relative './climate_api_shared_example'
require 'spec_helper'
require 'demo_server'
require 'servirtium_playback_servlet'

RSpec.describe 'The Climate API playback (via Servirtium)' do
  subject(:climate_api) { ClimateApiDemo::ClimateApi.new("http://127.0.0.1:#{port}") }

  let(:port) { 61_417 }
  let(:delta) { 0.0000000001 }

  before(:all) do
    @thread = Thread.new do
      @server = ServirtiumDemo::DemoServer.new port
      @server.start
    end
  end

  before(:each) do |example|
    playback_name = "#{self.class.description}/#{example.description}".downcase.gsub(' ', '_')
    ServirtiumDemo.example = playback_name
    ServirtiumDemo.interaction = 0
  end

  # Switch to the shared example here, once all tests below are passing
  it_behaves_like 'the Climate API direct in'
end
