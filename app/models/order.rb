class Order < ApplicationRecord
  belongs_to :user
  belongs_to :tee_time
  has_many :combined_accessories

  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :tee_time_id, presence: true, numericality: { only_integer: true }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
