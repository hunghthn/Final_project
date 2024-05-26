class RemoveColInCarDealerCars1 < ActiveRecord::Migration[7.1]
  def change
    remove_column :car_dealer_cars, :amount
    add_column :car_dealer_cars, :amount, :string
  end
end
