class Verification < ApplicationRecord
  validates :email, presence: true
  validates :code, presence: true, uniqueness: true
  validates :expires_at, presence: true

  # Scope to check if a code is still valid
  scope :valid, -> { where("expires_at >= ?", Time.current) }

  # Scope to check if a code is expired
  scope :expired, -> { where("expires_at < ?", Time.current) }

  # Generate a new code
  def self.generate_code(email)
    create(email: email, code: SecureRandom.hex(3), expires_at: 5.minutes.from_now)
  end

  # Check if the code is valid
  def self.valid_code?(email, code)
    Verification.valid.exists?(email: email, code: code)
  end

  # Check if the code is expired
  def self.expired_code?(email, code)
    Verification.expired.exists?(email: email, code: code)
  end
end
