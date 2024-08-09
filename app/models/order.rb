class Order < ApplicationRecord
  belongs_to :user
  belongs_to :tee_time
  has_many :combined_accessories


end
