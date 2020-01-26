# frozen_string_literal: true

require_relative './climate_api_shared_example'
require 'spec_helper'
require 'demo_server'

RSpec.describe 'Climate API Playback' do
  subject(:climate_api) { ClimateApiDemo::ClimateApi.new("http://127.0.0.1:#{port}") }

  let(:port) { 61_417 }
  let(:delta) { 0.0000000001 }

  before do
    @thread = Thread.new {
      @server = ServirtiumDemo::DemoServer.new
      @server.start
    }
  end

  # Uncomment to see the current status
  #it_behaves_like 'the Climate API'

  # Specs for Debugging

  it 'for Great Britain' do
    result = climate_api.average_annual_rainfall(1980, 1999, 'gbr')
    expect(result).to be_within(delta).of 988.8454972331015
  end
end
