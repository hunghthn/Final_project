# frozen_string_literal: true

class Model < ApplicationRecord
  belongs_to :brand
  belongs_to :segment
  belongs_to :type
  has_many :trims, dependent: :destroy
  has_many :sales
  has_many :model_detail, dependent: :destroy
  
  before_save :extract_price_ranges
  before_save :assign_brand_id
  before_save :assign_type_id
  before_save :assign_segment_id
  before_save :extract_name_and_year

  def self.ransackable_associations(_auth_object = nil)
    %w[brand segment type]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id model_brand model_drive_system model_engine model_gearbox model_main_pic
       model_power model_price model_price_max model_price_min model_seat model_segment model_source model_title_name model_torque model_type updated_at brand_id type_id segment_id]
  end

  def full_model_name
    "#{model_brand} #{model_name_main}"
  end
  
  private

  def extract_price_ranges
    if model_price != 'Hãng không công bố'
      numeric_values = model_price.scan(/\d+/).map(&:to_i)

      case numeric_values.size
      when 1
        if numeric_values[0] >= 100
          self.model_price_min = numeric_values[0]
          self.model_price_max = numeric_values[0]
        else
          self.model_price_min = numeric_values[0] * 1000
          self.model_price_max = numeric_values[0] * 1000
        end
      when 2
        if numeric_values[0] > 100
          self.model_price_min = numeric_values[0]
          self.model_price_max = if numeric_values[1] > 100
                                   numeric_values[1]
                                 else
                                   numeric_values[1] * 1000
                                 end
        elsif numeric_values[1] > 20
          self.model_price_min = numeric_values[0] * 1000 + numeric_values[1]
          self.model_price_max = numeric_values[0] * 1000 + numeric_values[1]
        else
          self.model_price_min = numeric_values[0] * 1000
          self.model_price_max = numeric_values[1] * 1000
        end
      when 3
        if numeric_values[0] > 100
          self.model_price_min = numeric_values[0]
          self.model_price_max = numeric_values[1] * 1000 + numeric_values[2]
        elsif numeric_values[1] > 20
          self.model_price_min = numeric_values[0] * 1000 + numeric_values[1]
          self.model_price_max = numeric_values[2] * 1000
        else
          self.model_price_min = numeric_values[0] * 1000
          self.model_price_max = numeric_values[1] * 1000 + numeric_values[2]
        end
      else
        self.model_price_min = numeric_values[0] * 1000 + numeric_values[1]
        self.model_price_max = numeric_values[2] * 1000 + numeric_values[3]
      end
    else
      self.model_price_min = nil
      self.model_price_max = nil
    end
  end

  def assign_brand_id
    # Kiểm tra xem `model_brand` có giá trị hay không
    return unless model_brand.present?

    # Tìm brand tương ứng với model_brand
    found_brand = Brand.find_by(brand_name: model_brand)

    # Kiểm tra xem có brand nào tìm thấy không
    if found_brand
      # Gán id của brand cho model_brand
      self.brand_id = found_brand.id
    else
      # Nếu không tìm thấy, có thể xử lý theo yêu cầu của bạn,
      # ví dụ: tạo mới một brand mới
      new_brand = Brand.create(brand_name: model_brand)
      self.brand_id = new_brand.id
    end
  end

  def assign_segment_id
    # Kiểm tra xem `model_brand` có giá trị hay không
    return unless model_segment.present?

    # Tìm brand tương ứng với model_brand
    found_segment = Segment.find_by(segment_name: model_segment)

    # Kiểm tra xem có brand nào tìm thấy không
    if found_segment
      # Gán id của brand cho model_brand
      self.segment_id = found_segment.id
    else
      # Nếu không tìm thấy, có thể xử lý theo yêu cầu của bạn,
      # ví dụ: tạo mới một brand mới
      new_semgent = Segment.create(segment_name: model_segment)
      self.segment_id = new_semgent.id
    end
  end

  def assign_type_id
    return unless model_type.present?

    found_type = Type.find_by(type_name: model_type)

    # Kiểm tra xem có brand nào tìm thấy không
    if found_type
      # Gán id của brand cho model_brand
      self.type_id = found_type.id
    else
      # Nếu không tìm thấy, có thể xử lý theo yêu cầu của bạn,
      # ví dụ: tạo mới một brand mới
      new_type = Type.create(type_name: model_type)
      self.type_id = new_type.id
    end
  end

  def extract_name_and_year
    if model_title_name.present?
      # Sử dụng biểu thức chính quy để tìm kiếm tên và năm trong `model_title_name`
      match_data = model_title_name.match(/^(.*?) (\d{4})$/)

      # Nếu có kết quả từ việc tìm kiếm, cập nhật giá trị
      if match_data
        self.model_name_main = match_data[1].strip # Lấy tên và xoá dấu cách thừa
        self.model_year = match_data[2].to_i
      else
        # Nếu không tìm thấy năm, chỉ cập nhật tên chính
        self.model_name_main = model_title_name
      end
    end
  end
end
