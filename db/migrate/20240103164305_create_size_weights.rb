# db/migrate/20240103140100_create_size_weights.rb
class CreateSizeWeights < ActiveRecord::Migration[7.1]
  def change
    create_table :size_weights do |t|
      t.string :seating_capacity
      t.string :dimensions
      t.string :wheelbase
      t.string :ground_clearance
      t.string :cargo_volume
      t.string :fuel_tank_capacity
      t.string :curb_weight
      t.string :tire_wheel
      t.references :trim, foreign_key: true
      t.timestamps
    end
  end
end
