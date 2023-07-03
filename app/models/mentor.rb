class Mentor < ApplicationRecord
  # belongs_to :student
  has_many :work_histories
  paginates_per 2
end
