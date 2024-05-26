class RemoveImageFromCarDealerEmployees < ActiveRecord::Migration[7.1]
  def change
    remove_column :car_dealer_employees, :image, :string
  end
end
