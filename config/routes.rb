Rails.application.routes.draw do

  namespace :warden do
    resources :domains
    root to: redirect('/warden/domains')
  end

  scope path: ':domain_id', as: 'domain' do
    resources :categories
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
