class Province < ApplicationRecord
  has_many :users

  validates :province, presence: true, uniqueness: true
  validates :tax_rate, presence: true, numericality: { less_than_or_equal_to: 1 }
end
