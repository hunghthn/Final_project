class User < ApplicationRecord
  has_secure_password
  has_many :inquiries
  belongs_to :cardealer, optional: true

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  enum gender: { male: 0, female: 1, other: 2 }
  enum role: { normal_user: 0, admin_car_dealer: 1 }

  has_many :reviews


  def admin_car_dealer?
    role == 'admin_car_dealer'
  end

  def self.vietnamese_genders
    {
      'Nam' => 'male',
      'Nữ' => 'female',
      'Khác' => 'other'
    }
  end
  

end
