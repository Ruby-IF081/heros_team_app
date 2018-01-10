Rails.application.routes.draw do
  get 'home', to: 'home#index'
  get 'pricing', to: 'home#pricing'
  get 'about-us', to: 'home#about_us'
  get 'contacts', to: 'home#contacts'

  devise_for :users, path: 'account', controllers: {
    registrations: 'users/registrations'
  }

  namespace :account do
    root 'dashboard#index'
    resources :companies do
      resources :pages, only: %i[show index] do
        patch :rate, on: :member
      end
      get :download, on: :member
      collection do
        resource :chrome_extensions, only: %i[new create]
      end
    end
    resources :tenants, only: %i[show index]
    resource :my_tenant, only: %i[show edit update]
    resources :users do
      post :impersonate, on: :member
      post :stop_impersonating, on: :collection
    end
  end

  authenticated :user do
    root 'account/dashboard#index', as: :authenticated_root
  end

  root 'home#index'
end
