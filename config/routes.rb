# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :messages, only: %i[index create destroy]
  resources :rooms, only: %i[new create index show]

  root 'pages#index'
end
