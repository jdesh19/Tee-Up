class TeeTime < ApplicationRecord
  belongs_to :golf_course
  has_one :booking
  has_many :shopping_carts

  validates :start_time, presence: true
  validates :price, presence: true
  validates :golf_course_id, presence: true
end
