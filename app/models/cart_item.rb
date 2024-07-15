class CartItem < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :tee_time
  belongs_to :accessory

  validates :shopping_cart_id, presence: true
  validates :tee_time_id, presence: true, numericality: {only_integer: true}
  validates :accessory_id, numericality: {only_integer: true}
  validates :price, numericality: {only_integer: true}

end
