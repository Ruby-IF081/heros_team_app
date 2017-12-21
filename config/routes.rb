Rails.application.routes.draw do
  devise_for :users

  namespace :account do
    resources :companies
    resources :pages
  end
end
