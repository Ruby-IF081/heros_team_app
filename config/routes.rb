Rails.application.routes.draw do
  devise_for :users

  namespace :account do
    resources :pages, only: %i[show index]
  end
end
