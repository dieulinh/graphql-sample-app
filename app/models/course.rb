class Course < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_one_attached :course_cover, dependent: :destroy
  def course_cover_url
    return nil unless course_cover.attached?
    course_cover.service_url
  end
end
