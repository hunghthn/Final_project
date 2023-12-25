# frozen_string_literal: true

class CreateBrands < ActiveRecord::Migration[7.1]
  def change
    create_table :brands do |t|
      t.string :brand_name
      t.string :brand_logo
      t.text :brand_desc

      t.timestamps
    end
  end
end
