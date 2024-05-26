class RemoveColInCarDealerCars5 < ActiveRecord::Migration[7.1]
  def change
    add_column :inquiries, :car_dealer_car_id, :bigint
    add_foreign_key :inquiries, :car_dealer_cars
  end
end
