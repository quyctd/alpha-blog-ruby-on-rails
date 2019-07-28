# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'articles#index', page: 'home'
  get 'about', to: 'pages#about'

  resources :articles

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resources :users, expect: [:new]

  resources :categories, except: [:destroy] do
    get 'serve', on: :member
  end

end
