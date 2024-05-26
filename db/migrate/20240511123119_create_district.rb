class CreateDistrict < ActiveRecord::Migration[7.1]
  def change
    create_table :districts do |t|
      t.string :name
      t.references :prefecture, null: false, foreign_key: true

      t.timestamps
    end
  end
end
