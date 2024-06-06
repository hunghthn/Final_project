class CreateModelRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :model_requests do |t|
      t.string :brand_name
      t.string :model_name
      t.integer :model_year
      t.references :cardealer, null: false, foreign_key: true
      t.timestamps
    end
  end
end
