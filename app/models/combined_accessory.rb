class CombinedAccessory < ApplicationRecord
  has_many :accessories
  belongs_to :order
  belongs_to :shopping_cart
end
