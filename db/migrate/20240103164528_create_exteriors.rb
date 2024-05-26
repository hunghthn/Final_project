# db/migrate/20240103140400_create_interiors.rb
class CreateExteriors < ActiveRecord::Migration[7.1]
  def change
    create_table :exteriors do |t|
      t.string :seat_material
      t.string :driver_seat_adjustment
      t.string :driver_seat_memory
      t.string :driver_seat_massage
      t.string :passenger_seat_adjustment
      t.string :passenger_seat_massage
      t.string :driver_seat_cooling
      t.string :passenger_seat_cooling
      t.string :driver_seat_heating
      t.string :passenger_seat_heating
      t.string :dashboard
      t.string :steering_wheel_controls
      t.string :steering_wheel_material
      t.string :smart_key
      t.string :push_button_start
      t.string :air_conditioning
      t.string :rear_seat_air_vents
      t.string :one_touch_windows
      t.string :sunroof
      t.string :panoramic_sunroof
      t.string :auto_dimming_rearview_mirror
      t.string :front_center_armrest
      t.string :rear_center_armrest
      t.string :entertainment_screen
      t.string :apple_carplay
      t.string :android_auto
      t.string :voice_command
      t.string :hands_free_calling
      t.string :audio_system
      t.string :wifi_connectivity
      t.string :aux_input
      t.string :usb_input
      t.string :bluetooth_connectivity
      t.string :am_fm_radio
      t.string :wireless_charging
      t.string :power_closing_doors
      t.string :air_filter
      t.string :steering_wheel_heating
      t.string :navigation_system
      t.string :air_quality_control
      t.string :gesture_control
      t.references :trim, foreign_key: true
      t.timestamps
    end
  end
end
