class Episodes < Api
  
  attr_reader :fetch_episodes_only

  def initialize(only_episodes: false)
    @fetch_episodes_only = only_episodes   
  end 

  def call(series_id)
    series_data = (fetch_episodes_only ? nil : fetch_series_data(series_id))
    episodes = []
    episodes_data = fetch_episodes(series_id)
    episodes += episodes_data['data']
    while episodes_data['links']['next'].present?
      episodes_data = fetch_episodes(series_id, episodes_data['links']['next'])
      episodes += episodes_data['data']
    end
    seasons = episodes
              .group_by {|episode| episode['airedSeason']}
              .sort_by {|k, v| k}
    [seasons, series_data]
  end

  def fetch_single_episode(tvdb_episode_id)
    
  end

  private

  def fetch_series_data(series_id)
    self.class.get("#{BASE_URL}/series/#{series_id}", {
      headers: {'Authorization' => "Bearer #{token}", 'Accept' => 'application/json'}
    })['data']
  end

  def fetch_episodes(series_id, page_no = 1)
    episodes_data = self.class.get("#{BASE_URL}/series/#{series_id}/episodes", {
      query: {page: page_no},
      headers: {'Authorization' => "Bearer #{token}", 'Accept' => 'application/json'}
    })
  end
end