require 'rails_helper'

RSpec.describe Series, type: :model do

  context 'When creating a new series' do

    # before { @genre = Genre.create(name: 'Action') }

    # it 'should not be saved without a genre' do
    #   series = Series.new(name: 'The Flash', genre_id: nil)
    #   expect(series.save).to be_falsey
    # end

    # it 'should not be saved without a name' do
    #   series = Series.new(name: '' )
    #   expect(series.save).to be_falsey
    # end

    it 'should not be saved without a tvdb id' do
      series = Series.new(tvdb_id: nil)
      expect(series.save).to be_falsey
    end

    it 'should not be saved with a duplicate name' do
      series_1 = Series.create(name: 'The Flash(2014)', genre_id: @genre.id)
      series_2 = Series.new(name: 'The Flash(2014)', genre_id: @genre.id)

      expect(series_2.save).to be_falsey
    end

  end

end
