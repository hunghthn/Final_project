# db/migrate/20240103140000_create_engine_transmissions.rb
class CreateEngineTransmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :engine_transmissions do |t|
      t.string :engine_type
      t.string :engine_capacity
      t.string :power_torque
      t.string :gearbox
      t.string :drive_system
      t.string :fuel_type
      t.string :fuel_consumption
      t.string :electronic_gear
      t.references :trim, foreign_key: true
      t.timestamps
    end
  end
end
