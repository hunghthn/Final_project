class AddColumnsToExteriors < ActiveRecord::Migration[7.1]
  def change
    add_column :exteriors, :headlight_high_beam, :string
    add_column :exteriors, :headlight_low_beam, :string
    add_column :exteriors, :daytime_running_lights, :string
    add_column :exteriors, :tail_lights, :string
    add_column :exteriors, :rearview_mirror, :string
    add_column :exteriors, :fog_lights, :string
    add_column :exteriors, :exhaust_pipe, :string
    add_column :exteriors, :other_features, :string
    add_column :exteriors, :auto_headlights, :string
    add_column :exteriors, :auto_headlight_range_control, :string
    add_column :exteriors, :auto_headlight_leveling, :string
    add_column :exteriors, :high_mounted_stop_light, :string
    add_column :exteriors, :heated_rearview_mirror, :string
    add_column :exteriors, :automatic_rain_sensing_wipers, :string
    add_column :exteriors, :shark_fin_antenna, :string
    add_column :exteriors, :power_operated_trunk, :string
    add_column :exteriors, :hands_free_trunk, :string
    add_column :exteriors, :two_tone_paint_option, :string
    add_column :exteriors, :anti_glare_side_mirrors, :string
    add_column :exteriors, :lower_side_mirror_when_reversing, :string
    add_column :exteriors, :hidden_door_handles, :string
    add_column :exteriors, :rear_wind_deflector, :string
    add_column :exteriors, :roof_rails, :string
    add_column :exteriors, :hood_air_intake, :string
    add_column :exteriors, :roof_rack, :string
  end
end
