Rails.application.routes.draw do
  namespace :api do
    post '/follow/:id', to: 'follows#create', as: :follow
    delete '/unfollow/:id', to: 'follows#destroy', as: :unfollow

    post '/updateprofile', to: 'profile_update#update', as: :profile_update
  end

  scope '/settings', as: :settings do
    get '/profile', to: 'user_settings#profile', as: :profile
    
    post '/save', to: 'user_settings#save', as: :save 
  end

  root to: 'topics#index'

  devise_for :users
  get '/@:id', to: 'users#show', as: :user

  resources :topics
end
