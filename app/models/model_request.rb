class ModelRequest < ApplicationRecord
    belongs_to :cardealer
  
    validates :brand_name, presence: true
    validates :model_name, presence: true
    validates :model_year, presence: true
  end
  