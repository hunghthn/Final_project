# frozen_string_literal: true

Rails.application.routes.draw do
  get 'car/show', to: 'car#show', as: 'car_show'
  resources :car do
    get 'sort', on: :collection
  end
  resources :models, only: [:show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
