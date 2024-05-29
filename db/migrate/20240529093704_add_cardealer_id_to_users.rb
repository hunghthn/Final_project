class AddCardealerIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :cardealer, null: true, foreign_key: true
  end
end
