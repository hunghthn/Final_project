class RemoveColumnsFromExteriors2 < ActiveRecord::Migration[7.1]
  def change
    remove_column :exteriors, :roof_rails
    remove_column :exteriors, :sunroof
  end
end
