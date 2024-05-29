class CarDealerCar < ApplicationRecord
    belongs_to :cardealer
    belongs_to :model
    has_many :inquiries

    delegate :model_brand, to: :model

    def extract_price
        if cardealer_price != 'Hãng không công bố'
          numeric_values = cardealer_price.scan(/\d+/).map(&:to_i)
    
          case numeric_values.size
          when 1
            if numeric_values[0] >= 100
              price = numeric_values[0]
              return price
            else
              price = numeric_values[0] * 1000
              return price
            end
          when 2
            price = numeric_values[0] * 1000 + numeric_values[1]
            return price
            end
        else
          return nil
        end
    end
end
