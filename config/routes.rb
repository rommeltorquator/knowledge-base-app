Rails.application.routes.draw do
  get 'news/index'
  post 'news/create'
  delete 'news/:id', to: 'news#destroy', as: 'delete_news'

  # resources :newsfeed
  
  get 'account/new'
  post 'account/create'

  get 'home/dashboard'

  devise_for :admins, controllers: { confirmations: 'confirmations', registrations: 'registrations' }
  devise_for :members, controllers: { confirmations: 'confirmations', registrations: 'registrations' }
  
  root 'home#index'
  resource :users

  resources :procedures do
    member do
      patch 'approve', to: "procedures#approve"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
