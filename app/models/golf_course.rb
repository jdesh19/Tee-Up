class GolfCourse < ApplicationRecord
  has_many :tee_times

  def self.ransackable_associations(auth_object = nil)
    ["tee_times"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "holes", "id", "id_value", "location", "name", "updated_at"]
  end

  validates :name, presence: true
  validates :holes, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :location, presence: true
end
