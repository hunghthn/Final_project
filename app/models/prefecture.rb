# app/models/prefecture.rb
class Prefecture < ApplicationRecord
    # enum prefecture_type: { tinh: 1, thanh_pho_trung_uong: 2 }
    has_many :districts
end
