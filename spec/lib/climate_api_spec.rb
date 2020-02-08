# frozen_string_literal: true

require_relative './climate_api_shared_example'

RSpec.describe 'Climate API' do
  subject(:climate_api) { ClimateApiDemo::ClimateApi.new }

  it_behaves_like 'the Climate API direct in'
end
