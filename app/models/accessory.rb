class Accessory < ApplicationRecord
  def self.ransackable_associations(auth_object = nil)
    ["shopping_cart"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "price", "product", "quantity", "shopping_cart_id", "updated_at"]
  end

  has_many :combined_accessory
  has_many :shopping_carts, through: :combined_accessories
  has_many :orders, through: :combined_accessories

  validates :product, presence: true
  validates :price, presence: true, numericality: {only_integer: true}
  validates :quantity, presence: true, numericality: {only_integer: true}
end
