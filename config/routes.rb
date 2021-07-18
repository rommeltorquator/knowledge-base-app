Rails.application.routes.draw do
  get 'account/new'
  post 'account/create'

  get 'home/dashboard'

  devise_for :admins, controllers: { confirmations: 'confirmations' }
  devise_for :members, controllers: { confirmations: 'confirmations' }
  
  root 'home#index'
  resource :users

  resources :procedures do
    member do
      patch 'approve', to: "procedures#approve"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
