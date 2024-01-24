class RemoveColumnsFromSafetyTechnologies < ActiveRecord::Migration[7.1]
  def change
    remove_column :safety_technologies, :cruise_control
    remove_column :safety_technologies, :adaptive_cruise_control
    remove_column :safety_technologies, :forward_collision_warning
    remove_column :safety_technologies, :airbags_count
    remove_column :safety_technologies, :abs_brakes
    remove_column :safety_technologies, :emergency_brake_assist
    remove_column :safety_technologies, :electronic_stability_control
    remove_column :safety_technologies, :traction_control
    remove_column :safety_technologies, :hill_start_assist
    remove_column :safety_technologies, :hill_descent_control
    remove_column :safety_technologies, :blind_spot_warning
    remove_column :safety_technologies, :rear_view_sensor
    remove_column :safety_technologies, :rear_camera
    remove_column :safety_technologies, :camera_360_degree
    remove_column :safety_technologies, :blind_spot_camera
    remove_column :safety_technologies, :lane_departure_warning
    remove_column :safety_technologies, :lane_keeping_assist
    remove_column :safety_technologies, :automatic_collision_prevention
    remove_column :safety_technologies, :cross_traffic_alert
    remove_column :safety_technologies, :driver_drowsiness_detection
    remove_column :safety_technologies, :isofix_child_safety_seat_hooks
    remove_column :safety_technologies, :tire_pressure_monitor
    remove_column :safety_technologies, :front_collision_sensor
  end
end
