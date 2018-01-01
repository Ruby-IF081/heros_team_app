Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, path: 'account', controllers: {
    registrations: 'users/registrations'
  }

  namespace :account do
    resources :companies do
      resources :pages, only: %i[show index]
    end
    resources :tenants
    resources :users
    resource :profile, only: %i[edit update], controller: 'profile'
  end
end
