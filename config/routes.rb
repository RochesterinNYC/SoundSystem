SoundSystem::Application.routes.draw do
  get '/login', :to => 'sessions#new', as: :login
  get '/logout', :to => 'sessions#destroy', as: :logout
  get '/auth', :to => 'sessions#auth', as: :auth
  get '/auth/callback', :to => 'sessions#create'

  get '/dashboard', :to => 'playlists#index', as: :dashboard
  get '/shuffle/:id', :to => 'playlists#shuffle', as: :shuffle
  root to: 'playlists#index'
end
