# app/models/engine_transmission.rb
class SafetyTechnology < ApplicationRecord
    belongs_to :trim

    def convert_airbag_count_to_float
      return nil if airbag_count.nil?
      airbag_count.gsub(',', '.').to_f
    end
  end
  