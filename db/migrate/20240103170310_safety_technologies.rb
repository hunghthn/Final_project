
# db/migrate/20240103140600_create_safety_technologies.rb
class SafetyTechnologies < ActiveRecord::Migration[7.1]
  def change
    create_table :safety_technologies do |t|
      t.string :cruise_control
      t.string :adaptive_cruise_control
      t.string :forward_collision_warning
      t.string :airbags_count
      t.string :abs_brakes
      t.string :emergency_brake_assist
      t.string :electronic_stability_control
      t.string :traction_control
      t.string :hill_start_assist
      t.string :hill_descent_control
      t.string :blind_spot_warning
      t.string :rear_view_sensor
      t.string :rear_camera
      t.string :camera_360_degree
      t.string :blind_spot_camera
      t.string :lane_departure_warning
      t.string :lane_keeping_assist
      t.string :automatic_collision_prevention
      t.string :cross_traffic_alert
      t.string :driver_drowsiness_detection
      t.string :isofix_child_safety_seat_hooks
      t.string :tire_pressure_monitor
      t.string :front_collision_sensor
      t.timestamps
      t.references :trim, foreign_key: true
    end
  end
end
