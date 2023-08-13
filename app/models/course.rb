class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :course_name, use: :slugged
  default_scope { order('updated_at desc') }
  validates :course_name, :description, presence: true
  enum status: {
    pending: 0,
    published: 1,
    archived: 2
  }
  has_many :posts, dependent: :destroy
  has_one_attached :course_cover, dependent: :destroy
  def course_cover_url
    return nil unless course_cover.attached?
    Rails.application.routes.url_helpers.rails_representation_url(course_cover.variant(resize: "500x400").processed, only_path: true)
    #course_cover.service_url
  end
  def to_param
    slug
  end
end
