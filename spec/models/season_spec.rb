require 'rails_helper'

RSpec.describe Season, type: :model do

  context 'When creating a new Season' do

    before do
      genre = Genre.create(name: 'Action')
      series = Series.create(name: 'The Flash(2014)', genre_id: genre.id) 
    end

    it 'should not be saved without a name' do
      season = Season.new(name: '', number: 1)
      expect(season.save).to be_falsey
    end

    it 'should not be saved without a season number' do
      season = Season.new(name: 'Season 1')
      expect(season.save).to be_falsey
    end 

  end

end
