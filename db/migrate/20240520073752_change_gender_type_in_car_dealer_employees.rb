class ChangeGenderTypeInCarDealerEmployees < ActiveRecord::Migration[7.1]
  def change
    remove_column :car_dealer_employees, :gender
    add_column :car_dealer_employees, :gender, :integer
  end
end
