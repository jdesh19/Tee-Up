class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :accessories
  has_many :tee_times

  validates :user_id, presence: true
end
