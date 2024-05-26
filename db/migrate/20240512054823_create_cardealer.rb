class CreateCardealer < ActiveRecord::Migration[7.1]
  def change
    create_table :cardealers do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :sub_location
      t.references :district, null: false, foreign_key: true
      t.timestamps
    end
  end
end
