Rails.application.routes.draw do
  devise_for :users, path: 'account', controllers: { registrations: 'users/registrations' }

  namespace :account do
    resources :pages
  end
end
