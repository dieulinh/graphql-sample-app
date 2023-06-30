class Mentor < ApplicationRecord
  # belongs_to :student
  paginates_per 2
end
