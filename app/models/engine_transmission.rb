# app/models/engine_transmission.rb
class EngineTransmission < ApplicationRecord
  belongs_to :trim
  def convert_engine_capacity_to_float
    return nil if engine_capacity.nil?
    engine_capacity.gsub(',', '.').to_f
  end

  def convert_fuel_consumption_to_float
    return nil if fuel_consumption.nil?
    fuel_consumption.gsub(',', '.').to_f
  end

  def convert_power_to_float
    return nil if power.nil?

    matches = power.scan(/\d+/)

    power_value = matches[0].to_i if matches.present?

    power_value
  end


  def convert_torque_to_float
    return nil if torque.nil?

    matches = torque.scan(/\d+/)

    torque_value = matches[0].to_i if matches.present?

    torque_value
  end
end
