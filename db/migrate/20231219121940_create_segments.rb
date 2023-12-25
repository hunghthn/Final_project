# frozen_string_literal: true

class CreateSegments < ActiveRecord::Migration[7.1]
  def change
    create_table :segments do |t|
      t.string :segment_name
      t.text :segment_desc

      t.timestamps
    end
  end
end
