class NewEpisodesJob < ActiveJob::Base
  queue_as :default

  def perform
    notification_data = {}
    api = Episodes.new
    Series.joins(:favorites).where(status: 'Continuing').find_each do |series|
      updated_seasons, updated_series_data = api.call(series.tvdb_id)
      updated_episodes_count = 0
      updated_seasons.each {|season_number, episodes| updated_episodes_count += episodes.count }
      if series.has_new_episode?(updated_episodes_count)
        new_episode = updated_seasons[-1][1][-1]
        season = Season.find_or_create_by(number: updated_seasons[-1][0])
        Episode.create({
          title: new_episode['episodeName'],
          air_date: new_episode['firstAired'],
          series_id: series.id,
          season_id: season.id,
          episode_number: new_episode['airedEpisodeNumber']
        })
        series.users.each do |user|
          if notification_data.key?(user.id)
            notification_data[user.id] << series.id
          else
            notification_data[user.id] = [series.id]
          end
        end
      end
      if updated_series_data['status'] != series.status
        series.update(status: updated_series_data['status'])
      end
    end
    puts notification_data
    notification_data.each do |user_id, series_ids|
      NotifierJob.perform_later(user_id, series_ids)
    end
  end

end