class CombinedAccessory < ApplicationRecord
  belongs_to :accessory
  belongs_to :order
  belongs_to :shopping_cart
end
