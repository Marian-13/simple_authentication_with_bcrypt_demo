Rails.application.routes.draw do
  get  '/sign_up', to: 'users#new'
  post '/sign_up', to: 'users#create'

  get  '/log_in', to: 'sessions#new'
  post '/log_in', to: 'sessions#create'

  get '/log_out', to: 'sessions#destroy'

  get  '/', to: 'home#index'
  post '/', to: 'home#create'

  root 'home#index'
end
