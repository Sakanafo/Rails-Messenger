# frozen_string_literal: true

Rails.application.routes.draw do
  resources :messages, only: %i[index create destroy]

  root 'pages#index'
end
