# db/migrate/20231225000000_create_trims.rb
class CreateTrims < ActiveRecord::Migration[7.1]
  def change
    create_table :trims do |t|
      t.references :model, null: false, foreign_key: true
      t.string :name
      t.string :listed_price
      t.string :hn_price
      t.string :tphcm_price
      t.string :other_price

      t.timestamps
    end
  end
end
