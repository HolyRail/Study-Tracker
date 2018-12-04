Rails.application.routes.draw do
  resources :events
  get 'calendar/index'
  get 'setup/index'
  root 'dashboard#index'
  get 'calendar/index', to: 'calendar#index'
  get 'dashboard/index'
  get '/signin',   to: 'sessions#new'
  post '/signin',   to: 'sessions#create'
  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  post 'setup/create', to: 'setup#create'
end
