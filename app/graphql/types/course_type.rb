module Types
  class CourseType < BaseObject
    field :id, ID, null: false
    field :course_name, String, null: false
    field :description, String, null: true
    field :course_cover, String, null: true
    field :course_cover_url, String, null: true
    def course_cover_url
      return nil unless object.course_cover.attached?
      object.course_cover.service_url
    end

  end
end
