class CarDealerEmployee < ApplicationRecord
    belongs_to :cardealer
    enum role: { "Quản Lý": 1, "Chuyên viên tư vấn ": 2 }
    enum gender: { male: 1, female: 2 }
end
