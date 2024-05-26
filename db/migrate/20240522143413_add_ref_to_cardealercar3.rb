class AddRefToCardealercar3 < ActiveRecord::Migration[7.1]
  def change
    add_reference :inquiries, :car_dealer_cars, foreign_key: true
  end
end
