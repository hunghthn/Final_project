class RemoveColumnsFromEngineTransmissions < ActiveRecord::Migration[7.1]
  def change
    remove_column :engine_transmissions, :electronic_gear
    remove_column :engine_transmissions, :electronic_gearbox
    remove_column :engine_transmissions, :power_torque
  end
end
