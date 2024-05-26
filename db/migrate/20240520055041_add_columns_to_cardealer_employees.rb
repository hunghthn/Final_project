class AddColumnsToCardealerEmployees < ActiveRecord::Migration[7.1]
  def change
    add_column :car_dealer_employees, :detail, :string
    add_column :car_dealer_employees, :picture, :string
  end
end
