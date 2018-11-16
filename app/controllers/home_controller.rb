class HomeController < ApplicationController
  
  before_action :authenticate_user!, only: [:add_favorite, :remove_favorite]

  def index
    if current_user
      @series = Series.joins(:favorites).where(favorites: {user_id: current_user.id})
    else
      @series = Series.all
    end
  end

  def episodes
    api = Episodes.new
    @seasons, @series_data = api.call(params[:id]) 
    if current_user
      @in_favorites = current_user.favorites.joins(:series).where(series: {tvdb_id: params[:id]}).first.present?
    end
  end

  def search
    if params[:q].present?
      api = Search.new
      results = api.call(params[:q]) 
      if results['data']
        @series = results['data'].map{|series_data| build_series_object(series_data)}
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

  def build_series_object(series_data)
    OpenStruct.new({
      name: series_data['seriesName'],
      status: series_data['status'],
      overview: series_data['overview'],
      tvdb_id: series_data['id'],
      network: series_data['network'],
      first_aired: series_data['firstAired']
      })
  end

end
