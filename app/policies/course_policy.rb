class CoursePolicy < ApplicationPolicy
  def update?
    user.id == record.author_id
  end
end
