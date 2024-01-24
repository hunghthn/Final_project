class CreateSuspensionBrakes < ActiveRecord::Migration[7.1]
  def change
    create_table :suspension_brakes do |t|
      t.string :front_suspension
      t.string :rear_suspension
      t.string :front_brakes
      t.string :rear_brakes
      t.references :trim, foreign_key: true
      t.timestamps
    end
  end
end
