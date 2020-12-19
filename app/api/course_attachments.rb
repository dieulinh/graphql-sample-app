class CourseAttachments < Grape::API
  namespace :course_attachments do
    params do
      requires :file, type: File
    end
    post '/' do
      attachment = CourseAttachment.new
      attachment.avatar = params[:file]
      attachment.save
      present attachment
    end
  end
end
