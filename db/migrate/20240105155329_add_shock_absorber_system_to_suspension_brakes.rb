class AddShockAbsorberSystemToSuspensionBrakes < ActiveRecord::Migration[7.1]
  def change
    add_column :suspension_brakes, :shock_absorber_system, :string
  end
end
