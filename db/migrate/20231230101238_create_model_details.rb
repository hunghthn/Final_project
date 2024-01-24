class CreateModelDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :model_details do |t|
      t.references :model, null: false, foreign_key: true
      t.string :model_brand
      t.string :model_title_name
      t.text :model_description
      t.timestamps
    end
  end
end
