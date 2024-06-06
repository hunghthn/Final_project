class RenameModelNameInModelRequests < ActiveRecord::Migration[7.1]
  def change
    rename_column :model_requests, :model_name, :car_model_name
  end
end
