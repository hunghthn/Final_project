class AddRefToCardealercar2 < ActiveRecord::Migration[7.1]
  def change
    remove_column :car_dealer_cars, :car_dealer_car_id
  end
end
