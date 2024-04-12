class LearningProgress < ApplicationRecord
  belongs_to :course
  belongs_to :student
  belongs_to :post
end
