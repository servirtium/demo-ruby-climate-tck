# frozen_string_literal: true

require_relative './climate_api_shared_example'
require 'spec_helper'
require 'demo_server'
require 'servirtium_servlet'

RSpec.describe 'The Climate API record (via Servirtium)' do
  subject(:climate_api) { ClimateApiDemo::ClimateApi.new("http://127.0.0.1:#{PORT}") }

  let(:delta) { 0.0000000001 }

  before(:each) do |example|
    playback_name = "#{self.class.description}/#{example.description}".downcase.gsub(' ', '_')
    ServirtiumDemo.domain = ClimateApiDemo::ClimateApi::DOMAIN
    ServirtiumDemo.example = playback_name
    ServirtiumDemo.record = true
    ServirtiumDemo.interaction = 0
  end

  # Switch to the shared example here, once all tests below are passing
  # it_behaves_like 'the Climate API in'

  context 'returning average rainfall from 1980 to 1999' do
    let(:delta) { 0.0000000001 }

    it 'for Great Britain' do
      result = climate_api.average_annual_rainfall(1980, 1999, 'gbr')
      expect(result).to be_within(delta).of 988.8454972331015
    end

    it 'for Great Britain and France combined' do
      result = climate_api.average_annual_rainfall(1980, 1999, 'gbr', 'fra')
      expect(result).to be_within(delta).of 951.3220963726872
    end
  end

  context 'that the average rainfall not supported' do
    it 'for Great Britain from 1985 to 1995' do
      expect { climate_api.average_annual_rainfall(1985, 1995, 'gbr') }.to(
        raise_error(/not supported/)
      )
    end

    it 'for Middle Earth' do
      expect { climate_api.average_annual_rainfall(1980, 1999, 'mde') }.to(
        raise_error(/Invalid country code/)
      )
    end
  end
end
