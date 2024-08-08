class CombinedAccessory < ApplicationRecord
  belongs_to :accessory
  belongs_to :order, optional: true
  belongs_to :shopping_cart
end
