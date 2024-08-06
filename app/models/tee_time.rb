class TeeTime < ApplicationRecord
  belongs_to :golf_course
  has_many :orders
  has_one :shopping_carts


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "golf_course_id", "id", "id_value", "price", "start_time", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["golf_course", "shopping_carts"]
  end

  validates :start_time, presence: true
  validates :price, presence: true
  validates :golf_course_id, presence: true
end
