Rails.application.routes.draw do

  namespace :warden do
    resources :accounts
    root to: redirect('/warden/accounts')
  end

  scope path: ':account_id', as: 'account' do
    resources :categories
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
