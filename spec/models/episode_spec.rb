require 'rails_helper'

RSpec.describe Episode, type: :model do

  context 'When creating a new episode' do
    before do
      @genre = Genre.create(name: 'Action')
      @series = Series.create(name: 'The Flash(2014)', genre_id: @genre.id) 
      @season = Season.create(name: 'Season 1', number: 1)
    end

    it 'should not be saved without a title' do
      episode = Episode.new(title: '', series_id: @series.id, season_id: @season.id, air_date: Date.today)
      expect(episode.save).to be_falsey
    end

    it 'should not be saved without an air-date' do
      episode = Episode.new(title: 'Flash Episode 1', series_id: @series.id, season_id: @season.id, air_date: nil)
      expect(episode.save).to be_falsey
    end

    it 'should be present in a season' do
      episode = Episode.new(title: '', series_id: @series.id, season_id: nil, air_date: Date.today)
      expect(episode.save).to be_falsey
    end

    it 'should belong to a series' do
      episode = Episode.new(title: '', series_id: nil, season_id: @season.id, air_date: Date.today)
      expect(episode.save).to be_falsey
    end
  end

end
