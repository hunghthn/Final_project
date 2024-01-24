class AddColumnsToDrivingAssistances < ActiveRecord::Migration[7.1]
  def change
    add_column :driving_assistances, :speed_limit_display, :string
    add_column :driving_assistances, :vehicle_management_via_phone_app, :string
    add_column :driving_assistances, :off_road_mode, :string
    add_column :driving_assistances, :traffic_sign_recognition, :string
    add_column :driving_assistances, :terrain_mode, :string
    add_column :driving_assistances, :automatic_rev_match_system, :string
    add_column :driving_assistances, :electronic_throttle_control_dbw, :string
    add_column :driving_assistances, :electric_locking_differential, :string
    add_column :driving_assistances, :rear_differential_lock, :string
    add_column :driving_assistances, :automatic_rearview_assist_ara, :string
    add_column :driving_assistances, :cruise_control, :string
    add_column :driving_assistances, :adaptive_cruise_control, :string
    add_column :driving_assistances, :electric_brake_force_distribution, :string
    add_column :driving_assistances, :forward_collision_warning, :string
    add_column :driving_assistances, :remote_start, :string
  end
end
