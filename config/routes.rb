Rails.application.routes.draw do
  get 'home',     to: 'home#index'
  get 'pricing',  to: 'home#pricing'
  get 'about-us', to: 'home#about_us'
  get 'sitemap',  to: 'sitemap#index', constraints: { format: 'xml' }

  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unacceptable'
  get '/500', to: 'errors#internal_error'

  devise_for :users, path: 'account', controllers: {
    registrations: 'users/registrations', sessions: 'users/track_sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :contacts, only: %i[new create]

  namespace :account do
    root 'dashboard#index'
    resources :companies do
      resources :pages, except: %i[edit update] do
        patch :rate, on: :member
      end
      resources :videos, only: %i[index]
      get :download, on: :member
      collection do
        resource :chrome_extensions, only: %i[new create]
      end
    end
    resources :comments,      only: %i[create destroy]
    resources :tenants,       only: %i[show index]
    resource  :my_tenant,     only: %i[show edit update]
    resources :analytics,     only: %i[index]
    resources :contacts,      only: %i[index destroy]
    resources :notifications, only: [] do
      member do
        get 'read', to: 'notifications#read', as: :read
      end
      collection do
        get 'read_all', to: 'notifications#read_all', as: :read_all
      end
    end
    resource :profile, only: %i[show edit update], controller: 'profile' do
      resource :tokens, only: %i[create destroy]
    end
    resources :users do
      member do
        post :impersonate
      end
      collection do
        post :stop_impersonating
        get  :download
      end
    end
    get 'chart-for-users-by-week',     to: 'charts#registered_users'
    get 'chart-for-companies-by-week', to: 'charts#created_companies'
    get 'chart-for-users-by-month',    to: 'charts#registered_users_summary'
    get 'chart-for-users-logins',      to: 'charts#users_logins'
  end

  authenticated :user do
    root 'account/dashboard#index', as: :authenticated_root
  end

  root 'home#index'

  namespace :api, defaults: { format: :json } do
    as :user do
      resources :companies, only: :index
    end
  end
end
