require 'rails_helper'

RSpec.describe Season, type: :model do

  context 'When creating a new Season' do

    before do
      series = Series.create(name: 'The Flash(2014)') 
    end

    it 'should assign a name before saving' do
      season = Season.new(name: '', number: 1)
      expect(season.save).to be_truthy
    end

    it 'should not be saved without a season number' do
      season = Season.new(name: 'Season 1')
      expect(season.save).to be_falsey
    end 

  end

end
