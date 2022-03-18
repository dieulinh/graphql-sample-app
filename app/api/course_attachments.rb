class CourseAttachments < Grape::API
  include Shared::AuthorizationKit
  namespace :course_attachments do
    params do
      requires :file, type: File
    end
    post '/' do
      authenticate_user!
      attachment = CourseAttachment.new
      attachment.avatar = params[:file]
      attachment.save
      present attachment
    end
  end
end
