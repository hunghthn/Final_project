class RenameForeignKeyInCarDealerCars < ActiveRecord::Migration[7.1]
  def change
    rename_column :car_dealer_cars, :trim_id, :model_id
  end
end
