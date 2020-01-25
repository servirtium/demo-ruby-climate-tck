# frozen_string_literal: true

require 'spec_helper'
require_relative '../current_context'

RSpec.shared_examples 'the Climate API' do
  context 'returns average rainfall from 1980 to 1999' do
    let(:delta) { 0.0000000001 }

    it 'for Great Britain' do |ctx|
      CurrentContext.update("#{self.class.description} #{ctx.description}")
      result = climate_api.get_average_annual_rainfall(1980, 1999, 'gbr')
      expect(result).to be_within(delta).of 988.8454972331015
    end

    it 'for France' do |ctx|
      CurrentContext.update("#{self.class.description} #{ctx.description}")
      result = climate_api.get_average_annual_rainfall(1980, 1999, 'fra')
      expect(result).to be_within(delta).of 913.7986955122727
    end

    it 'for Egypt' do |ctx|
      CurrentContext.update("#{self.class.description} #{ctx.description}")
      result = climate_api.get_average_annual_rainfall(1980, 1999, 'egy')
      expect(result).to be_within(delta).of 54.58587712129825
    end

    it 'for both Great Britain & France combined' do |ctx|
      CurrentContext.update("#{self.class.description} #{ctx.description}")
      result = climate_api.get_average_annual_rainfall(1980, 1999, 'gbr', 'fra')
      expect(result).to be_within(delta).of 951.3220963726872
    end
  end

  context 'average rainfall not supported' do
    it 'for Great Britain from 1985 to 1995' do |ctx|
      CurrentContext.update("#{self.class.description} #{ctx.description}")
      expect { climate_api.get_average_annual_rainfall(1985, 1995, 'gbr') }.to(
        raise_error(/not supported/)
      )
    end

    it 'for Middle Earth' do |ctx|
      CurrentContext.update("#{self.class.description} #{ctx.description}")
      expect { climate_api.get_average_annual_rainfall(1980, 1999, 'mde') }.to(
        raise_error(/Invalid country code/)
      )
    end
  end
end
