class HomeController < ApplicationController

  def index
    @series = Series.all
  end

  def episodes
    api = Episodes.new
    @seasons, @series_data = api.call(params[:id]) 
  end

  def search
    if params[:q].present?
      api = Search.new
      results = api.call(params[:q]) 
      if results['data']
        @series = results['data'].map{|series_data| build_view_object(series_data)}
      else
        @series = []
      end
    else
      redirect_to request.referrer
    end
  end

  def genre
  end

  def build_view_object(series_data)
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
