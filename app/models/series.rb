class Series < ApplicationRecord

  after_commit :update_remaining_data, on: :create

  has_many :favorites


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




  private

  def update_remaining_data
    SeriesUpdateJob.perform_later(self.id)
  end

end
