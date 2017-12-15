Rails.application.routes.draw do
  devise_for :users, path: 'account', controllers: { registrations: 'users/registrations' }
end
