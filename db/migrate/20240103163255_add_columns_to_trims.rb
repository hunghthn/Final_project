class AddColumnsToTrims < ActiveRecord::Migration[7.1]
  def change
    add_column :trims, :trim_type, :string
    add_column :trims, :trim_source, :string
  end
end
