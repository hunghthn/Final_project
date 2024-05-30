class AddUserToInquiries < ActiveRecord::Migration[7.1]
  def change
    add_reference :inquiries, :user, null: true, foreign_key: true
  end
end
