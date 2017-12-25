Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, path: 'account', controllers: {
    registrations: 'users/registrations'
  }

  namespace :account do
    resources :companies
    resources :pages, only: %i[show index]
    resources :tenants
  end
end
