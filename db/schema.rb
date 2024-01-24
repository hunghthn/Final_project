# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_01_11_074649) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "brand_name"
    t.string "brand_logo"
    t.text "brand_desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "driving_assistances", force: :cascade do |t|
    t.string "power_steering"
    t.string "multiple_driving_modes"
    t.string "steering_wheel_paddle_shifters"
    t.string "cornering_assist"
    t.string "acceleration_control"
    t.string "electronic_parking_brake"
    t.string "auto_hold"
    t.string "rear_wheel_steering"
    t.string "active_park_assist"
    t.bigint "trim_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "speed_limit_display"
    t.string "vehicle_management_via_phone_app"
    t.string "off_road_mode"
    t.string "traffic_sign_recognition"
    t.string "terrain_mode"
    t.string "automatic_rev_match_system"
    t.string "electronic_throttle_control_dbw"
    t.string "electric_locking_differential"
    t.string "rear_differential_lock"
    t.string "automatic_rearview_assist_ara"
    t.string "cruise_control"
    t.string "adaptive_cruise_control"
    t.string "electric_brake_force_distribution"
    t.string "forward_collision_warning"
    t.string "remote_start"
    t.string "idling_stop"
    t.index ["trim_id"], name: "index_driving_assistances_on_trim_id"
  end

  create_table "engine_transmissions", force: :cascade do |t|
    t.string "engine_type"
    t.string "engine_capacity"
    t.string "gearbox"
    t.string "drive_system"
    t.string "fuel_type"
    t.string "fuel_consumption"
    t.bigint "trim_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "operating_range_km"
    t.string "fast_dc_charging_10_80_minutes"
    t.string "battery_type"
    t.string "battery_capacity_kwh"
    t.string "standard_ac_charging_time"
    t.string "electric_motor_power"
    t.string "electric_motor_torque"
    t.string "max_speed_kmh"
    t.string "acceleration_0_100_seconds"
    t.string "standard_charger_onboard"
    t.string "driving_modes"
    t.string "battery_capacity"
    t.string "fast_charging_time"
    t.string "regenerative_braking_system"
    t.string "fast_charging_10_70_minutes"
    t.string "fast_charging_30_80_minutes"
    t.string "power"
    t.string "torque"
    t.string "automatic_transmission"
    t.index ["trim_id"], name: "index_engine_transmissions_on_trim_id"
  end

  create_table "exteriors", force: :cascade do |t|
    t.bigint "trim_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "headlight_high_beam"
    t.string "headlight_low_beam"
    t.string "daytime_running_lights"
    t.string "tail_lights"
    t.string "rearview_mirror"
    t.string "fog_lights"
    t.string "exhaust_pipe"
    t.string "other_features"
    t.string "auto_headlights"
    t.string "auto_headlight_range_control"
    t.string "auto_headlight_leveling"
    t.string "high_mounted_stop_light"
    t.string "heated_rearview_mirror"
    t.string "automatic_rain_sensing_wipers"
    t.string "shark_fin_antenna"
    t.string "power_operated_trunk"
    t.string "hands_free_trunk"
    t.string "two_tone_paint_option"
    t.string "anti_glare_side_mirrors"
    t.string "lower_side_mirror_when_reversing"
    t.string "hidden_door_handles"
    t.string "rear_wind_deflector"
    t.string "hood_air_intake"
    t.string "roof_rack"
    t.index ["trim_id"], name: "index_exteriors_on_trim_id"
  end

  create_table "interiors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "seat_material"
    t.string "driver_seat_adjustment"
    t.string "memory_driver_seat_position"
    t.string "passenger_seat_adjustment"
    t.string "driver_dashboard"
    t.string "steering_wheel_material"
    t.string "second_row_seats"
    t.string "third_row_seats"
    t.string "air_conditioning"
    t.string "one_touch_windows"
    t.string "infotainment_screen"
    t.string "speaker_system"
    t.string "double_layer_glass"
    t.string "tinted_glass"
    t.string "rear_entertainment_screen"
    t.string "rear_passenger_screen"
    t.string "smartphone_integration"
    t.string "additional_features"
    t.string "steering_adjustment"
    t.string "interior_color"
    t.string "driver_seat_massage"
    t.string "passenger_seat_massage"
    t.string "driver_seat_cooling"
    t.string "passenger_seat_cooling"
    t.string "driver_steering_controls"
    t.string "smart_key"
    t.string "push_button_start"
    t.string "rear_seat_vents"
    t.string "sunroof"
    t.string "panoramic_sunroof"
    t.string "auto_dimming_rearview_mirror"
    t.string "front_armrest"
    t.string "rear_armrest"
    t.string "apple_carplay"
    t.string "android_auto"
    t.string "voice_command"
    t.string "hands_free_calling"
    t.string "wifi_hotspot"
    t.string "aux_connection"
    t.string "usb_connection"
    t.string "bluetooth_connection"
    t.string "am_fm_radio"
    t.string "wireless_charging"
    t.string "power_tailgate"
    t.string "remote_start"
    t.string "air_filter"
    t.string "steering_wheel_heating"
    t.string "navigation"
    t.string "air_quality_control"
    t.string "gesture_control"
    t.string "center_display"
    t.string "power_driver_seat_adjustment"
    t.string "power_passenger_seat_adjustment"
    t.string "wifi_connectivity"
    t.string "interior_ambient_lighting"
    t.string "apple_carplay_android_auto"
    t.string "interior_material"
    t.string "starry_ceiling"
    t.string "alcantara_ceiling"
    t.string "driver_cabin_and_passenger_compartment_partition_with_tv"
    t.string "independent_seats_with_leg_support"
    t.string "virtual_assistant"
    t.string "steering_memory"
    t.string "rear_seat_heating_cooling"
    t.string "front_seat_heating_cooling"
    t.string "rear_seats_heating"
    t.string "rear_sunshade"
    t.string "rear_door_sunshade"
    t.string "power_outlet_230V"
    t.bigint "trim_id", null: false
    t.index ["trim_id"], name: "index_interiors_on_trim_id"
  end

  create_table "model_details", force: :cascade do |t|
    t.bigint "model_id", null: false
    t.string "model_brand"
    t.string "model_title_name"
    t.text "model_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_model_details_on_model_id"
  end

  create_table "models", force: :cascade do |t|
    t.string "model_brand"
    t.string "model_title_name"
    t.string "model_price"
    t.string "model_segment"
    t.string "model_main_pic"
    t.string "model_engine"
    t.string "model_power"
    t.string "model_torque"
    t.string "model_gearbox"
    t.string "model_drive_system"
    t.integer "model_seat"
    t.string "model_type"
    t.string "model_source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "model_price_min"
    t.integer "model_price_max"
    t.bigint "brand_id"
    t.bigint "type_id"
    t.bigint "segment_id"
    t.text "model_desc"
    t.integer "model_year"
    t.string "model_name_main"
    t.index ["brand_id"], name: "index_models_on_brand_id"
    t.index ["segment_id"], name: "index_models_on_segment_id"
    t.index ["type_id"], name: "index_models_on_type_id"
  end

  create_table "safety_technologies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "trim_id"
    t.string "airbag_count", comment: "Số túi khí"
    t.string "rear_sensor", comment: "Cảm biến lùi"
    t.string "central_locking", comment: "Khóa cửa trung tâm"
    t.string "cruise_control", comment: "Kiểm soát hành trình (Cruise Control)"
    t.string "adaptive_cruise_control", comment: "Kiểm soát hành trình thích ứng (Adaptive Cruise Control)"
    t.string "abs_brakes", comment: "Chống bó cứng phanh (ABS)"
    t.string "emergency_brake_assist", comment: "Hỗ trợ lực phanh khẩn cấp (BA)"
    t.string "ebd", comment: "Phân phối lực phanh điện tử (EBD)"
    t.string "esp", comment: "Cân bằng điện tử (VSC, ESP)"
    t.string "tcs", comment: "Kiểm soát lực kéo (chống trượt, kiểm soát độ bám đường TCS)"
    t.string "hill_start_assist", comment: "Hỗ trợ khởi hành ngang dốc"
    t.string "hill_descent_control", comment: "Hỗ trợ đổ đèo"
    t.string "blind_spot_warning", comment: "Cảnh báo điểm mù"
    t.string "rear_view_camera", comment: "Camera lùi"
    t.string "camera_360", comment: "Camera 360"
    t.string "lane_watch", comment: "Camera quan sát làn đường (LaneWatch)"
    t.string "lane_departure_warning", comment: "Cảnh báo chệch làn đường"
    t.string "lane_keeping_assist", comment: "Hỗ trợ giữ làn"
    t.string "automatic_collision_prevention", comment: "Hỗ trợ phanh tự động giảm thiểu va chạm"
    t.string "cross_traffic_warning_reverse", comment: "Cảnh báo phương tiện cắt ngang khi lùi"
    t.string "driver_drowsiness_warning", comment: "Cảnh báo tài xế buồn ngủ"
    t.string "isofix_hooks", comment: "Móc ghế an toàn cho trẻ em Isofix"
    t.string "tire_pressure_sensor", comment: "Cảm biến áp suất lốp"
    t.string "front_distance_sensor", comment: "Cảm biến khoảng cách phía trước"
    t.string "front_collision_warning", comment: "Cảnh báo tiền va chạm"
    t.string "wind_stability", comment: "Ổn định thân xe khi gió thổi ngang"
    t.string "lane_change_support", comment: "Hỗ trợ chuyển làn"
    t.string "sudden_acceleration_prevention", comment: "Chống tăng tốc đột ngột (đạp nhầm chân ga)"
    t.string "front_vehicle_departure_alert", comment: "Thông báo xe phía trước khởi hành"
    t.string "front_vehicle_start_alert", comment: "Thông báo xe trước khởi hành"
    t.string "automatic_lane_change", comment: "Tự động chuyển làn"
    t.string "door_traffic_warning", comment: "Cảnh báo giao thông khi mở cửa"
    t.string "limited_slip_differential", comment: "Vi sai hạn chế trượt LSD"
    t.string "traffic_sign_recognition", comment: "Nhận diện biển báo giao thông"
    t.string "automatic_parking_support", comment: "Hỗ trợ đỗ xe tự động"
    t.string "off_road_cruise_control", comment: "Kiểm soát hành trình trên đường địa hình"
    t.string "front_rear_sensors", comment: "Hệ thống cảm biến trước/sau"
    t.string "blind_spot_camera", comment: "Camera quan sát điểm mù"
    t.string "active_yaw_control", comment: "Kiểm soát vào cua chủ động AYC (Active Yaw Control)"
    t.string "rear_automatic_emergency_braking", comment: "Phanh tự động khẩn cấp sau va chạm"
    t.string "blind_spot_display", comment: "Hiển thị điểm mù trên màn hình (BVM)"
    t.string "front_cross_traffic_warning", comment: "Cảnh báo phương tiện phía trước khởi hành"
    t.index ["trim_id"], name: "index_safety_technologies_on_trim_id"
  end

  create_table "sales", force: :cascade do |t|
    t.string "year"
    t.string "month"
    t.string "model_number"
    t.string "total_sales"
    t.string "northern_sales"
    t.string "central_sales"
    t.string "southern_sales"
    t.bigint "model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_sales_on_model_id"
  end

  create_table "segments", force: :cascade do |t|
    t.string "segment_name"
    t.text "segment_desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "size_weights", force: :cascade do |t|
    t.string "seating_capacity"
    t.string "dimensions"
    t.string "wheelbase"
    t.string "ground_clearance"
    t.string "cargo_volume"
    t.string "fuel_tank_capacity"
    t.string "curb_weight"
    t.string "tire_wheel"
    t.bigint "trim_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "turning_radius"
    t.string "total_weight"
    t.string "luggage_volume"
    t.index ["trim_id"], name: "index_size_weights_on_trim_id"
  end

  create_table "suspension_brakes", force: :cascade do |t|
    t.string "front_suspension"
    t.string "rear_suspension"
    t.string "front_brakes"
    t.string "rear_brakes"
    t.bigint "trim_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shock_absorber_system"
    t.index ["trim_id"], name: "index_suspension_brakes_on_trim_id"
  end

  create_table "trims", force: :cascade do |t|
    t.bigint "model_id", null: false
    t.string "name"
    t.string "listed_price"
    t.string "hn_price"
    t.string "tphcm_price"
    t.string "other_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "model_brand"
    t.string "model_title_name"
    t.string "trim_type"
    t.string "trim_source"
    t.index ["model_id"], name: "index_trims_on_model_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "type_name"
    t.string "type_image"
    t.text "type_desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "driving_assistances", "trims"
  add_foreign_key "engine_transmissions", "trims"
  add_foreign_key "exteriors", "trims"
  add_foreign_key "interiors", "trims"
  add_foreign_key "model_details", "models"
  add_foreign_key "models", "brands"
  add_foreign_key "models", "segments"
  add_foreign_key "models", "types"
  add_foreign_key "safety_technologies", "trims"
  add_foreign_key "sales", "models"
  add_foreign_key "size_weights", "trims"
  add_foreign_key "suspension_brakes", "trims"
  add_foreign_key "trims", "models"
end
