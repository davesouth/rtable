Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  concern :documentable do
    resources :docs
  end

  # Root path redirects to tickets, for now
  root 'dashboard#index'

  # Owner resources
  resources :users

  # Main resources
  resources :categories
  resources :cards

  # Ticket resources (in depth)
  resources :tickets do
    post '/close', on: :member, to: 'tickets#close', as: 'close'
    post '/reopen', on: :member, to: 'tickets#reopen', as: 'reopen'

    # Ticket feed
    resources :notes, concerns: [:documentable], controller: 'memos', kind: 'note'
  end

  # Authentication helper paths
  get '/login', to: 'sessions#new', as: 'new_session'
  post '/login', to: 'sessions#create', as: 'create_session'
  get '/auth/:user_id/:token', to: 'sessions#auth', as: 'auth_session'
  delete '/logout', to: 'sessions#destroy', as: 'destroy_session'

end
