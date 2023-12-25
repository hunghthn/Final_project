class AddModelNameToModels < ActiveRecord::Migration[7.1]
  def change
    add_column :models, :model_name_main, :string
  end
end
