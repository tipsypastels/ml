Rails.application.routes.draw do
  namespace :api do
    post '/follow/:id', to: 'follows#create', as: :follow
    delete '/unfollow/:id', to: 'follows#destroy', as: :unfollow

    post '/posts/new', to: 'posts#create', as: :new_post
    post '/posts/edit', to: 'posts#update', as: :edit_post
  end

  scope '/settings', as: :settings do
    get '/profile', to: 'user_settings#profile', as: :profile
    
    post '/save', to: 'user_settings#save', as: :save 
  end

  root to: 'topics#index'

  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'login',
    }
    
  get '/@:id', to: 'users#show', as: :user

  resources :topics

  mount ActionCable.server => '/cable'
end
