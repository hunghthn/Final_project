class AddRefToCardealercar < ActiveRecord::Migration[7.1]
  def change
    add_reference :car_dealer_cars, :car_dealer_car, foreign_key: true
  end
end
