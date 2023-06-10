module Types
  class CourseType < BaseObject
    field :id, ID, null: false
    field :course_name, String, null: false
    field :description, String, null: true
    field :course_cover, String, null: true
    field :status, String, null: true
    field :course_cover_url, String, null: true
    def course_cover_url
      object.course_cover_url
    end

  end
end
