class Order < ApplicationRecord
  has_many :combined_accessories, :through => :accessory

end
