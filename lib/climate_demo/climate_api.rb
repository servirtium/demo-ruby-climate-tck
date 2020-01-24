# frozen_string_literal: true

require 'faraday'
require 'json'

module ClimateApiDemo
  # Wrap the Climate Data API of the World Bank as an example API for handling remote API calls
  class ClimateApi
    DOMAIN         = 'http://climatedataapi.worldbank.org'
    CLIMATE_API    = 'climateweb/rest/v1/country'
    ANNUAL_AVERAGE = 'annualavg'
    PRECIPITATION  = 'pr'

    def initialize(domain = DOMAIN)
      @climate_api = "#{domain}/#{CLIMATE_API}"
    end

    def get_average_annual_rainfall(from_year, to_year, *country_isos)
      rainfall_averages = country_isos.map do |country_iso|
        get_average_annual_rainfall_for_country(country_iso, from_year, to_year)
      end
      rainfall_averages.sum / rainfall_averages.size
    end

    private

    def get_average_annual_rainfall_for_country(country_iso, from_year, to_year)
      response = Faraday.get average_rainfall_url(country_iso, from_year, to_year)
      body     = JSON.parse response.body
      raise "Date range #{from_year}-#{to_year} is not supported" if body.empty?

      body.sum { |x| x['annualData'].first } / body.size
    end

    def average_rainfall_url(country_iso, from_year, to_year)
      "#{@climate_api}/#{ANNUAL_AVERAGE}/#{PRECIPITATION}/#{from_year}/#{to_year}/#{country_iso}"
    end
  end
end
