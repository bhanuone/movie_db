Rails.application.routes.draw do
  root to: 'home#index', via: :get
  get 'home/index'
  get 'home/search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
