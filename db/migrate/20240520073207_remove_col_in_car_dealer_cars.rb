class RemoveColInCarDealerCars < ActiveRecord::Migration[7.1]
  def change
    remove_column :car_dealer_cars, :gender, :string
  end
end
