# frozen_string_literal: true

require_relative './climate_api_shared_example'

RSpec.describe 'The native Climate API' do
  subject(:climate_api) { ClimateApiDemo::ClimateApi.new }

  it_behaves_like 'the Climate API in'
end
