Rails.application.routes.draw do
  get 'pricing', to: 'home#pricing'
  get 'about-us', to: 'home#about_us'
  get 'contacts', to: 'home#contacts'

  devise_for :users, path: 'account', controllers: {
    registrations: 'users/registrations'
  }

  namespace :account do
    root 'dashboard#index'
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

  authenticated :user do
    root 'account/companies#index', as: :authenticated_root
  end

  root 'home#index'
end
