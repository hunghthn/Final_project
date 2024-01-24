# frozen_string_literal: true

Rails.application.routes.draw do
  get 'car/show', to: 'car#show', as: 'car_show'
  get '/models_autocomplete', to: 'car#models_autocomplete'
  post '/car/add_to_compare', to: 'car#add_to_compare'
  post '/car/remove_from_compare', to: 'car#remove_from_compare'
  get 'reset_compare', to: 'car#reset_compare'
  get '/car/render_compared_models', to: 'car#render_compared_models'
  get '/sales', to: 'sales#index', as: 'sales_index'
  resources :models, only: [:show]

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

  # Add a generic route for updating attributes
  get '/update_attribute/:attribute_name', to: 'car_compare#update_attribute'
  # Add a generic route for updating exterior attributes
  get '/update_exterior_attribute/:attribute_name', to: 'car_compare#update_exterior_attribute'
  get '/update_interior_attribute/:attribute_name', to: 'car_compare#update_interior_attribute'
  get '/update_driving_assistance_attribute/:attribute_name', to: 'car_compare#update_driving_assistance_attribute'
  get '/update_safety_technology_attribute/:attribute_name', to: 'car_compare#update_safety_technology_attribute'
  get 'up' => 'rails/health#show', as: :rails_health_check

end
