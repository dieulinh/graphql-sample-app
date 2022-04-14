class CoursePolicy < ApplicationPolicy
  def update?
    user.id == record.author_id || user.roles.include?('admin')
  end
end
