# frozen_string_literal: true

class CreateModels < ActiveRecord::Migration[7.1]
  def change
    create_table :models do |t|
      t.string :model_brand
      t.string :model_title_name
      t.string :model_price
      t.string :model_segment
      t.string :model_main_pic
      t.string :model_engine
      t.string :model_power
      t.string :model_torque
      t.string :model_gearbox
      t.string :model_drive_system
      t.integer :model_seat
      t.string :model_type
      t.string :model_source

      t.timestamps
    end
  end
end
