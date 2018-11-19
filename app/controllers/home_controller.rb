class HomeController < ApplicationController
  
  before_action :authenticate_user!, only: [:add_favorite, :remove_favorite]

  def index
    if current_user
      @series = current_user.series
    else
      @series = Series.all
    end
  end

  def episodes
    @series = Series.find_by(tvdb_id: params[:id])
    if @series.nil?
      api = Episodes.new
      seasons, series_data = api.call(params[:id])
      @series = Series.new(name: series_data['seriesName'], overview: series_data['overview'], genre: series_data['genre'], tvdb_id: series_data['id'])
      @seasons = seasons.map do |season, episodes|
        [
          season,
          episodes.map {|episode| Episode.new({
            episode_number: episode['airedEpisodeNumber'],
            title: episode['episodeName'],
            overview: episode['overview']
          })}
        ]
      end
    else
      @seasons = @series.episodes.eager_load(:season).group_by {|ep| ep.season.number}.sort 
    end
    if current_user
      @in_favorites = current_user.series.exists?(tvdb_id: params[:id])
    end
  end

  def search
    if params[:q].present?
      api = Search.new
      results = api.call(params[:q]) 
      if results['data']
        @series = results['data'].map{|series_data| Series.new({
                                                                  name: series_data['seriesName'],
                                                                  status: series_data['status'],
                                                                  overview: series_data['overview'],
                                                                  tvdb_id: series_data['id'],
                                                                  network: series_data['network'],
                                                                  first_aired: series_data['firstAired']
                                                                  })}
      else
        @series = []
      end
    else
      redirect_to request.referrer
    end
  end

  def add_favorite
    series = Series.find_or_create_by(tvdb_id: params[:tvdb_id])  
    added_favorite = current_user.favorites.find_or_create_by(series_id: series.id)
    render json: {}
  end

  def remove_favorite
    series = Series.find_or_create_by(tvdb_id: params[:tvdb_id])  
    favorite = current_user.favorites.find_by(series_id: series.id)
    favorite.destroy
    render json: {}
  end

end
