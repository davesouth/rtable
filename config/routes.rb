Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Set subdomain admin route in credentials
  constraints subdomain: Rails.application.credentials.admin_slug do
    get '/', to: redirect('/domains')
    resources :domains do
      get 'delete', on: :member
    end
  end

  # Root path redirects to tickets, for now
  root 'dashboard#index'

  # Main resources
  resources :categories
  resources :cards

  # Ticket resources (in depth)
  resources :tickets do
    # Ticket feeds
    resources :notes, controller: 'memos', kind: 'note'
  end


  # Authentication helper paths
  get '/login', to: 'sessions#new', as: 'new_session'
  post '/login', to: 'sessions#create', as: 'create_session'
  get '/auth/:user_id/:token', to: 'sessions#auth', as: 'auth_session'
  delete '/logout', to: 'sessions#destroy', as: 'destroy_session'

end
