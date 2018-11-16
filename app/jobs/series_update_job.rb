class SeriesUpdateJob < ActiveJob::Base
  queue_as :default

  def perform(series_id)
    api = Episodes.new
    series = Series.find_by(id: series_id)
    episodes_data, series_data = api.call(series.tvdb_id)
    series.update_from_api_data(series_data)
    episodes_data.each do |season_number, episodes|
      season = Season.find_or_create_by(number: season_number)
      Episode.create(
        episodes.map {|episode| {
          title: episode['episodeName'],
          air_date: episode['firstAired'],
          series_id: series.id,
          season_id: season.id,
          episode_number: episode['airedEpisodeNumber']
        }}
      )
    end
  end
end