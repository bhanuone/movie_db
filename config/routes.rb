Rails.application.routes.draw do
  root to: 'home#index', via: :get
  devise_for :users
  get 'home/index'
  get 'home/search'
  get 'home/episodes'
  post 'add_favorite/:tvdb_id', to: 'home#add_favorite', as: 'add_to_favorites'
  delete 'remove_favorite/:tvdb_id', to: 'home#remove_favorite', as: 'remove_from_favorites'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
