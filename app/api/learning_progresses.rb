class LearningProgresses < Grape::API
  include Shared::AuthorizationKit
  namespace :learning_progresses do
    params do
      requires :course_id, type: Integer
      requires :student_id, type: Integer
      requires :post_id, type: Integer
      optional :completed, type: Boolean
    end
    post '/' do
      authenticate_user!
      learn = LearningProgress.find_or_create_by!(params.except(:completed))
      course = Course.find(params[:course_id])
      posts = course.posts
      present posts
    end

  end
end