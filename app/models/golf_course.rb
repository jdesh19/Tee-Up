class GolfCourse < ApplicationRecord
  has_many :tee_times

  validates :name, presence: true
  validates :holes, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :location, presence: true
end
