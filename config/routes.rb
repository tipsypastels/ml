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

    post '/herosearch', to: 'hero_search#search', as: :hero_search
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

  get '/activity', to: 'posts#index', as: :activity

  resources :topics

  resources :clubs
  get '/clubs/:id/new', to: 'club_topics#new', as: :new_club_topic
  post '/clubs/:id/new', to: 'club_topics#create', as: :create_club_topic

  get '/clubs/:id/members', to: 'club_memberships#show', as: :club_members
  get '/clubs/:id/join', to: 'club_memberships#new', as: :new_club_membership
  post '/clubs/:id/join', to: 'club_memberships#create', as: :create_club_membership

  delete '/clubs/:id/leave', to: 'club_memberships#destroy', as: :destroy_club_membership

  get '/clubs/:id/invites', to: 'invites#index', as: :invites
  
  get '/clubs/:id/invite', to: 'invites#new', as: :new_invite
  post '/clubs/:id/invite', to: 'invites#create', as: :create_invite

  get '/invites/:hex', to: 'invites#show', as: :invite

  delete '/invites/:hex', to: 'invites#destroy', as: :destroy_invite

  mount ActionCable.server => '/cable'
end
