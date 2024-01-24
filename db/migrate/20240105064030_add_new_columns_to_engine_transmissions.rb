class AddNewColumnsToEngineTransmissions < ActiveRecord::Migration[7.1]
  def change
    add_column :engine_transmissions, :power, :string
    add_column :engine_transmissions, :torque, :string
    add_column :engine_transmissions, :automatic_transmission, :string
  end
end
