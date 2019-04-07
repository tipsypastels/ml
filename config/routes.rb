Rails.application.routes.draw do
  namespace :api do
    post '/follow/:id', to: 'follows#create', as: :follow
    delete '/unfollow/:id', to: 'follows#destroy', as: :unfollow

    post '/posts/new', to: 'posts#create', as: :new_post
    post '/posts/edit', to: 'posts#update', as: :edit_post

    post '/locks/new', to: 'locks#create', as: :lock_topic
    delete '/locks', to: 'locks#destroy', as: :unlock_topic

    post '/nudge/new', to: 'nudge#create', as: :nudge_topic

    delete '/deletetopic/:id', to: 'topic_destroy#destroy', as: :destroy_topic
  end

  scope '/settings', as: :settings do
    get '/profile', to: 'user_settings#profile', as: :profile
    
    post '/save', to: 'user_settings#save', as: :save 
  end

  get '/about', to: 'about#index', as: :about
  get '/about/edit', to: 'about#edit', as: :edit_about
  post '/about/edit', to: 'about#update', as: :update_about

  root to: 'topics#index'

  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'login',
    }
    
  resources :users, only: :index
  get '/@:id', to: 'users#show', as: :user

  resources :topics

  mount ActionCable.server => '/cable'
end
