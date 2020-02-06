# frozen_string_literal: true

require_relative './climate_api_shared_example'
require 'spec_helper'
require 'demo_server'

RSpec.describe 'Climate API Playback' do
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
  end

  # Switch to the shared example here, once all tests below are passing
  # it_behaves_like 'the Climate API'

  # Specs for Debugging

  context 'returns average rainfall from 1980 to 1999' do
    let(:delta) { 0.0000000001 }

    it 'for Great Britain' do
      result = climate_api.average_annual_rainfall(1980, 1999, 'gbr')
      expect(result).to be_within(delta).of 988.8454972331015
    end

    it 'for France' do
      result = climate_api.average_annual_rainfall(1980, 1999, 'fra')
      expect(result).to be_within(delta).of 913.7986955122727
    end

    it 'for Egypt' do
      result = climate_api.average_annual_rainfall(1980, 1999, 'egy')
      expect(result).to be_within(delta).of 54.58587712129825
    end

    xit 'for both Great Britain & France combined' do
      result = climate_api.average_annual_rainfall(1980, 1999, 'gbr', 'fra')
      expect(result).to be_within(delta).of 951.3220963726872
    end
  end

  context 'average rainfall not supported' do
    xit 'for Great Britain from 1985 to 1995' do
      expect { climate_api.average_annual_rainfall(1985, 1995, 'gbr') }.to(
        raise_error(/not supported/)
      )
    end

    xit 'for Middle Earth' do
      expect { climate_api.average_annual_rainfall(1980, 1999, 'mde') }.to(
        raise_error(/Invalid country code/)
      )
    end
  end
end
