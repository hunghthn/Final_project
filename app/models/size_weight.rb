# app/models/engine_transmission.rb
class SizeWeight < ApplicationRecord
  belongs_to :trim
  def convert_seating_capacity_to_float
    return nil if seating_capacity.nil?
    seating_capacity.gsub(',', '.').to_f
  end

  def convert_wheelbase_to_float
    return nil if wheelbase.nil?
    a = wheelbase.gsub(',', '.').to_f
    while a >= 10
      a /= 10
    end
    a
  end

  def convert_ground_clearance_to_float
    return nil if ground_clearance.nil?
    a = ground_clearance.gsub(',', '.').to_f
    while a >= 10
      a /= 10
    end
    a
  end

  def convert_fuel_tank_capacity_to_float
    return nil if fuel_tank_capacity.nil?
    fuel_tank_capacity.gsub(',', '.').to_f
  end

  def convert_curb_weight_to_float
    return nil if curb_weight.nil?
    a = curb_weight.gsub(',', '.').to_f
    if a > 10
      a = a /1000 
    end
    a
  end

  def convert_total_weight_to_float
    return nil if total_weight.nil?
    a = total_weight.gsub(',', '.').to_f
    if a > 10
      a = a /1000 
    end
    a
  end

  def convert_cargo_volume_to_float
    return nil if cargo_volume.nil?
    cargo_volume.gsub(',', '.').to_f
  end

  def convert_luggage_volume_to_float
    return nil if luggage_volume.nil?
    a = luggage_volume.gsub(',', '.').to_f
    a
  end

  def convert_turning_radius_to_float
    return nil if turning_radius.nil?
    turning_radius.gsub(',', '.').to_f
  end
end
