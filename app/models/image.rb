class Image < ApplicationRecord
    belongs_to :model
    validates :image_url, presence: true
  end