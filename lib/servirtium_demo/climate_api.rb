# frozen_string_literal: true

require 'faraday'
require 'json'

module ServirtiumDemo
  class ClimateApi
    CLIMATE_API    = 'http://climatedataapi.worldbank.org/climateweb/rest/v1/country'
    ANNUAL_AVERAGE = '/annualavg'
    PRECIPITATION  = '/pr'

    def get_average_annual_rainfall(from_year, to_year, *country_isos)
      rainfall_averages = country_isos.map do |country_iso|
        response = Faraday.get average_rainfall_url(country_iso, from_year, to_year)
        body     = JSON.parse response.body
        body.sum { |x| x['annualData'].first } / body.size
      end
      rainfall_averages.sum / rainfall_averages.size
    end

    private

    def average_rainfall_url(country_iso, from_year, to_year)
      CLIMATE_API + ANNUAL_AVERAGE + PRECIPITATION + "/#{from_year}/#{to_year}/#{country_iso}"
    end
  end
end