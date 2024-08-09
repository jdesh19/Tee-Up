class ShoppingCart < ApplicationRecord
  belongs_to :user
  belongs_to :tee_time
  has_many :combined_accessories
  has_many :accessories, through: :combined_accessories

  def total_price
    tee_time_price = tee_time ? tee_time.price / 100.0 : 0
    accessory_prices = combined_accessories.sum do |combined_accessory|
      (combined_accessory.quantity * combined_accessory.price) / 100.0
    end
    tee_time_price + accessory_prices
  end

  def tax_rate
    user.province.total_tax_rate
  end

  def total_with_tax
    total = total_price
    total * (1 + tax_rate)
  end


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "updated_at", "user_id"]
  end

  validates :user_id, presence: true, numericality: { only_integer: true }
end
