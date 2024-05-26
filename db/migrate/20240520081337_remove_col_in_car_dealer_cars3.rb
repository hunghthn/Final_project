class RemoveColInCarDealerCars3 < ActiveRecord::Migration[7.1]
  def change
    remove_column :car_dealer_cars, :amount
    add_column :car_dealer_cars, :amount, :integer
    remove_column :car_dealer_cars, :cardealer_price
    add_column :car_dealer_cars, :cardealer_price, :string
  end
end
