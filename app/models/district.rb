class District < ApplicationRecord
  belongs_to :prefecture
  has_many :cardealers
end
