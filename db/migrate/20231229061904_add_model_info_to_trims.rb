class AddModelInfoToTrims < ActiveRecord::Migration[7.1]
  def change
    add_column :trims, :model_brand, :string
    add_column :trims, :model_title_name, :string
  end
end
