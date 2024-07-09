class CarCompareController < ApplicationController
    def compare
      @compared_models = (session[:compared_models] || []).map { |model_id| Model.find_by(id: model_id) }
    end

    def update_price
      model_id = params[:model_id]
      selected_trim_name = params[:selected_trim_name]
      trim = Trim.find_by(model_id: model_id, name: selected_trim_name)
      new_value = trim.listed_price
      hp_value = trim.extract_price
      render json: { new_value: new_value, hp_value: hp_value}
    end

    def update_engine_type
      model_id = params[:model_id]
      selected_trim_name = params[:selected_trim_name]
      trim = Trim.find_by(model_id: model_id, name: selected_trim_name)
      new_value = trim.engine_transmission.engine_type
      render json: { new_value: new_value }
    end

    def update_engine_capacity
      model_id = params[:model_id]
      selected_trim_name = params[:selected_trim_name]
      trim = Trim.find_by(model_id: model_id, name: selected_trim_name)
      new_value = trim.engine_transmission.convert_engine_capacity_to_float
      render json: { new_value: new_value}
    end

    def update_power
      model_id = params[:model_id]
      selected_trim_name = params[:selected_trim_name]
      trim = Trim.find_by(model_id: model_id, name: selected_trim_name)
      new_value = trim.engine_transmission.power
      hp_value = trim.engine_transmission.convert_power_to_float
      render json: { new_value: new_value, hp_value: hp_value}
    end

    def update_torque
      model_id = params[:model_id]
      selected_trim_name = params[:selected_trim_name]
      trim = Trim.find_by(model_id: model_id, name: selected_trim_name)
      new_value = trim.engine_transmission.torque
      hp_value = trim.engine_transmission.convert_torque_to_float
      render json: { new_value: new_value, hp_value: hp_value}
    end

    def update_gearbox
      model_id = params[:model_id]
      selected_trim_name = params[:selected_trim_name]
      trim = Trim.find_by(model_id: model_id, name: selected_trim_name)
      new_value = trim.engine_transmission.gearbox
      render json: { new_value: new_value}
    end

    def update_drive_system
      model_id = params[:model_id]
      selected_trim_name = params[:selected_trim_name]
      trim = Trim.find_by(model_id: model_id, name: selected_trim_name)
      new_value = trim.engine_transmission.drive_system
      render json: { new_value: new_value}
    end

    def update_automatic_transmission
      model_id = params[:model_id]
      selected_trim_name = params[:selected_trim_name]
      trim = Trim.find_by(model_id: model_id, name: selected_trim_name)
      new_value = trim.engine_transmission.automatic_transmission
      new_value = "Không" if  new_value.nil?
      render json: { new_value: new_value}
    end

    def update_fuel_consumption
      model_id = params[:model_id]
      selected_trim_name = params[:selected_trim_name]
      trim = Trim.find_by(model_id: model_id, name: selected_trim_name)
      new_value = trim.engine_transmission.convert_fuel_consumption_to_float
      render json: { new_value: new_value}
    end


    def update_seating_capacity
      model_id = params[:model_id]
      selected_trim_name = params[:selected_trim_name]
      trim = Trim.find_by(model_id: model_id, name: selected_trim_name)
      new_value = trim.size_weight.seating_capacity
      render json: { new_value: new_value }
    end

    def update_wheelbase
      model_id = params[:model_id]
      selected_trim_name = params[:selected_trim_name]
      trim = Trim.find_by(model_id: model_id, name: selected_trim_name)
      new_value = trim.size_weight.convert_wheelbase_to_float
      render json: { new_value: new_value }
    end
  
    def update_dimensions
      model_id = params[:model_id]
      selected_trim_name = params[:selected_trim_name]
      trim = Trim.find_by(model_id: model_id, name: selected_trim_name)
      new_value = trim.size_weight.dimensions
      render json: { new_value: new_value }
    end
  
    def update_ground_clearance
      model_id = params[:model_id]
      selected_trim_name = params[:selected_trim_name]
      trim = Trim.find_by(model_id: model_id, name: selected_trim_name)
      new_value = trim.size_weight.convert_ground_clearance_to_float
      render json: { new_value: new_value }
    end


  def update_turning_radius
    model_id = params[:model_id]
    selected_trim_name = params[:selected_trim_name]
    trim = Trim.find_by(model_id: model_id, name: selected_trim_name)

    if trim && trim.size_weight
      new_value = trim.size_weight.turning_radius
      render json: { new_value: new_value }
    else
      render json: { new_value: nil }
    end
  end

  def update_cargo_volume
    model_id = params[:model_id]
    selected_trim_name = params[:selected_trim_name]
    trim = Trim.find_by(model_id: model_id, name: selected_trim_name)

    if trim && trim.size_weight
      new_value = trim.size_weight.cargo_volume
      render json: { new_value: new_value }
    else
      render json: { new_value: nil }
    end
  end

  def update_fuel_tank_capacity
    model_id = params[:model_id]
    selected_trim_name = params[:selected_trim_name]
    trim = Trim.find_by(model_id: model_id, name: selected_trim_name)

    if trim && trim.size_weight
      new_value = trim.size_weight.fuel_tank_capacity
      render json: { new_value: new_value }
    else
      render json: { new_value: nil }
    end
  end

  def update_curb_weight
    model_id = params[:model_id]
    selected_trim_name = params[:selected_trim_name]
    trim = Trim.find_by(model_id: model_id, name: selected_trim_name)

    if trim && trim.size_weight
      new_value = trim.size_weight.convert_curb_weight_to_float
      render json: { new_value: new_value}
    else
      render json: { new_value: nil }
    end
  end

  def update_total_weight
    model_id = params[:model_id]
    selected_trim_name = params[:selected_trim_name]
    trim = Trim.find_by(model_id: model_id, name: selected_trim_name)

    if trim && trim.size_weight
      new_value = trim.size_weight.convert_total_weight_to_float
      render json: { new_value: new_value}
    else
      render json: { new_value: nil }
    end
  end

  def update_tire_wheel
    model_id = params[:model_id]
    selected_trim_name = params[:selected_trim_name]
    trim = Trim.find_by(model_id: model_id, name: selected_trim_name)

    if trim && trim.size_weight
      new_value = trim.size_weight.tire_wheel
      render json: { new_value: new_value }
    else
      render json: { new_value: nil }
    end
  end

  def update_luggage_volume
    model_id = params[:model_id]
    selected_trim_name = params[:selected_trim_name]
    trim = Trim.find_by(model_id: model_id, name: selected_trim_name)

    if trim && trim.size_weight
      new_value = trim.size_weight.convert_luggage_volume_to_float
      render json: { new_value: new_value}
    else
      render json: { new_value: nil }
    end

  end

  # Define a generic update method
  def update_attribute
    model_id = params[:model_id]
    selected_trim_name = params[:selected_trim_name]
    attribute_name = params[:attribute_name]

    trim = Trim.find_by(model_id: model_id, name: selected_trim_name)

    if trim && trim.suspension_brake
      new_value = trim.suspension_brake.public_send(attribute_name)
      render json: { new_value: new_value }
    else
      render json: { new_value: nil }
    end
  end

  # Define a generic update method for exterior attributes
  def update_exterior_attribute
    model_id = params[:model_id]
    selected_trim_name = params[:selected_trim_name]
    attribute_name = params[:attribute_name]

    trim = Trim.find_by(model_id: model_id, name: selected_trim_name)

    if trim && trim.exterior
      new_value = trim.exterior.public_send(attribute_name)
      render json: { new_value: new_value }
    else
      render json: { new_value: nil }
    end
  end

  def update_interior_attribute
    model_id = params[:model_id]
    selected_trim_name = params[:selected_trim_name]
    attribute_name = params[:attribute_name]

    trim = Trim.find_by(model_id: model_id, name: selected_trim_name)

    if trim && trim.interior
      new_value = trim.interior.public_send(attribute_name)
      render json: { new_value: new_value }
    else
      render json: { new_value: nil }
    end
  end

  def update_driving_assistance_attribute
    model_id = params[:model_id]
    selected_trim_name = params[:selected_trim_name]
    attribute_name = params[:attribute_name]

    trim = Trim.find_by(model_id: model_id, name: selected_trim_name)

    if trim && trim.driving_assistance
      new_value = trim.driving_assistance.public_send(attribute_name)
      render json: { new_value: new_value }
    else
      render json: { new_value: nil }
    end
  end
  
  def update_safety_technology_attribute
    model_id = params[:model_id]
    selected_trim_name = params[:selected_trim_name]
    attribute_name = params[:attribute_name]

    trim = Trim.find_by(model_id: model_id, name: selected_trim_name)

    if trim && trim.safety_technology
      new_value = trim.safety_technology.public_send(attribute_name)
      render json: { new_value: new_value }
    else
      render json: { new_value: nil }
    end
  end

  def update_airbag_count
    model_id = params[:model_id]
    selected_trim_name = params[:selected_trim_name]
    trim = Trim.find_by(model_id: model_id, name: selected_trim_name)
    new_value = trim.safety_technology.convert_airbag_count_to_float
    render json: { new_value: new_value }
  end

end
