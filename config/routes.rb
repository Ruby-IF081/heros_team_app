Rails.application.routes.draw do
  devise_for :users

  namespace :account do
    resources :pages
  end
end
