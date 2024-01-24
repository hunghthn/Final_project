class RemoveColumnsFromExteriors < ActiveRecord::Migration[7.1]
  def change
    remove_column :exteriors, :high_beam_lights
    remove_column :exteriors, :low_beam_lights
    remove_column :exteriors, :daytime_running_lights
    remove_column :exteriors, :auto_headlights
    remove_column :exteriors, :auto_headlight_leveling
    remove_column :exteriors, :rear_lights
    remove_column :exteriors, :brake_lights
    remove_column :exteriors, :high_mounted_stop_light
    remove_column :exteriors, :mirrors
    remove_column :exteriors, :power_folding_mirrors
    remove_column :exteriors, :auto_dimming_side_mirrors
    remove_column :exteriors, :intermittent_wipers
    remove_column :exteriors, :rain_sensing_wipers
    remove_column :exteriors, :shark_fin_antenna
    remove_column :exteriors, :power_trunk_lid
    remove_column :exteriors, :hands_free_trunk_lid
  end
end
