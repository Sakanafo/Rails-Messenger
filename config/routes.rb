# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  namespace :api do
    namespace :v1 do
      # devise_scope :user do
      #   post 'login', to: 'sessions#create'
      #   delete 'logout', to: 'sessions#destroy'
      # end
      devise_for :users,
                 path: '',
                 path_names: {
                   sign_in: 'login',
                   sign_out: 'logout'
                 }
    end
  end

  resources :messages, only: %i[index create destroy]
  resources :rooms, only: %i[new create index show]

  root 'pages#index'
  mount BaseApi => '/'
end
