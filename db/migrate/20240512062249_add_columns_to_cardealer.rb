class AddColumnsToCardealer < ActiveRecord::Migration[7.1]
  def change
    add_column :cardealers, :website, :string
    add_column :cardealers, :work_time, :string
    add_column :cardealers, :work_day, :string
  end
end
