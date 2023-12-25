class AddModelDescAndModelYearToModels < ActiveRecord::Migration[7.1]
  def change
    add_column :models, :model_desc, :text
    add_column :models, :model_year, :integer
  end
end
