class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tee_time

  validates :user_id, presence: true
  validates :tee_time_id, presence: true
  validates :player_count, presence: true
  validates :accessory_id, numericality: {only_integer: true}
end
