class Order < ApplicationRecord
  has_many :accessories, through: :combined_accessories

end
