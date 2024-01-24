# app/models/trim.rb
class Trim < ApplicationRecord
    belongs_to :model
    has_one :engine_transmission
    has_one :size_weight
    has_one :suspension_brake
    has_one :exterior
    has_one :interior
    has_one :driving_assistance
    has_one :safety_technology
    # Các khai báo khác về mô hình
  end
