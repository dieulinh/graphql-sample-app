class GalleryImage < ApplicationRecord
  mount_uploader :image, AttachmentUploader
  belongs_to :mentor
  validates_presence_of :title
end
