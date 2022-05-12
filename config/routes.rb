Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Set subdomain admin route in credentials
  constraints subdomain: Rails.application.credentials.admin_slug do
    get '/', to: redirect('/domains')
    resources :domains do
      get 'delete', on: :member
    end
  end

  # Main resources
  resources :categories
  resources :cards
  resources :tickets

  # Root path redirects to tickets, for now
  root to: redirect('/tickets')

end
