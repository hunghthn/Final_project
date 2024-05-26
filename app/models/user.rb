class User < ApplicationRecord
  has_secure_password

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  enum gender: { male: 0, female: 1, other: 2 }

  before_validation :convert_gender

  private

  def convert_gender
    self.gender = gender.to_i if gender.is_a?(String)
  end
end
