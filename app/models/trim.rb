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

    def extract_price
      if listed_price != 'Hãng không công bố'
        numeric_values = listed_price.scan(/\d+/).map(&:to_i)
  
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
