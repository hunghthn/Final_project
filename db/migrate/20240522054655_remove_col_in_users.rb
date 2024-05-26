class RemoveColInUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :integer
    add_column :users, :gender, :integer
  end
end
