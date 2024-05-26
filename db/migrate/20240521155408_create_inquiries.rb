class CreateInquiries < ActiveRecord::Migration[7.1]
  def change
    create_table :inquiries do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :note
      t.integer :preferred_contact
      t.references :model, null: false, foreign_key: true
      t.references :cardealer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
