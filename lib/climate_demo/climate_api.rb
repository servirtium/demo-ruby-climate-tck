# frozen_string_literal: true

require "http"
require 'json'
require 'rexml/document'

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
      average_rainfall_url = average_rainfall_url(country_iso, from_year, to_year)
      puts average_rainfall_url
      begin
        body = HTTP.get(average_rainfall_url).to_s
      rescue HTTP::ConnectionError
        puts "Connection Error: " + average_rainfall_url
        raise "not supported Invalid country code"
      end

      raise "Date range #{from_year}-#{to_year} is not supported" if body == "<list/>"
      raise "Invalid country code #{country_iso}" if body == "Invalid country code. Three letters are required"

      xmldoc = REXML::Document.new(body)

      rains = []
      xmldoc.elements.each("//annualData/double") do |r| rains << r.text.to_f end
      rains.sum / rains.size.to_f
    end

    def average_rainfall_url(country_iso, from_year, to_year)
      "#{@climate_api}/#{ANNUAL_AVERAGE}/#{PRECIPITATION}/#{from_year}/#{to_year}/#{country_iso}.xml"
    end
  end
end
