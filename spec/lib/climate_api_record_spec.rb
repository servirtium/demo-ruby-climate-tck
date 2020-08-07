# frozen_string_literal: true

require_relative './climate_api_shared_example'
require 'spec_helper'
require 'servirtium/demo_server'
require 'servirtium/servirtium_servlet'

RSpec.describe 'The Climate API record (via Servirtium)' do
  subject(:climate_api) { ClimateApiDemo::ClimateApi.new("http://127.0.0.1:#{PORT}") }

  let(:delta) { 0.0000000001 }

  before(:each) do |example|
    playback_name = "#{self.class.description}/#{example.description}".downcase.gsub(' ', '_')
    Servirtium.domain = ClimateApiDemo::ClimateApi::DOMAIN
    Servirtium.example = playback_name
    Servirtium.pretty_print = true
    Servirtium.record = true
    # Can interaction be encapsulated - not accessed in the usages of Servirtium?
    Servirtium.interaction = 0
  end

  it_behaves_like 'the Climate API in'
end
