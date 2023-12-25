# frozen_string_literal: true

class CreateTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :types do |t|
      t.string :type_name
      t.string :type_image
      t.text :type_desc

      t.timestamps
    end
  end
end
