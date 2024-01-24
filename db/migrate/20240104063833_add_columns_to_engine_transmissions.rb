class AddColumnsToEngineTransmissions < ActiveRecord::Migration[7.1]
  def change
    add_column :engine_transmissions, :operating_range_km, :string
    add_column :engine_transmissions, :fast_dc_charging_10_80_minutes, :string
    add_column :engine_transmissions, :battery_type, :string
    add_column :engine_transmissions, :electronic_gearbox, :string
    add_column :engine_transmissions, :battery_capacity_kwh, :string
    add_column :engine_transmissions, :standard_ac_charging_time, :string
    add_column :engine_transmissions, :electric_motor_power, :string
    add_column :engine_transmissions, :electric_motor_torque, :string
    add_column :engine_transmissions, :max_speed_kmh, :string
    add_column :engine_transmissions, :acceleration_0_100_seconds, :string
    add_column :engine_transmissions, :standard_charger_onboard, :string
    add_column :engine_transmissions, :driving_modes, :string
    add_column :engine_transmissions, :battery_capacity, :string
    add_column :engine_transmissions, :fast_charging_time, :string
    add_column :engine_transmissions, :regenerative_braking_system, :string
    add_column :engine_transmissions, :fast_charging_10_70_minutes, :string
    add_column :engine_transmissions, :fast_charging_30_80_minutes, :string
  end
end
