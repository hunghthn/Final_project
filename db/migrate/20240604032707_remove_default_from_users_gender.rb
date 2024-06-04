class RemoveDefaultFromUsersGender < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :gender, nil
  end
end
