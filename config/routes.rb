# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  
  root "home#index"

  resources :merchants, only: [:index, :edit, :update, :destroy]

  namespace :api do
    scope module: 'devise', path: '' do
      devise_scope :user do
        post 'sign_in', to: 'sessions#create'
        delete 'sign_out', to: 'sessions#destroy'
      end
    end
    resources :transactions, only: [:index, :create, :update]
  end
end
