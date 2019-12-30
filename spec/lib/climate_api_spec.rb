# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Servirtium::ClimateApi do
  context 'returns average rainfall from 1980 to 1999' do
    DELTA = 0.0000000001

    it 'for Great Britain' do
      result = subject.get_average_annual_rainfall(1980, 1999, 'gbr')
      expect(result).to be_within(DELTA).of 988.8454972331015
    end

    it 'for France' do
      result = subject.get_average_annual_rainfall(1980, 1999, 'fra')
      expect(result).to be_within(DELTA).of 913.7986955122727
    end

    it 'for Egypt' do
      result = subject.get_average_annual_rainfall(1980, 1999, 'egy')
      expect(result).to be_within(DELTA).of 54.58587712129825
    end
  end
end