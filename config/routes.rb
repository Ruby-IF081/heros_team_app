Rails.application.routes.draw do
  devise_for :users, path: 'account', controllers: {
    registrations: 'users/registrations'
  }

  namespace :account do
    resources :pages, only: %i[show index]
  end
end
