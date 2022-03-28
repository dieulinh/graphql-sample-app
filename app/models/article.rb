class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many_attached :photos
end