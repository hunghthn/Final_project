class AddColumnsToYourSizeWeights < ActiveRecord::Migration[7.1]
  def change
    add_column :size_weights, :turning_radius, :string
    add_column :size_weights, :total_weight, :string
    add_column :size_weights, :luggage_volume, :string
  end
end
