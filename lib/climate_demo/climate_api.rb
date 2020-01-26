# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'json'

module ClimateApiDemo
  # Wrap the Climate Data API of the World Bank as an example API for handling remote API calls
  class ClimateApi
    DOMAIN = 'http://climatedataapi.worldbank.org'
    CLIMATE_API = 'climateweb/rest/v1/country'
    ANNUAL_AVERAGE = 'annualavg'
    PRECIPITATION = 'pr'

    def initialize(domain = DOMAIN)
      @climate_api = "#{domain}/#{CLIMATE_API}"
    end

    def get_average_annual_rainfall(from_year, to_year, *country_isos)
      connection = climate_api_connection
      rainfall_averages = country_isos.map do |country_iso|
        response = average_annual_rainfall_for_country_xml(connection, country_iso, from_year, to_year)
        body = response['list'].values.first
        body.sum { |x| x['annualData'].values.first.to_f } / body.size
      end
      rainfall_averages.sum / rainfall_averages.size
    end

    def average_annual_rainfall_for_country_json_new(from_year, to_year, *country_isos)
      connection = climate_api_connection
      rainfall_averages = country_isos.map do |country_iso|
        body = average_annual_rainfall_for_country(connection, country_iso, from_year, to_year)
        #raise "Date range #{from_year}-#{to_year} is not supported" if body.empty?
        body.sum { |x| x['annualData'].first } / body.size
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

    def average_annual_rainfall_for_country_xml(connection, country_iso, from_year, to_year)
      average_annual_rainfall_for_country(connection, country_iso, from_year, to_year, 'xml')
    end
    def average_annual_rainfall_for_country(connection, country_iso, from_year, to_year, format = 'json')
      rainfall = average_rainfall(country_iso, from_year, to_year)
      response = case format
                 when 'json'
                   json_response = connection.get("#{rainfall}.json")
                   json_response.body #=> { ... }
                 when 'xml'
                   xml_response = connection.get("#{rainfall}.xml")
                   xml_response.body #=> { ... }
                 end
      response
    end

    def average_rainfall(country_iso, from_year, to_year)
      "#{ANNUAL_AVERAGE}/#{PRECIPITATION}/#{from_year}/#{to_year}/#{country_iso}"
    end

    def average_rainfall_url(country_iso, from_year, to_year, format = 'json')
      rainfall_api = "#{@climate_api}/#{ANNUAL_AVERAGE}/#{PRECIPITATION}"
      "#{rainfall_api}/#{from_year}/#{to_year}/#{country_iso}.#{format}"
    end
  end
end
