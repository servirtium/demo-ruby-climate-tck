# frozen_string_literal: true

require_relative './climate_api_shared_example'
require 'spec_helper'
require 'servirtium/ruby/demo_server'
require 'servirtium/ruby/servirtium_servlet'

RSpec.describe 'The Climate API record (via Servirtium)' do
  subject(:climate_api) { ClimateApiDemo::ClimateApi.new("http://127.0.0.1:#{PORT}") }

  let(:delta) { 0.0000000001 }

  before(:each) do |example|
    playback_name = "#{self.class.description}/#{example.description}".downcase.gsub(' ', '_')
    Servirtium::Ruby.domain = ClimateApiDemo::ClimateApi::DOMAIN
    Servirtium::Ruby.example = playback_name
    Servirtium::Ruby.record = true
    Servirtium::Ruby.interaction = 0
  end

  it_behaves_like 'the Climate API in'
end
