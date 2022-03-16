class AttachedPhoto < ApplicationRecord
  mount_uploader :photo, AttachmentUploader
end