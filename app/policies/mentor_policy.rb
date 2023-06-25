class MentorPolicy < ApplicationPolicy
  def update?
    user.id == record.user_id
  end
end