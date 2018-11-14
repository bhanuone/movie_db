require 'rails_helper'

RSpec.describe Genre, type: :model do
  
  context 'When creating a new Genre' do

    it 'should not be saved if name is not present' do
      genre = Genre.new(name: '')
      expect(genre.save).to be_falsey
    end

    it 'should not be saved with a duplicate name' do
      genre_1 = Genre.create(name: 'Action')
      genre_2 = Genre.new(name: 'Action')
      expect(genre_2.save).to be_falsey
    end
  end

end
