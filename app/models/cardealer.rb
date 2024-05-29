class Cardealer < ApplicationRecord
    belongs_to :district
    has_many :car_dealer_employees
    has_many :car_dealer_cars
    has_many :inquiries, through: :car_dealer_cars
    has_many :users
end
