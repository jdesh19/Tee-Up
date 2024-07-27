class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :combined_accessories, :through => :accessory
  has_many :tee_times

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "updated_at", "user_id"]
  end

  validates :user_id, presence: true
end
