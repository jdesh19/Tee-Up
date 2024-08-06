class ShoppingCart < ApplicationRecord
  belongs_to :user
  belongs_to :tee_time
  has_many :combined_accessories
  has_many :accessories, through: :combined_accessories


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "updated_at", "user_id"]
  end

  validates :user_id, presence: true
end
