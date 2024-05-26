class CreateCarDealerCar < ActiveRecord::Migration[7.1]
  def change
    create_table :car_dealer_cars do |t|
      t.references :trim, null: false, foreign_key: true
      t.integer :cardealer_price
      t.integer :amount
      t.string :gender
      t.timestamps
    end
  end
end
