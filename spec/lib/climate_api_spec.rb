# frozen_string_literal: true

require_relative './climate_api_shared_example'

RSpec.describe 'Climate API' do
  subject(:climate_api) { ServirtiumDemo::ClimateApi.new }

  it_behaves_like 'the Climate API'

  # Specs for Debugging

  context 'returns average rainfall from 1980 to 1999' do
    let(:delta) { 0.0000000001 }

    it 'for Great Britain' do
      result = climate_api.get_average_annual_rainfall(1980, 1999, 'gbr')
      expect(result).to be_within(delta).of 988.8454972331015
    end
  end
end
