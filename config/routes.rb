Rails.application.routes.draw do
  constraints subdomain: 'admin' do
    root to: redirect('/domains')
    resources :domains
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
