class RemoveColInCarDealerCars4 < ActiveRecord::Migration[7.1]
  def change
    remove_column :inquiries, :car_dealer_cars_id
  end
end
