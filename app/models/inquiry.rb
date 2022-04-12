class Inquiry < ApplicationRecord
  validates :ip_address, presence: true
end