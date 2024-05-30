class Inquiry < ApplicationRecord
    belongs_to :car_dealer_car
    belongs_to :user, optional: true
end
