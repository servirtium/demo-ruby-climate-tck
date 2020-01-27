# frozen_string_literal: true

require_relative './climate_api_shared_example'
require 'spec_helper'
require 'demo_server'

RSpec.describe 'Climate API Playback' do
  subject(:climate_api) { ClimateApiDemo::ClimateApi.new("http://127.0.0.1:#{port}") }

  let(:port) { 61_417 }
  let(:delta) { 0.0000000001 }

  before(:all) do
    @thread = Thread.new {
      @server = ServirtiumDemo::DemoServer.new
      CurrentContext.setListener(@server)
      @server.start
    }
  end

  after(:all) do
    CurrentContext.unSetListener
  end

  # Uncomment to see the current status
  it_behaves_like 'the Climate API'

end
