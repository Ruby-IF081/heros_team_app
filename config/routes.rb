Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, path: 'account', controllers: {
    registrations: 'users/registrations'
  }

  namespace :account do
    resources :companies do
      resources :pages, only: %i[show index]
      get :download, on: :member
    end
    resources :tenants
    resources :users do
      post :impersonate, on: :member
      post :stop_impersonating, on: :collection
    end
  end
end
