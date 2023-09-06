class Mentor < ApplicationRecord
  belongs_to :student
  has_many :work_histories
  has_many :bookings
  has_many :gallery_images, dependent: :destroy
end
