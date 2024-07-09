# frozen_string_literal: true

# lib/tasks/import_data.rake

namespace :import do
  desc 'Import data from JSON to brands table'
  task brands: :environment do
    Brand.connection.execute('ALTER SEQUENCE brands_id_seq RESTART WITH 1')
    Brand.delete_all
    json_data = File.read('/home/hth/Final_project/db_json/brand.json')
    brands = JSON.parse(json_data)
    brands.each do |brand_data|
      Brand.create(brand_data)
    end
    puts 'Data imported successfully!'
  end

  desc 'Import data from JSON to segments table'
  task segments: :environment do
    Segment.connection.execute('ALTER SEQUENCE segments_id_seq RESTART WITH 1')
    Segment.delete_all
    json_data = File.read('/home/hth/Final_project/db_json/segment.json')
    segments = JSON.parse(json_data)
    segments.each do |segment_data|
      Segment.create(segment_data)
    end
    puts 'Data imported successfully!'
  end

  desc 'Import data from JSON to types table'
  task types: :environment do
    Type.connection.execute('ALTER SEQUENCE types_id_seq RESTART WITH 1')
    Type.delete_all
    json_data = File.read('/home/hth/Final_project/db_json/type.json')
    types = JSON.parse(json_data)
    types.each do |type_data|
      Type.create(type_data)
    end
    puts 'Data imported successfully!'
  end

  desc 'Import data from JSON to models table'
  task models: :environment do
    # Đặt lại trình tự ID
    Model.connection.execute('ALTER SEQUENCE models_id_seq RESTART WITH 1')
    Model.delete_all
  
    # Đọc dữ liệu JSON
    json_data = File.read('/home/hth/Final_project/db_json/model.json')
    models = JSON.parse(json_data)
  
    # Xử lý từng bản ghi trong JSON
    models.each do |model_data|
      # Tìm hoặc tạo Brand
      brand_name = model_data['model_brand']
      brand = Brand.find_or_create_by(brand_name: brand_name)
  
      # Tìm hoặc tạo Segment
      segment_name = model_data['model_segment']
      segment = Segment.find_or_create_by(segment_name: segment_name)
  
      # Tìm hoặc tạo Type
      type_name = model_data['model_type']
      type = Type.find_or_create_by(type_name: type_name)
  
      # Gán các khóa ngoại vào model_data
      model_data['brand_id'] = brand.id
      model_data['segment_id'] = segment.id
      model_data['type_id'] = type.id
  
      # Tạo Model
      Model.create!(model_data) # Sử dụng `create!` để báo lỗi nếu có vấn đề
    end
  
    puts 'Data imported successfully!'
  end
  

  desc 'Import data from JSON to trims table'
  task trims: :environment do
    Trim.connection.execute('ALTER SEQUENCE trims_id_seq RESTART WITH 1')
    Trim.delete_all

    json_data = File.read('/home/hth/Final_project/db_json/trim_spider_name.json')
    trims_data = JSON.parse(json_data)

    trims_data.each do |trim_data|
      model_brand = trim_data['model_brand']
      model_title_name = trim_data['model_title_name']

      # Tìm model bằng brand và title_name
      model = Model.find_by(model_brand: model_brand, model_title_name: model_title_name)

      # Kiểm tra xem model có tồn tại hay không
      unless model
        puts "Model '#{model_title_name}' for brand '#{model_brand}' not found. Import aborted."
        next
      end

      trim_data['model_id'] = model.id  # Gán model_id vào trim_data

      trim_data['prices'].each do |price_data|
        Trim.create(
          model_id: trim_data['model_id'],
          model_brand: trim_data['model_brand'],
          model_title_name: trim_data['model_title_name'],
          name: price_data['name'],
          listed_price: price_data['listed_price'],
          hn_price: price_data['HN_price'],
          tphcm_price: price_data['TPHCM_price'],
          other_price: price_data['other_price']
        )
      end
    end

    puts 'Data imported successfully!'
  end

  desc 'Import data from JSON to model details table'
  task model_details: :environment do
    ModelDetail.connection.execute('ALTER SEQUENCE model_details_id_seq RESTART WITH 1')
    ModelDetail.delete_all

    json_data = File.read('/home/hth/Final_project/db_json/model_desc.json')
    model_details_data = JSON.parse(json_data)

    model_details_data.each do |model_data|
      model_brand = model_data['model_brand']
      model_title_name = model_data['model_title_name']
      model_description = model_data['model_description']
      model = Model.find_by(model_brand: model_brand, model_title_name: model_title_name)

      # Kiểm tra xem model có tồn tại hay không
      unless model
        puts "Model '#{model_title_name}' for brand '#{model_brand}' not found. Import aborted."
        next
      end

      model_data['model_id'] = model.id  # Gán model_id vào trim_data
      # Create a new model_detail record
      ModelDetail.create(
        model_id: model_data['model_id'],
        model_brand: model_brand,
        model_title_name: model_title_name,
        model_description: model_description
      )
    end

    puts 'Data imported successfully!'
  end

  desc 'Import data from JSON to trims table'
  task update_trims: :environment do
    json_data = File.read('/home/hth/Final_project/db_json/trim.json')
    trims_data = JSON.parse(json_data)

    trims_data.each do |trim_data|
      model_title_name = trim_data['model_name']
      name = trim_data['model_trim_name']
      trim_type = trim_data['trim_type']
      trim_source = trim_data['trim_source']

      # Tìm trim theo brand và title_name
      trim = Trim.find_by(name: name, model_title_name: model_title_name)

      unless trim
        puts "Trim '#{model_title_name}' for model '#{name}' not found. Import aborted."
        next
      end

      # Cập nhật dữ liệu cho trim
      trim.update(trim_type: trim_type, trim_source: trim_source)
    end
    puts 'Data imported successfully!'
  end

desc 'Import data from JSON to engine_transmissions table'
task engine_transmissions: :environment do
  EngineTransmission.connection.execute('ALTER SEQUENCE engine_transmissions_id_seq RESTART WITH 1')
  EngineTransmission.delete_all

  json_data = File.read('/home/hth/Final_project/db_json/trim.json')
  trim_datas = JSON.parse(json_data)

  trim_datas.each do |trim_data|
    model_title_name = trim_data['model_name']
    name = trim_data['model_trim_name']

    # Kiểm tra xem trim có tồn tại hay không
    trim = Trim.find_by(name: name, model_title_name: model_title_name)

    unless trim
      puts "Trim '#{model_title_name}' for model '#{name}' not found. Import aborted."
      next
    end

    engine_data = trim_data.dig('car_info', 'Động cơ/hộp số') || {} # Tránh lỗi nếu không có dữ liệu

    # Create a new engine_transmission record
    EngineTransmission.create(
      engine_type: engine_data['Kiểu động cơ'],
      engine_capacity: engine_data['Dung tích (cc)'],
      power: engine_data['Công suất (mã lực)/vòng tua (vòng/phút)'],
      torque: engine_data['Mô-men xoắn (Nm)/vòng tua (vòng/phút)'],
      gearbox: engine_data['Hộp số'],
      drive_system: engine_data['Hệ dẫn động'],
      fuel_type: engine_data['Loại nhiên liệu'],
      fuel_consumption: engine_data['Mức tiêu thụ nhiên liệu đường hỗn hợp (lít/100 km)'],
      automatic_transmission: engine_data['Cần số điện tử'],
      operating_range_km: engine_data['Tầm hoạt động (km)'],
      fast_dc_charging_10_80_minutes: engine_data['Thời gian sạc nhanh DC từ 10-80% (phút)'],
      battery_type: engine_data['Loại pin'],
      battery_capacity_kwh: engine_data['Dung lượng pin (kWh)'],
      standard_ac_charging_time: engine_data['Thời gian sạc AC tiêu chuẩn từ 0%-100% (giờ)'],
      electric_motor_power: engine_data['Công suất môtơ điện (mã lực)'],
      electric_motor_torque: engine_data['Mô-men xoắn môtơ điện (Nm)'],
      max_speed_kmh: engine_data['Tốc độ tối đa (km/h)'],
      acceleration_0_100_seconds: engine_data['Thời gian tăng tốc từ 0-100 km/h (giây)'],
      standard_charger_onboard: engine_data['Bộ sạc tiêu chuẩn theo xe'],
      driving_modes: engine_data['Chế độ lái'],
      battery_capacity: engine_data['Dung lượng pin'],
      fast_charging_time: engine_data['Thời gian sạc nhanh'],
      regenerative_braking_system: engine_data['Hệ thống phanh tái sinh'],
      fast_charging_10_70_minutes: engine_data['Thời gian sạc nhanh 10-70% (phút)'],
      fast_charging_30_80_minutes: engine_data['Thời gian sạc nhanh 30-80% (phút)'],
      trim_id: trim.id
    )
  end

  puts 'Data imported successfully!'
end

desc 'Import data from JSON to SizeWeight table'
task size_weights: :environment do
  SizeWeight.connection.execute('ALTER SEQUENCE size_weights_id_seq RESTART WITH 1')
  SizeWeight.delete_all

  json_data = File.read('/home/hth/Final_project/db_json/trim.json')
  trim_datas = JSON.parse(json_data)

  trim_datas.each do |trim_data|
    model_title_name = trim_data['model_name']
    name = trim_data['model_trim_name']

    # Kiểm tra xem trim có tồn tại hay không
    trim = Trim.find_by(name: name, model_title_name: model_title_name)

    unless trim
      puts "Trim '#{model_title_name}' for model '#{name}' not found. Import aborted."
      next
    end

    size_data = trim_data.dig('car_info', 'Kích thước/trọng lượng') || {} # Tránh lỗi nếu không có dữ liệu

    # Create a new engine_transmission record
    SizeWeight.create(
      seating_capacity: size_data['Số chỗ'],
      dimensions: size_data['Kích thước dài x rộng x cao (mm)'],
      wheelbase: size_data['Chiều dài cơ sở (mm)'],
      ground_clearance: size_data['Khoảng sáng gầm (mm)'],
      turning_radius: size_data['Bán kính vòng quay (mm)'],
      cargo_volume: size_data['Dung tích khoang hành lý (lít)'],
      fuel_tank_capacity: size_data['Dung tích bình nhiên liệu (lít)'],
      curb_weight: size_data['Trọng lượng bản thân (kg)'],
      total_weight: size_data['Trọng lượng toàn tải (kg)'],
      tire_wheel: size_data['Lốp, la-zăng'],
      luggage_volume: size_data['Thể tích khoang hành lý (lít)'],
      trim_id: trim.id
    )    
  end

  puts 'Data imported successfully!'
end

desc 'Import data from JSON to SuspensionBrake table'
task suspension_brakes: :environment do
  SuspensionBrake.connection.execute('ALTER SEQUENCE suspension_brakes_id_seq RESTART WITH 1')
  SuspensionBrake.delete_all

  json_data = File.read('/home/hth/Final_project/db_json/trim.json')
  trim_datas = JSON.parse(json_data)

  trim_datas.each do |trim_data|
    model_title_name = trim_data['model_name']
    name = trim_data['model_trim_name']

    # Kiểm tra xem trim có tồn tại hay không
    trim = Trim.find_by(name: name, model_title_name: model_title_name)

    unless trim
      puts "Trim '#{model_title_name}' for model '#{name}' not found. Import aborted."
      next
    end

    brake_data = trim_data.dig('car_info', 'Hệ thống treo/phanh') || {} # Tránh lỗi nếu không có dữ liệu

    # Create a new engine_transmission record
    SuspensionBrake.create(
      front_suspension: brake_data['Treo trước'],
      rear_suspension: brake_data['Treo sau'],
      front_brakes: brake_data['Phanh trước'],
      rear_brakes: brake_data['Phanh sau'],
      shock_absorber_system: brake_data['Hệ thống giảm xóc'],
      trim_id: trim.id
    )    
  end

  puts 'Data imported successfully!'
end

desc 'Import data from JSON to Exterior table'
task exteriors: :environment do
  Exterior.connection.execute('ALTER SEQUENCE exteriors_id_seq RESTART WITH 1')
  Exterior.delete_all

  json_data = File.read('/home/hth/Final_project/db_json/trim.json')
  trim_datas = JSON.parse(json_data)

  trim_datas.each do |trim_data|
    model_title_name = trim_data['model_name']
    name = trim_data['model_trim_name']

    # Kiểm tra xem trim có tồn tại hay không
    trim = Trim.find_by(name: name, model_title_name: model_title_name)

    unless trim
      puts "Trim '#{model_title_name}' for model '#{name}' not found. Import aborted."
      next
    end

    exterior_data = trim_data.dig('car_info', 'Ngoại thất') || {} # Tránh lỗi nếu không có dữ liệu

    # Create a new engine_transmission record
    Exterior.create(
      headlight_high_beam: exterior_data['Đèn chiếu xa'],
      headlight_low_beam: exterior_data['Đèn chiếu gần'],
      daytime_running_lights: exterior_data['Đèn ban ngày'],
      tail_lights: exterior_data['Đèn hậu'],
      rearview_mirror: exterior_data['Gương chiếu hậu'],
      fog_lights: exterior_data['Đèn sương mù'],
      exhaust_pipe: exterior_data['Ống xả'],
      other_features: exterior_data['Trang bị khác'],
      auto_headlights: exterior_data['Đèn pha tự động bật/tắt'],
      auto_headlight_range_control: exterior_data['Đèn pha tự động xa/gần'],
      auto_headlight_leveling: exterior_data['Đèn pha tự động điều chỉnh góc chiếu'],
      high_mounted_stop_light: exterior_data['Đèn phanh trên cao'],
      heated_rearview_mirror: exterior_data['Sấy gương chiếu hậu'],
      automatic_rain_sensing_wipers: exterior_data['Gạt mưa tự động'],
      shark_fin_antenna: exterior_data['Ăng ten vây cá'],
      power_operated_trunk: exterior_data['Cốp đóng/mở điện'],
      hands_free_trunk: exterior_data['Mở cốp rảnh tay'],
      two_tone_paint_option: exterior_data['Tùy chọn sơn hai màu'],
      anti_glare_side_mirrors: exterior_data['Gương hậu ngoài tự động chống chói'],
      lower_side_mirror_when_reversing: exterior_data['Gương hậu ngoại tự động hạ thấp khi lùi'],
      hidden_door_handles: exterior_data['Tay nắm cửa thiết kế dạng ẩn'],
      rear_wind_deflector: exterior_data['Cánh gió sau'],
      hood_air_intake: exterior_data['Khe gió nắp ca pô'],
      roof_rack: exterior_data['Giá nóc'],
      trim_id: trim.id
    )    
  end

  puts 'Data imported successfully!'
end

desc 'Import data from JSON to interiors table'
task interiors: :environment do
  Interior.connection.execute('ALTER SEQUENCE interiors_id_seq RESTART WITH 1')
  Interior.delete_all

  json_data = File.read('/home/hth/Final_project/db_json/trim.json')
  trim_datas = JSON.parse(json_data)

  trim_datas.each do |trim_data|
    model_title_name = trim_data['model_name']
    name = trim_data['model_trim_name']

    # Kiểm tra xem trim có tồn tại hay không
    trim = Trim.find_by(name: name, model_title_name: model_title_name)

    unless trim
      puts "Trim '#{model_title_name}' for model '#{name}' not found. Import aborted."
      next
    end

    interior_data = trim_data.dig('car_info', 'Nội thất') || {} # Tránh lỗi nếu không có dữ liệu

    # Create a new interiors record
Interior.create(
  trim_id: trim.id,
  seat_material: interior_data['Chất liệu bọc ghế'],
  driver_seat_adjustment: interior_data['Điều chỉnh ghế lái'],
  memory_driver_seat_position: interior_data['Nhớ vị trí ghế lái'],
  passenger_seat_adjustment: interior_data['Điều chỉnh ghế phụ'],
  driver_dashboard: interior_data['Bảng đồng hồ tài xế'],
  steering_wheel_material: interior_data['Chất liệu bọc vô-lăng'],
  second_row_seats: interior_data['Hàng ghế thứ hai'],
  third_row_seats: interior_data['Hàng ghế thứ ba'],
  air_conditioning: interior_data['Điều hoà'],
  one_touch_windows: interior_data['Cửa kính một chạm'],
  infotainment_screen: interior_data['Màn hình giải trí'],
  speaker_system: interior_data['Hệ thống loa'],
  double_layer_glass: interior_data['Kính hai lớp'],
  tinted_glass: interior_data['Kính tối màu'],
  rear_entertainment_screen: interior_data['Màn hình giải trí ghế sau'],
  rear_passenger_screen: interior_data['Màn hình giải trí ghế phụ'],
  smartphone_integration: interior_data['Kết nối điện thoại thông minh'],
  additional_features: interior_data['Trang bị khác'],
  steering_adjustment: interior_data['Điều chỉnh vô-lăng'],
  interior_color: interior_data['Màu nội thất'],
  driver_seat_massage: interior_data['Massage ghế lái'],
  passenger_seat_massage: interior_data['Massage ghế phụ'],
  driver_seat_cooling: interior_data['Sưởi ấm ghế lái'],
  passenger_seat_cooling: interior_data['Sưởi ấm ghế phụ'],
  driver_steering_controls: interior_data['Nút bấm tích hợp trên vô-lăng'],
  smart_key: interior_data['Chìa khoá thông minh'],
  push_button_start: interior_data['Khởi động nút bấm'],
  rear_seat_vents: interior_data['Cửa gió hàng ghế sau'],
  sunroof: interior_data['Cửa sổ trời'],
  panoramic_sunroof: interior_data['Cửa sổ trời toàn cảnh'],
  auto_dimming_rearview_mirror: interior_data['Gương chiếu hậu trong xe chống chói tự động'],
  front_armrest: interior_data['Tựa tay hàng ghế trước'],
  rear_armrest: interior_data['Tựa tay hàng ghế sau'],
  apple_carplay: interior_data['Kết nối Apple CarPlay'],
  android_auto: interior_data['Kết nối Android Auto'],
  voice_command: interior_data['Ra lệnh giọng nói'],
  hands_free_calling: interior_data['Đàm thoại rảnh tay'],
  wifi_hotspot: interior_data['Phát WiFi'],
  aux_connection: interior_data['Kết nối AUX'],
  usb_connection: interior_data['Kết nối USB'],
  bluetooth_connection: interior_data['Kết nối Bluetooth'],
  am_fm_radio: interior_data['Radio AM/FM'],
  wireless_charging: interior_data['Sạc không dây'],
  power_tailgate: interior_data['Cửa hít'],
  remote_start: interior_data['Khởi động từ xa'],
  air_filter: interior_data['Lọc không khí'],
  steering_wheel_heating: interior_data['Sưởi vô-lăng'],
  navigation: interior_data['Điều hướng (bản đồ)'],
  air_quality_control: interior_data['Kiểm soát chất lượng không khí'],
  gesture_control: interior_data['Điều khiển bằng cử chỉ'],
  center_display: interior_data['Màn hình trung tâm'],
  power_driver_seat_adjustment: interior_data['Ghế lái chỉnh điện'],
  power_passenger_seat_adjustment: interior_data['Ghế phụ chỉnh điện'],
  wifi_connectivity: interior_data['Kết nối WiFi'],
  interior_ambient_lighting: interior_data['Đèn viền trang trí nội thất chủ động'],
  apple_carplay_android_auto: interior_data['Apple CarPlay và Android auto'],
  interior_material: interior_data['Chất liệu nội thất'],
  starry_ceiling: interior_data['Trần sao'],
  alcantara_ceiling: interior_data['Trần vật liệu Alcatara'],
  driver_cabin_and_passenger_compartment_partition_with_tv: interior_data['Vách ngăn khoang lái và Cabin - kèm tivi'],
  independent_seats_with_leg_support: interior_data['Ghế độc lập - có bệ đỡ chân'],
  virtual_assistant: interior_data['Trợ lý ảo'],
  steering_memory: interior_data['Nhớ vị trí vô-lăng'],
  rear_seat_heating_cooling: interior_data['Sưởi và làm mát hàng ghế sau'],
  front_seat_heating_cooling: interior_data['Sưởi và làm mát hàng ghế trước'],
  rear_seats_heating: interior_data['Hàng ghế sau có sưởi'],
  rear_sunshade: interior_data['Đèn viền Ambient'],
  rear_door_sunshade: interior_data['Rèm che nắng kính sau'],
  power_outlet_230V: interior_data['Ổ điện xoay chiều 230V']
)
  
  end

  puts 'Data imported successfully!'
end

desc 'Import data from JSON to driving_assistances table'
task driving_assistances: :environment do
  DrivingAssistance.connection.execute('ALTER SEQUENCE driving_assistances_id_seq RESTART WITH 1')
  DrivingAssistance.delete_all

  json_data = File.read('/home/hth/Final_project/db_json/trim.json')  # Replace with the actual path to your JSON file
  trim_datas = JSON.parse(json_data)

  trim_datas.each do |trim_data|
    model_title_name = trim_data['model_name']
    name = trim_data['model_trim_name']

    # Check if trim exists
    trim = Trim.find_by(name: name, model_title_name: model_title_name)

    unless trim
      puts "Trim '#{model_title_name}' for model '#{name}' not found. Import aborted."
      next
    end

    driving_assistance_data = trim_data.dig('car_info', 'Hỗ trợ vận hành') || {}

    # Create a new driving_assistances record
    DrivingAssistance.create(
      trim_id: trim.id,
      idling_stop: driving_assistance_data[ 'Ngắt động cơ tạm thời (Idling Stop/Start-Stop)'] || driving_assistance_data[ 'Ngắt động cơ tạm thời (Idling Stop)'],
      power_steering: driving_assistance_data['Trợ lực vô-lăng'],
      multiple_driving_modes: driving_assistance_data['Nhiều chế độ lái'],
      steering_wheel_paddle_shifters: driving_assistance_data['Lẫy chuyển số trên vô-lăng'],
      cornering_assist: driving_assistance_data['Hỗ trợ đánh lái khi vào cua'],
      acceleration_control:  driving_assistance_data['Kiểm soát gia tốc'],
      electronic_parking_brake: driving_assistance_data['Phanh tay điện tử'],
      auto_hold: driving_assistance_data['Giữ phanh tự động'],
      rear_wheel_steering: driving_assistance_data['Đánh lái bánh sau'],
      active_park_assist: driving_assistance_data['Hỗ trợ đỗ xe chủ động'],
      speed_limit_display: driving_assistance_data['Giới hạn tốc độ'],
      vehicle_management_via_phone_app: driving_assistance_data['Quản lý xe qua app điện thoại'],
      traffic_sign_recognition: driving_assistance_data['Hỗ trợ đọc biển báo, tín hiệu giao thông'],
      terrain_mode: driving_assistance_data['Chế độ lái địa hình'],
      automatic_rev_match_system: driving_assistance_data['Hỗ trợ đọc biển báo, tín hiệu giao thông'],
      electronic_throttle_control_dbw: driving_assistance_data['Van bướm ga điều chỉnh điện tử DBW'],

      electric_locking_differential: driving_assistance_data['Gài cầu điện'],

      rear_differential_lock: driving_assistance_data['Khóa vi sai cầu sau'],

      automatic_rearview_assist_ara: driving_assistance_data['Hỗ trợ lùi xe tự động (ARA)'],
      
      cruise_control: driving_assistance_data['Kiểm soát hành trình (Cruise Control)'],

      adaptive_cruise_control: driving_assistance_data['Kiểm soát hành trình thích ứng (Adaptive Cruise Control)'],

      electric_brake_force_distribution: driving_assistance_data['Phanh điện tử'],
      forward_collision_warning: driving_assistance_data['Cảnh báo tiền va chạm'],

      remote_start: driving_assistance_data['Khởi động từ xa']
    )
  end

  puts 'Data imported successfully!'
end

desc 'Import data from JSON to safety_technologies table'
task safety_technologies: :environment do
  SafetyTechnology.connection.execute('ALTER SEQUENCE safety_technologies_id_seq RESTART WITH 1')
  SafetyTechnology.delete_all

  json_data = File.read('/home/hth/Final_project/db_json/trim.json')  # Replace with the actual path to your JSON file
  trim_datas = JSON.parse(json_data)

  trim_datas.each do |trim_data|
    model_title_name = trim_data['model_name']
    name = trim_data['model_trim_name']

    # Check if trim exists
    trim = Trim.find_by(name: name, model_title_name: model_title_name)

    unless trim
      puts "Trim '#{model_title_name}' for model '#{name}' not found. Import aborted."
      next
    end

    safety_technologies_data = trim_data.dig('car_info', 'Công nghệ an toàn') || {}

    # Create a new driving_assistances record
    SafetyTechnology.create(
      trim_id: trim.id,
      airbag_count: safety_technologies_data['Số túi khí'],
      rear_sensor: safety_technologies_data['Cảm biến lùi'],
      central_locking: safety_technologies_data['Khóa cửa trung tâm'],
      cruise_control: safety_technologies_data['Kiểm soát hành trình (Cruise Control)'],
      adaptive_cruise_control: safety_technologies_data['Kiểm soát hành trình thích ứng (Adaptive Cruise Control)'],
      abs_brakes: safety_technologies_data['Chống bó cứng phanh (ABS)'],
      emergency_brake_assist: safety_technologies_data['Hỗ trợ lực phanh khẩn cấp (BA)'],
      ebd: safety_technologies_data['Phân phối lực phanh điện tử (EBD)'],
      esp: safety_technologies_data['Cân bằng điện tử (VSC, ESP)'],
      tcs: safety_technologies_data['Kiểm soát lực kéo (chống trượt, kiểm soát độ bám đường TCS)'],
      hill_start_assist: safety_technologies_data['Hỗ trợ khởi hành ngang dốc'],
      hill_descent_control: safety_technologies_data['Hỗ trợ đổ đèo'],
      blind_spot_warning: safety_technologies_data['Cảnh báo điểm mù'],
      rear_view_camera: safety_technologies_data['Camera lùi'],
      camera_360: safety_technologies_data['Camera 360'],
      lane_watch: safety_technologies_data['Camera quan sát làn đường (LaneWatch)'],
      lane_departure_warning: safety_technologies_data['Cảnh báo chệch làn đường'],
      lane_keeping_assist: safety_technologies_data['Hỗ trợ giữ làn'],
      automatic_collision_prevention: safety_technologies_data['Hỗ trợ phanh tự động giảm thiểu va chạm'],
      cross_traffic_warning_reverse: safety_technologies_data['Cảnh báo phương tiện cắt ngang khi lùi'],
      driver_drowsiness_warning: safety_technologies_data['Cảnh báo tài xế buồn ngủ'],
      isofix_hooks: safety_technologies_data['Móc ghế an toàn cho trẻ em Isofix'],
      tire_pressure_sensor: safety_technologies_data['Cảm biến áp suất lốp'],
      front_distance_sensor: safety_technologies_data['Cảm biến khoảng cách phía trước'],
      front_collision_warning: safety_technologies_data['Cảnh báo tiền va chạm'],
      wind_stability: safety_technologies_data['Ổn định thân xe khi gió thổi ngang'],
      lane_change_support: safety_technologies_data['Hỗ trợ chuyển làn'],
      sudden_acceleration_prevention: safety_technologies_data['Chống tăng tốc đột ngột (đạp nhầm chân ga)'],
      front_vehicle_departure_alert: safety_technologies_data['Thông báo xe phía trước khởi hành'],
      front_vehicle_start_alert: safety_technologies_data['Thông báo xe trước khởi hành'],
      automatic_lane_change: safety_technologies_data['Tự động chuyển làn'],
      door_traffic_warning: safety_technologies_data['Cảnh báo giao thông khi mở cửa'],
      limited_slip_differential: safety_technologies_data['Vi sai hạn chế trượt LSD'],
      traffic_sign_recognition: safety_technologies_data['Nhận diện biển báo giao thông'],
      automatic_parking_support: safety_technologies_data['Hỗ trợ đỗ xe tự động'],
      off_road_cruise_control: safety_technologies_data['Kiểm soát hành trình trên đường địa hình'],
      front_rear_sensors: safety_technologies_data['Hệ thống cảm biến trước/sau'],
      blind_spot_camera: safety_technologies_data['Camera quan sát điểm mù'],
      active_yaw_control: safety_technologies_data['Kiểm soát vào cua chủ động AYC (Active Yaw Control)'],
      rear_automatic_emergency_braking: safety_technologies_data['Phanh tự động khẩn cấp sau va chạm'],
      blind_spot_display: safety_technologies_data['Hiển thị điểm mù trên màn hình (BVM)'],
      front_cross_traffic_warning: safety_technologies_data['Cảnh báo phương tiện phía trước khởi hành']
    )
  end

  puts 'Data imported successfully!'
end

desc 'Import data from JSON to sales table'
task sales: :environment do
  Sale.connection.execute('ALTER SEQUENCE sales_id_seq RESTART WITH 1')
  Sale.delete_all

  json_data = File.read('/home/hth/Final_project/db_json/2023_top_sale.json')
  sale_datas = JSON.parse(json_data)

  sale_datas.each do |sale_data|
    model_brand = sale_data['model_brand']
    model_name = sale_data['model_name']

    # Kiểm tra xem trim có tồn tại hay không
    model = Model.find_by(model_brand: model_brand, model_name_main: model_name)

    unless model
      puts "Model '#{model_name}' for brand '#{model_brand}' not found. Import aborted."
      next
    end


    # Create a new engine_transmission record
    Sale.create(
      year: "2023",
      month: "all",
      model_number: sale_data['model_number'],
      total_sales: sale_data['total_sales'],
      northern_sales: sale_data['northern_sales'],
      central_sales: sale_data['central_sales'],
      southern_sales: sale_data['southern_sales'],
      model_id: model.id
    )    
  end

  puts 'Data imported successfully!'
end

desc 'Import prefecture data from JSON'
task import_prefectures: :environment do
  # Xóa dữ liệu cũ trong bảng Prefecture (nếu có)
  Prefecture.connection.execute('ALTER SEQUENCE prefectures_id_seq RESTART WITH 1')
  Prefecture.delete_all

  # Đọc dữ liệu từ file JSON
  json_data = File.read('/home/hth/Final_project/db_json/prefecture.json')
  prefecture_data = JSON.parse(json_data)

  # Lặp qua từng mục dữ liệu trong JSON và tạo bản ghi Prefecture tương ứng
  prefecture_data.each do |data|
    Prefecture.create(
      name: data['name'],
      prefecture_type: data['prefecture_type']
    )
  end

  puts 'Prefecture data imported successfully!'
end

desc 'Import data from JSON to districts table'
task import_districts: :environment do
  # Đặt lại trình tự ID
  District.connection.execute('ALTER SEQUENCE districts_id_seq RESTART WITH 1')
  District.delete_all

  # Đọc dữ liệu JSON
  json_data = File.read('/home/hth/Final_project/db_json/district.json')
  districts = JSON.parse(json_data)

  # Xử lý từng bản ghi trong JSON
  districts.each do |district_data|
    # Tìm hoặc tạo Prefecture
    prefecture_name = district_data['tỉnh thành']
    prefecture = Prefecture.find_or_create_by(name: prefecture_name)

    # Tạo District và liên kết với Prefecture
    district = District.new(
      name: district_data['quận huyện'],
      prefecture: prefecture # Sử dụng liên kết tự động được tạo bởi Rails
    )

    # Lưu District vào cơ sở dữ liệu và báo lỗi nếu có vấn đề
    unless district.save
      puts "Error importing district: #{district.errors.full_messages.join(', ')}"
    end
  end

  puts 'Data imported successfully!'
end

desc 'Import data from JSON to iamge table'
  task images: :environment do
    Image.connection.execute('ALTER SEQUENCE images_id_seq RESTART WITH 1')
    Image.delete_all

    json_data = File.read('/home/hth/Final_project/db_json/model_image_with_urls.json')
    images_data = JSON.parse(json_data)

    images_data.each do |image_data|
      model_title_name = image_data['model_title_name']
      model_brand = image_data['model_brand']
      model = Model.find_by( model_title_name: model_title_name, model_brand: model_brand)

      # Kiểm tra xem model có tồn tại hay không
      unless model
        puts "Model '#{model_title_name}' for brand '#{model_brand}' not found. Import aborted."
        next
      end

      image_data['model_id'] = model.id  # Gán model_id vào trim_data
      # Create a new model_detail record
      image_data['image_urls'].each do |image_url|
        Image.create!(image_url: image_url, model: model)
      end
      
    end

    puts 'Data imported successfully!'
  end

  desc 'Import autofun_data from JSON to  table'
  task autofun_cadillac: :environment do

    daihatsu_model_data = File.read('/home/hth/Final_project/db_json/cadillac_trims.json')
    data = JSON.parse(daihatsu_model_data)

    brand_name = data["brand_name"]
    models = data["models"]

    brand = Brand.find_by(brand_name: brand_name)
    unless brand
      puts "Brand '#{brand_name}' not found. Import aborted."
      next
    end

    models.each do |model_data|

      segment = Segment.find_by(segment_name: model_data["segment"])
      unless segment
        puts "segment '#{model_data["segment"]}' not found. Import aborted."
        next
      end

      type = Type.find_by(type_name: model_data["type_info"])
      unless type
        puts "type '#{model_data["type_info"]}' not found. Import aborted."
        next
      end

      model = Model.new(
        model_brand: brand.brand_name,
        model_title_name: model_data["model_name"],
        model_price: model_data["model_price"],
        model_segment: segment.segment_name,
        model_main_pic: model_data["model_image"],
        model_engine: model_data["model_engine"],
        model_power: model_data["model_power"],
        model_torque: model_data["model_torque"],
        model_gearbox: model_data["model_gearbox"],
        model_drive_system: nil,  # Cập nhật giá trị phù hợp nếu có
        model_seat: model_data["model_seat"],
        model_type: type.type_name,
        model_source: "Nhập khẩu",
        model_year: model_data["model_year"],
        model_name_main: model_data["model_name"],
        brand_id: brand.id,
        segment_id: segment.id,
        type_id: type.id
      )

      if model.save
        puts "Model #{model.model_title_name} saved successfully"
      else
        puts "Failed to save model '#{model.model_title_name}': #{model.errors.full_messages.join(', ')}"
      end
    end

    puts 'Data imported successfully!'
  end

  desc 'Import autofun_data from JSON to  table'
  task autofun_chevrolet: :environment do

    daihatsu_model_data = File.read('/home/hth/Final_project/db_json/chevrolet_trims.json')
    data = JSON.parse(daihatsu_model_data)

    brand_name = data["brand_name"]
    models = data["models"]

    brand = Brand.find_by(brand_name: brand_name)
    unless brand
      puts "Brand '#{brand_name}' not found. Import aborted."
      next
    end

    models.each do |model_data|

      segment = Segment.find_by(segment_name: model_data["segment"])
      unless segment
        puts "segment '#{model_data["segment"]}' not found. Import aborted."
        next
      end

      type = Type.find_by(type_name: model_data["type_info"])
      unless type
        puts "type '#{model_data["type_info"]}' not found. Import aborted."
        next
      end

      model = Model.find_by(model_brand: brand.brand_name, model_title_name: model_data["model_name"])

      unless model
        puts "model '#{model_data["model_name"]}' not found. Import aborted."
        next
      end

      model_data["trims"].each do |trim_data|
        trim = model.trims.new(
          name: trim_data["trim_name"],
          listed_price: trim_data["trim_price"],
          model_brand: model.model_brand,
          model_title_name: model.model_title_name,
          trim_source: "Nhập khẩu",
          trim_type: model_data["type_info"]

        )
  
        if trim.save
          puts "Trim '#{trim.name}' saved successfully"
        else
          puts "Failed to save trim '#{trim.name}': #{trim.errors.full_messages.join(', ')}"
        end
      end
    end

    puts 'Data imported successfully!'
  end

  desc 'Import autofun_data from JSON to  table'
  task autofun_daihatsu: :environment do

    daihatsu_model_data = File.read('/home/hth/Final_project/db_json/daihatsu_trims.json')
    data = JSON.parse(daihatsu_model_data)

    brand_name = data["brand_name"]
    models = data["models"]

    brand = Brand.find_by(brand_name: brand_name)
    unless brand
      puts "Brand '#{brand_name}' not found. Import aborted."
      next
    end

    models.each do |model_data|

      segment = Segment.find_by(segment_name: model_data["segment"])
      unless segment
        puts "segment '#{model_data["segment"]}' not found. Import aborted."
        next
      end

      type = Type.find_by(type_name: model_data["type_info"])
      unless type
        puts "type '#{model_data["type_info"]}' not found. Import aborted."
        next
      end

      model = Model.find_by(model_brand: brand.brand_name, model_title_name: model_data["model_name"])

      unless model
        puts "model '#{model_data["model_name"]}' not found. Import aborted."
        next
      end

      model_data["trims"].each do |trim_data|

        trim = Trim.find_by(name: trim_data["trim_name"], listed_price: trim_data["trim_price"], model_brand: model.model_brand  )
        unless trim
          puts "trim '#{trim_data["trim_name"]}' not found. Import aborted."
          next
        end

        engine_transmissions = trim.build_engine_transmission(
          engine_type: trim_data["trim_engine"],
          power: trim_data["trim_power"],
          torque: trim_data["trim_torque"],
          gearbox: trim_data["trim_gearbox"],
          fuel_type: trim_data["trim_fuel_type"],
          fuel_consumption:  trim_data["trim_fuel_consumption"],

        )
  
        if engine_transmissions.save
          puts "saved successfully"
        else
          puts "Failed to save trim  #{engine_transmissions.errors.full_messages.join(', ')}"
        end

        size_weights = trim.build_size_weight(
          fuel_tank_capacity: trim_data["trim_fuel_tank_capacity"],
          dimensions: trim_data["trim_dimensions"],
          ground_clearance: trim_data["trim_ground_clearance"],
          cargo_volume: trim_data["trim_cargo_volume"],
        )
  
        if size_weights.save
          puts "saved successfully"
        else
          puts "Failed to save trim  #{size_weights.errors.full_messages.join(', ')}"
        end

        suspension_brakes = trim.build_suspension_brake(
          front_suspension: trim_data["trim_front_suspension"],
          rear_suspension: trim_data["trim_rear_suspension"],

        )
  
        if suspension_brakes.save
          puts "saved successfully"
        else
          puts "Failed to save trim  #{suspension_brakes.errors.full_messages.join(', ')}"
        end

        exteriors = trim.build_exterior(
          headlight_high_beam: trim_data["trim_headlight_high_beam"],
          tail_lights: trim_data["trim_tail_lights"],
          seat_material: trim_data["trim_seat_material"],
          fog_lights: trim_data["trim_fog_lights"],

        )
  
        if exteriors.save
          puts "saved successfully"
        else
          puts "Failed to save trim  #{exteriors.errors.full_messages.join(', ')}"
        end

        interiors = trim.build_interior(
          apple_carplay_android_auto: trim_data["trim_apple_carplay_android_auto"],

        )
  
        if interiors.save
          puts "saved successfully"
        else
          puts "Failed to save trim  #{interiors.errors.full_messages.join(', ')}"
        end

        driving_assistances = trim.build_driving_assistance(
          cruise_control: trim_data["trim_cruise_control"],

        )
  
        if driving_assistances.save
          puts "saved successfully"
        else
          puts "Failed to save trim  #{driving_assistances.errors.full_messages.join(', ')}"
        end

        safety_technologies = trim.build_safety_technology(
          abs_brakes: trim_data["trim_abs_brakes"],
          rear_view_camera: trim_data["trim_rear_view_camera"],
          blind_spot_warning: trim_data["trim_blind_spot_warning"],
          ebd: trim_data["trim_ebd"],
          esp: trim_data["trim_esp"],
          emergency_brake_assist: trim_data["trim_emergency_brake_assist"],

        )
  
        if safety_technologies.save
          puts "saved successfully"
        else
          puts "Failed to save trim  #{safety_technologies.errors.full_messages.join(', ')}"
        end

      end
    end

    puts 'Data imported successfully!'
  end

  desc 'Import data from JSON to update_models table'
  task update_models: :environment do
    json_data = File.read('/home/hth/Final_project/db_json/model.json')
    models = JSON.parse(json_data)
  
    models.each do |model_data|
      brand_name = model_data['model_brand']
      brand = Brand.find_or_create_by(brand_name: brand_name)
  
      segment_name = model_data['model_segment']
      segment = Segment.find_or_create_by(segment_name: segment_name)
  
      type_name = model_data['model_type']
      type = Type.find_or_create_by(type_name: type_name)
      
      model = Model.find_by(
        brand: brand,
        segment: segment,
        type: type,
        model_title_name: model_data['model_title_name']
      )
      
      if model
        if model.model_price != model_data['model_price']
          model.update(model_price: model_data['model_price'])
          puts "Updated model price for #{model.model_title_name}"
        end
      else
        model_data['brand_id'] = brand.id
        model_data['segment_id'] = segment.id
        model_data['type_id'] = type.id
        Model.create!(model_data)
        puts "Created new model #{model_data['model_title_name']}"
      end
    end
    puts 'Data updated successfully!'
  end

  desc 'Update data from JSON to trims table'
  task update_trims: :environment do
    json_data = File.read('/home/hth/Final_project/db_json/trim_spider_name.json')
    trims_data = JSON.parse(json_data)

    trims_data.each do |trim_data|
      model_brand = trim_data['model_brand']
      model_title_name = trim_data['model_title_name']

      # Tìm model bằng brand và title_name
      model = Model.find_by(model_brand: model_brand, model_title_name: model_title_name)

      # Kiểm tra xem model có tồn tại hay không
      unless model
        puts "Model '#{model_title_name}' for brand '#{model_brand}' not found. Import aborted."
        next
      end

      trim_data['model_id'] = model.id  # Gán model_id vào trim_data

      trim_data['prices'].each do |price_data|
        # Tìm trim theo các thuộc tính cần thiết (ví dụ: model_id, name)
        trim = Trim.find_by(model_id: trim_data['model_id'], name: price_data['name'])

        if trim
          # Nếu tìm thấy, kiểm tra và cập nhật giá nếu cần
          updated = false
          if trim.listed_price != price_data['listed_price']
            trim.update(listed_price: price_data['listed_price'])
            updated = true
          end
          if trim.hn_price != price_data['HN_price']
            trim.update(hn_price: price_data['HN_price'])
            updated = true
          end
          if trim.tphcm_price != price_data['TPHCM_price']
            trim.update(tphcm_price: price_data['TPHCM_price'])
            updated = true
          end
          if trim.other_price != price_data['other_price']
            trim.update(other_price: price_data['other_price'])
            updated = true
          end
          puts "Updated trim '#{trim.name}' for model '#{model_title_name}'" if updated
        else
          # Nếu không tìm thấy, tạo một bản ghi mới
          Trim.create!(
            model_id: trim_data['model_id'],
            model_brand: trim_data['model_brand'],
            model_title_name: trim_data['model_title_name'],
            name: price_data['name'],
            listed_price: price_data['listed_price'],
            hn_price: price_data['HN_price'],
            tphcm_price: price_data['TPHCM_price'],
            other_price: price_data['other_price']
          )
          puts "Created new trim '#{price_data['name']}' for model '#{model_title_name}'"
        end
      end
    end

    puts 'Data updated successfully!'
  end

  desc 'Update autofun_data from JSON to table'
  task daihatsu_update: :environment do
    daihatsu_model_data = File.read('/home/hth/Final_project/db_json/daihatsu_trims.json')
    data = JSON.parse(daihatsu_model_data)

    brand_name = data["brand_name"]
    models = data["models"]

    brand = Brand.find_by(brand_name: brand_name)
    unless brand
      puts "Brand '#{brand_name}' not found. Import aborted."
      next
    end

    models.each do |model_data|

      segment = Segment.find_or_create_by(segment_name: model_data["segment"])
      type = Type.find_or_create_by(type_name: model_data["type_info"])
      model = Model.find_or_initialize_by(model_brand: brand.brand_name, model_title_name: model_data["model_name"])
      model.segment = segment
      model.type = type
      model.brand = brand
      model.model_price = model_data["model_price"]
      model.model_main_pic = model_data["model_image"]
      model.model_year = model_data["model_year"]
      model.model_seat = model_data["model_seat"]
      model.model_engine = model_data["model_engine"]
      model.model_power = model_data["model_power"]
      model.model_torque = model_data["model_torque"]
      model.model_gearbox = model_data["model_gearbox"]
      model.model_source = "Nhập khẩu"
      model.model_segment = model_data["segment"]
      model.model_type = model_data["type_info"]
      model.save

      model_data["trims"].each do |trim_data|
        trim = Trim.find_or_initialize_by(name: trim_data["trim_name"], model_brand: model.model_brand)

        # Nếu trim mới, xây dựng và lưu các thông tin chi tiết
        if trim.new_record?
          trim.listed_price = trim_data["trim_price"]
          trim.model = model
          trim.save

          engine_transmissions = trim.build_engine_transmission(
            engine_type: trim_data["trim_engine"],
            power: trim_data["trim_power"],
            torque: trim_data["trim_torque"],
            gearbox: trim_data["trim_gearbox"],
            fuel_type: trim_data["trim_fuel_type"],
            fuel_consumption: trim_data["trim_fuel_consumption"]
          )

          if engine_transmissions.save
            puts "Engine transmission saved successfully"
          else
            puts "Failed to save engine transmission: #{engine_transmissions.errors.full_messages.join(', ')}"
          end

          size_weights = trim.build_size_weight(
            fuel_tank_capacity: trim_data["trim_fuel_tank_capacity"],
            dimensions: trim_data["trim_dimensions"],
            ground_clearance: trim_data["trim_ground_clearance"],
            cargo_volume: trim_data["trim_cargo_volume"]
          )

          if size_weights.save
            puts "Size weight saved successfully"
          else
            puts "Failed to save size weight: #{size_weights.errors.full_messages.join(', ')}"
          end

          suspension_brakes = trim.build_suspension_brake(
            front_suspension: trim_data["trim_front_suspension"],
            rear_suspension: trim_data["trim_rear_suspension"]
          )

          if suspension_brakes.save
            puts "Suspension brake saved successfully"
          else
            puts "Failed to save suspension brake: #{suspension_brakes.errors.full_messages.join(', ')}"
          end

          exteriors = trim.build_exterior(
            headlight_high_beam: trim_data["trim_headlight_high_beam"],
            tail_lights: trim_data["trim_tail_lights"],
            seat_material: trim_data["trim_seat_material"],
            fog_lights: trim_data["trim_fog_lights"]
          )

          if exteriors.save
            puts "Exterior saved successfully"
          else
            puts "Failed to save exterior: #{exteriors.errors.full_messages.join(', ')}"
          end

          interiors = trim.build_interior(
            apple_carplay_android_auto: trim_data["trim_apple_carplay_android_auto"]
          )

          if interiors.save
            puts "Interior saved successfully"
          else
            puts "Failed to save interior: #{interiors.errors.full_messages.join(', ')}"
          end

          driving_assistances = trim.build_driving_assistance(
            cruise_control: trim_data["trim_cruise_control"]
          )

          if driving_assistances.save
            puts "Driving assistance saved successfully"
          else
            puts "Failed to save driving assistance: #{driving_assistances.errors.full_messages.join(', ')}"
          end

          safety_technologies = trim.build_safety_technology(
            abs_brakes: trim_data["trim_abs_brakes"],
            rear_view_camera: trim_data["trim_rear_view_camera"],
            blind_spot_warning: trim_data["trim_blind_spot_warning"],
            ebd: trim_data["trim_ebd"],
            esp: trim_data["trim_esp"],
            emergency_brake_assist: trim_data["trim_emergency_brake_assist"]
          )

          if safety_technologies.save
            puts "Safety technology saved successfully"
          else
            puts "Failed to save safety technology: #{safety_technologies.errors.full_messages.join(', ')}"
          end
        else
          # Cập nhật giá trim nếu trim đã tồn tại
          trim.update(listed_price: trim_data["trim_price"])
          puts "Trim '#{trim.name}' updated with new price."
        end
      end
    end

    puts 'Data imported successfully!'
  end

  desc 'Update autofun_data from JSON to table'
  task chevrolet_update: :environment do
    chevrolet_model_data = File.read('/home/hth/Final_project/db_json/chevrolet_trims.json')
    data = JSON.parse(chevrolet_model_data)

    brand_name = data["brand_name"]
    models = data["models"]

    brand = Brand.find_by(brand_name: brand_name)
    unless brand
      puts "Brand '#{brand_name}' not found. Import aborted."
      next
    end

    models.each do |model_data|
      segment = Segment.find_or_create_by(segment_name: model_data["segment"])
      type = Type.find_or_create_by(type_name: model_data["type_info"])

      model = Model.find_or_initialize_by(model_brand: brand.brand_name, model_title_name: model_data["model_name"])
      model.segment = segment
      model.type = type
      model.brand = brand
      model.model_price = model_data["model_price"]
      model.model_main_pic = model_data["model_image"]
      model.model_year = model_data["model_year"]
      model.model_seat = model_data["model_seat"]
      model.model_engine = model_data["model_engine"]
      model.model_power = model_data["model_power"]
      model.model_torque = model_data["model_torque"]
      model.model_gearbox = model_data["model_gearbox"]
      model.model_source = "Nhập khẩu"
      model.model_segment = model_data["segment"]
      model.model_type = model_data["type_info"]
      model.save

      model_data["trims"].each do |trim_data|
        trim = Trim.find_or_initialize_by(name: trim_data["trim_name"], model_brand: model.model_brand)

        # Nếu trim mới, xây dựng và lưu các thông tin chi tiết
        if trim.new_record?
          trim.listed_price = trim_data["trim_price"]
          trim.model = model
          trim.save

          engine_transmissions = trim.build_engine_transmission(
            engine_type: trim_data["trim_engine"],
            power: trim_data["trim_power"],
            torque: trim_data["trim_torque"],
            gearbox: trim_data["trim_gearbox"],
            fuel_type: trim_data["trim_fuel_type"],
            fuel_consumption: trim_data["trim_fuel_consumption"]
          )

          if engine_transmissions.save
            puts "Engine transmission saved successfully"
          else
            puts "Failed to save engine transmission: #{engine_transmissions.errors.full_messages.join(', ')}"
          end

          size_weights = trim.build_size_weight(
            fuel_tank_capacity: trim_data["trim_fuel_tank_capacity"],
            dimensions: trim_data["trim_dimensions"],
            ground_clearance: trim_data["trim_ground_clearance"],
            cargo_volume: trim_data["trim_cargo_volume"]
          )

          if size_weights.save
            puts "Size weight saved successfully"
          else
            puts "Failed to save size weight: #{size_weights.errors.full_messages.join(', ')}"
          end

          suspension_brakes = trim.build_suspension_brake(
            front_suspension: trim_data["trim_front_suspension"],
            rear_suspension: trim_data["trim_rear_suspension"]
          )

          if suspension_brakes.save
            puts "Suspension brake saved successfully"
          else
            puts "Failed to save suspension brake: #{suspension_brakes.errors.full_messages.join(', ')}"
          end

          exteriors = trim.build_exterior(
            headlight_high_beam: trim_data["trim_headlight_high_beam"],
            tail_lights: trim_data["trim_tail_lights"],
            seat_material: trim_data["trim_seat_material"],
            fog_lights: trim_data["trim_fog_lights"]
          )

          if exteriors.save
            puts "Exterior saved successfully"
          else
            puts "Failed to save exterior: #{exteriors.errors.full_messages.join(', ')}"
          end

          interiors = trim.build_interior(
            apple_carplay_android_auto: trim_data["trim_apple_carplay_android_auto"]
          )

          if interiors.save
            puts "Interior saved successfully"
          else
            puts "Failed to save interior: #{interiors.errors.full_messages.join(', ')}"
          end

          driving_assistances = trim.build_driving_assistance(
            cruise_control: trim_data["trim_cruise_control"]
          )

          if driving_assistances.save
            puts "Driving assistance saved successfully"
          else
            puts "Failed to save driving assistance: #{driving_assistances.errors.full_messages.join(', ')}"
          end

          safety_technologies = trim.build_safety_technology(
            abs_brakes: trim_data["trim_abs_brakes"],
            rear_view_camera: trim_data["trim_rear_view_camera"],
            blind_spot_warning: trim_data["trim_blind_spot_warning"],
            ebd: trim_data["trim_ebd"],
            esp: trim_data["trim_esp"],
            emergency_brake_assist: trim_data["trim_emergency_brake_assist"]
          )

          if safety_technologies.save
            puts "Safety technology saved successfully"
          else
            puts "Failed to save safety technology: #{safety_technologies.errors.full_messages.join(', ')}"
          end
        else
          # Cập nhật giá trim nếu trim đã tồn tại
          trim.update(listed_price: trim_data["trim_price"])
          puts "Trim '#{trim.name}' updated with new price."
        end
      end
    end

    puts 'Data imported successfully!'
  end

  desc 'Update autofun_data from JSON to table'
  task cadillac_update: :environment do
    cadillac_model_data = File.read('/home/hth/Final_project/db_json/cadillac_trims.json')
    data = JSON.parse(cadillac_model_data)

    brand_name = data["brand_name"]
    models = data["models"]

    brand = Brand.find_by(brand_name: brand_name)
    unless brand
      puts "Brand '#{brand_name}' not found. Import aborted."
      next
    end

    models.each do |model_data|
      
      
      segment = Segment.find_or_create_by(segment_name: model_data["segment"])
      type = Type.find_or_create_by(type_name: model_data["type_info"])

      model = Model.find_or_initialize_by(model_brand: brand.brand_name, model_title_name: model_data["model_name"])
      model.segment = segment
      model.type = type
      model.brand = brand
      model.model_price = model_data["model_price"]
      model.model_main_pic = model_data["model_image"]
      model.model_year = model_data["model_year"]
      model.model_seat = model_data["model_seat"]
      model.model_engine = model_data["model_engine"]
      model.model_power = model_data["model_power"]
      model.model_torque = model_data["model_torque"]
      model.model_gearbox = model_data["model_gearbox"]
      model.model_source = "Nhập khẩu"
      model.model_segment = model_data["segment"]
      model.model_type = model_data["type_info"]
      model.save

      model_data["trims"].each do |trim_data|
        trim = Trim.find_or_initialize_by(name: trim_data["trim_name"], model_brand: model.model_brand)

        # Nếu trim mới, xây dựng và lưu các thông tin chi tiết
        if trim.new_record?
          trim.listed_price = trim_data["trim_price"]
          trim.model = model
          trim.save

          engine_transmissions = trim.build_engine_transmission(
            engine_type: trim_data["trim_engine"],
            power: trim_data["trim_power"],
            torque: trim_data["trim_torque"],
            gearbox: trim_data["trim_gearbox"],
            fuel_type: trim_data["trim_fuel_type"],
            fuel_consumption: trim_data["trim_fuel_consumption"]
          )

          if engine_transmissions.save
            puts "Engine transmission saved successfully"
          else
            puts "Failed to save engine transmission: #{engine_transmissions.errors.full_messages.join(', ')}"
          end

          size_weights = trim.build_size_weight(
            fuel_tank_capacity: trim_data["trim_fuel_tank_capacity"],
            dimensions: trim_data["trim_dimensions"],
            ground_clearance: trim_data["trim_ground_clearance"],
            cargo_volume: trim_data["trim_cargo_volume"]
          )

          if size_weights.save
            puts "Size weight saved successfully"
          else
            puts "Failed to save size weight: #{size_weights.errors.full_messages.join(', ')}"
          end

          suspension_brakes = trim.build_suspension_brake(
            front_suspension: trim_data["trim_front_suspension"],
            rear_suspension: trim_data["trim_rear_suspension"]
          )

          if suspension_brakes.save
            puts "Suspension brake saved successfully"
          else
            puts "Failed to save suspension brake: #{suspension_brakes.errors.full_messages.join(', ')}"
          end

          exteriors = trim.build_exterior(
            headlight_high_beam: trim_data["trim_headlight_high_beam"],
            tail_lights: trim_data["trim_tail_lights"],
            seat_material: trim_data["trim_seat_material"],
            fog_lights: trim_data["trim_fog_lights"]
          )

          if exteriors.save
            puts "Exterior saved successfully"
          else
            puts "Failed to save exterior: #{exteriors.errors.full_messages.join(', ')}"
          end

          interiors = trim.build_interior(
            apple_carplay_android_auto: trim_data["trim_apple_carplay_android_auto"]
          )

          if interiors.save
            puts "Interior saved successfully"
          else
            puts "Failed to save interior: #{interiors.errors.full_messages.join(', ')}"
          end

          driving_assistances = trim.build_driving_assistance(
            cruise_control: trim_data["trim_cruise_control"]
          )

          if driving_assistances.save
            puts "Driving assistance saved successfully"
          else
            puts "Failed to save driving assistance: #{driving_assistances.errors.full_messages.join(', ')}"
          end

          safety_technologies = trim.build_safety_technology(
            abs_brakes: trim_data["trim_abs_brakes"],
            rear_view_camera: trim_data["trim_rear_view_camera"],
            blind_spot_warning: trim_data["trim_blind_spot_warning"],
            ebd: trim_data["trim_ebd"],
            esp: trim_data["trim_esp"],
            emergency_brake_assist: trim_data["trim_emergency_brake_assist"]
          )

          if safety_technologies.save
            puts "Safety technology saved successfully"
          else
            puts "Failed to save safety technology: #{safety_technologies.errors.full_messages.join(', ')}"
          end
        else
          # Cập nhật giá trim nếu trim đã tồn tại
          trim.update(listed_price: trim_data["trim_price"])
          puts "Trim '#{trim.name}' updated with new price."
        end
      end
    end

    puts 'Data imported successfully!'
  end
end
