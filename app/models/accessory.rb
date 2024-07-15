class Accessory < ApplicationRecord
  belongs_to :shopping_cart

  validates :product, presence: true
  validates :price, presence: true, numericality: {only_integer: true}
  validates :quantity, presence: true, numericality: {only_integer: true}
end
