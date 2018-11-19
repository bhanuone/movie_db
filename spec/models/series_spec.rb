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
      series_1 = Series.create(name: 'The Flash(2014)')
      series_2 = Series.new(name: 'The Flash(2014)')

      expect(series_2.save).to be_falsey
    end

  end

  describe :update_from_api_data do
    it 'should not create a new series'
    context 'when data is not up to date' do
      it 'should update data'
    end
    context 'when data is up to date' do
      it 'should not update' do
        @series = Series.create(name: 'test')

        old_updated_at = @series.updated_at
        expext(@series.update_from_api_data({name: 'test'}.updated_at).to eq(old_updated_at)
      end
    end
  end

  context 'When adding and removing favorites' do

    let(:user) {User.create(name: 'Bhanu', email: 'bhanu@gmail.com', password: 'password', password_confirmation: 'password')}
    let(:series) {Series.create(tvdb_id: 1232)}

    it 'As a user, I should be able to add favorites' do
      favorite = user.favorites.new(series_id: series.id)
      expect(favorite.save).to be_truthy
    end

    it 'As a user, I should be able to remove a favorite' do
      favorite = user.favorites.first
      favorites_count = user.favorites.count
      favorite.destroy
      expect(user.favorites.count).to eq(favorites_count - 1)
    end

  end
end
