# db/migrate/20240103140500_create_driving_assistances.rb
class CreateDrivingAssistances < ActiveRecord::Migration[7.1]
  def change
    create_table :driving_assistances do |t|
      t.string :power_steering
      t.string :multiple_driving_modes
      t.string :steering_wheel_paddle_shifters
      t.string :cornering_assist
      t.string :acceleration_control
      t.string :electronic_parking_brake
      t.string :auto_hold
      t.string :rear_wheel_steering
      t.string :active_park_assist
      t.references :trim, foreign_key: true
      t.timestamps
    end
  end
end
