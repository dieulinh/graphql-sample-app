class Post < ApplicationRecord
  belongs_to :course
  validates :title, presence: true, length: { minimum: 5 }
end
