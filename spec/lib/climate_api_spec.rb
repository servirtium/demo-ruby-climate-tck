# frozen_string_literal: true

require_relative './climate_api_shared_example'

RSpec.describe 'Climate API' do
  subject(:climate_api) { ClimateApiDemo::ClimateApi.new }

  it_behaves_like 'the Climate API'

  # Specs for Debugging

  context 'returns average rainfall from 1980 to 1999' do
    let(:delta) { 0.0000000001 }

    it 'for Great Britain xml' do
      result = climate_api.average_annual_rainfall(1980, 1999, 'gbr')
      expect(result).to be_within(delta).of 988.8454972331015
    end
  end

  context 'average rainfall not supported' do
    it 'for Great Britain from 1985 to 1995' do
      expect { climate_api.average_annual_rainfall(1985, 1995, 'gbr') }.to(
        raise_error(/not supported/)
      )
    end
  end
end
