class CourseAttachment < ApplicationRecord
  mount_uploader :avatar, AttachmentUploader
end