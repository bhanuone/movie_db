class Series < ApplicationRecord

  after_commit :update_remaining_data, on: :create

  validates_presence_of :tvdb_id

  has_many :favorites
  has_many :users, through: :favorites
  has_many :episodes


  def update_from_api_data(data)
    self.update({
      name: data['seriesName'],
      status: data['status'],
      overview: data['overview'],
      tvdb_id: data['id'],
      network: data['network'],
      first_aired: data['firstAired'],
      genre: data['genre']
    })
  end

  def has_new_episode?(updated_episodes_count)
    self.episodes.count < updated_episodes_count
  end

  def self.parse_api_data(api_data)
    parsed_data = api_data
    Series.new(parsed_data)
  end


  private

  def update_remaining_data
    SeriesUpdateJob.perform_later(self.id)
  end

end
