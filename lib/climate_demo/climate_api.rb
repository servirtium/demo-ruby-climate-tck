# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'json'

module ClimateApiDemo
  # Wrap the Climate Data API of the World Bank as an example API for handling remote API calls
  class ClimateApi
    DOMAIN = 'http://worldbank-api-for-servirtium.local.gd:4567'
    CLIMATE_API = 'climateweb/rest/v1/country'
    ANNUAL_AVERAGE = 'annualavg'
    PRECIPITATION = 'pr'

    def initialize(domain = DOMAIN)
      @climate_api = "#{domain}/#{CLIMATE_API}"
    end

    def average_annual_rainfall(from_year, to_year, *country_isos)
      connection = climate_api_connection
      rainfall_averages = country_isos.map do |country_iso|
        country_rainfall_average(connection, country_iso, from_year, to_year)
      end
      rainfall_averages.sum / rainfall_averages.size
    end

    private

    def climate_api_connection
      Faraday.new @climate_api do |conn|
        conn.response :xml, content_type: /\bxml$/
        conn.response :json, content_type: /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end

    def country_rainfall_average(connection, country_iso, from_year, to_year)
      response = country_rainfall(connection, country_iso, from_year, to_year)
      raise "Date range #{from_year}-#{to_year} is not supported" unless response.body['list']

      rainfall = response.body['list'].values.first
      compute_average(rainfall)
    end

    def compute_average(rainfall)
      rainfall.sum { |x| x['annualData'].values.first.to_f } / rainfall.size
    end

    def country_rainfall(connection, country_iso, from_year, to_year, format = 'xml')
      rainfall = average_rainfall_request(country_iso, from_year, to_year)
      connection.get("#{rainfall}.#{format}")
    end

    def average_rainfall_request(country_iso, from_year, to_year)
      "#{ANNUAL_AVERAGE}/#{PRECIPITATION}/#{from_year}/#{to_year}/#{country_iso}"
    end
  end
end
