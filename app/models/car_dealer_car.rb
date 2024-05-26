class CarDealerCar < ApplicationRecord
    belongs_to :cardealer
    belongs_to :model
    has_many :inquiries

    delegate :model_brand, to: :model
end
