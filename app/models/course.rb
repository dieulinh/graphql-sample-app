class Course < ApplicationRecord
  default_scope { where(status: 'published').order('updated_at desc')}
  enum status: {
    pending: 0,
    published: 1,
    archived: 2
  }
  has_many :posts, dependent: :destroy
  has_one_attached :course_cover, dependent: :destroy
  def course_cover_url
    return nil unless course_cover.attached?
    course_cover.service_url
  end
end
