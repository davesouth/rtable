Rails.application.routes.draw do

  # Set subdomain admin route in credentials
  constraints subdomain: Rails.application.credentials.admin_slug do
    root to: redirect('/domains')
    resources :domains do
      get 'delete', on: :member
    end
  end

  resources :cards

  # scope path: ':account_id', as: 'account' do
  #   resources :categories
  #   resources :tickets
  # end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
