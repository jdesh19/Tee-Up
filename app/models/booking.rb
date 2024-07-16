class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tee_time

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "player_count", "tee_time_id", "updated_at", "user_id"]
  end

  validates :user_id, presence: true
  validates :tee_time_id, presence: true
  validates :player_count, presence: true
  validates :accessory_id, numericality: {only_integer: true}
end
