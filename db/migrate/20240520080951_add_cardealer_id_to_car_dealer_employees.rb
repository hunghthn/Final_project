class AddCardealerIdToCarDealerEmployees < ActiveRecord::Migration[7.1]
  def change
    add_reference :car_dealer_cars, :cardealer, null: false, foreign_key: true
  end
end
