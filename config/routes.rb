# frozen_string_literal: true

Rails.application.routes.draw do

  root 'car#show'
  resources :users, only: [:new, :create, :show, :update,:edit]
  get 'car/show', to: 'car#show', as: 'car_show'
  get '/models_autocomplete', to: 'car#models_autocomplete'
  post '/car/add_to_compare', to: 'car#add_to_compare'
  post '/car/remove_from_compare', to: 'car#remove_from_compare'
  get 'reset_compare', to: 'car#reset_compare'
  get '/car/render_compared_models', to: 'car#render_compared_models'
  get '/sales', to: 'sales#index', as: 'sales_index'
  resources :models, only: [:show] do
    resources :reviews, only: [:create]
  end

  get '/car_compare/compare', to: 'car_compare#compare', as: 'car_compare_compare'
  get '/update_price', to: 'car_compare#update_price'
  get '/update_engine_type', to: 'car_compare#update_engine_type'
  get '/update_engine_capacity', to: 'car_compare#update_engine_capacity'
  get '/update_power', to: 'car_compare#update_power'
  get '/update_gearbox', to: 'car_compare#update_gearbox'
  get '/update_drive_system', to: 'car_compare#update_drive_system'
  get '/update_torque', to: 'car_compare#update_torque'
  get '/update_automatic_transmission', to: 'car_compare#update_automatic_transmission'
  get '/update_fuel_type', to: 'car_compare#update_fuel_type'
  get '/update_fuel_consumption', to: 'car_compare#update_fuel_consumption'

  get '/update_seating_capacity', to: 'car_compare#update_seating_capacity'
  get '/update_wheelbase', to: 'car_compare#update_wheelbase'
  get '/update_dimensions', to: 'car_compare#update_dimensions'
  get '/update_ground_clearance', to: 'car_compare#update_ground_clearance'
  get '/update_turning_radius', to: 'car_compare#update_turning_radius'
  get '/update_cargo_volume', to: 'car_compare#update_cargo_volume'
  get '/update_fuel_tank_capacity', to: 'car_compare#update_fuel_tank_capacity'
  get '/update_curb_weight', to: 'car_compare#update_curb_weight'
  get '/update_total_weight', to: 'car_compare#update_total_weight'
  get '/update_tire_wheel', to: 'car_compare#update_tire_wheel'
  get '/update_luggage_volume', to: 'car_compare#update_luggage_volume'
  get '/update_airbag_count', to: 'car_compare#update_airbag_count'

  # Add a generic route for updating attributes
  get '/update_attribute/:attribute_name', to: 'car_compare#update_attribute'
  # Add a generic route for updating exterior attributes
  get '/update_exterior_attribute/:attribute_name', to: 'car_compare#update_exterior_attribute'
  get '/update_interior_attribute/:attribute_name', to: 'car_compare#update_interior_attribute'
  get '/update_driving_assistance_attribute/:attribute_name', to: 'car_compare#update_driving_assistance_attribute'
  get '/update_safety_technology_attribute/:attribute_name', to: 'car_compare#update_safety_technology_attribute'
  get 'up' => 'rails/health#show', as: :rails_health_check

  get '/districts/:prefecture_id', to: 'districts#index'
  get '/brands/:brand_id', to: 'brands#index'
  resources :cardealers, only: [:index, :show] do
    collection do
      get 'find_by_district', to: 'cardealers#find_by_district'
      get 'find_by_location', to: 'cardealers#find_by_location'
    end
  end
  resources :inquiries, only: [:create] do
    collection do
      post 'send_otp'
    end
  end
  resources :car_dealer_employees, only: [:index, :update, :destroy, :create]
  resources :car_dealer_cars
  resources :cardealers, only: [:index, :show] do
    member do
      get :filtered_models
    end
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout

  namespace :admin do
    resources :cardealers do
      member do
        get 'staffs', to: 'cardealers#staffs_index'
        get 'models', to: 'cardealers#models_index'
        get 'inquiries_today'
        get 'inquiries_this_week'
        get 'inquiries_this_month'
        get 'inquiries_all'
        get 'filtered_models'
        get 'model_request'
        post 'create_model_request'
      end
    end
  end

  resources :users do
    member do
      get 'edit_password'
      patch 'update_password'
    end
  end

  resources :reviews, only: [:create, ]
  get 'password_resets/new', to: 'password_resets#new'
  post 'password_resets/create', to: 'password_resets#create'
end
