Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  namespace :account do
    resources :companies
    resources :pages, only: %i[show index]
    resources :tenants
  end
end
