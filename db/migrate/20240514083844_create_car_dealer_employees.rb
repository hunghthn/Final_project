class CreateCarDealerEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :car_dealer_employees do |t|
      t.references :cardealer, null: false, foreign_key: true
      t.string :name
      t.integer :role
      t.integer :gender
      t.string :image
      t.timestamps
    end
  end
end
