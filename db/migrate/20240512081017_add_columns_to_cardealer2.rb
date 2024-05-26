class AddColumnsToCardealer2 < ActiveRecord::Migration[7.1]
  def change
    add_column :cardealers, :detail, :string
  end
end
