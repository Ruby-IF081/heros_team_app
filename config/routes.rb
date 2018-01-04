Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, path: 'account', controllers: {
    registrations: 'users/registrations'
  }

  namespace :account do
    root 'dashboard#index'
    resources :companies do
      resources :pages, only: %i[show index]
      get :download, on: :member
      get 'chrome_extension/new', to: 'chrome_extension#new', on: :collection
      post 'chrome_extension', to: 'chrome_extension#create', on: :collection
    end
    resources :tenants
    resources :users do
      post :impersonate, on: :member
      post :stop_impersonating, on: :collection
    end
  end
end
