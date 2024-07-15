class User < ApplicationRecord
  has_many :bookings
  has_one :shopping_cart

  validates :full_name, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :address, presence: true
end
