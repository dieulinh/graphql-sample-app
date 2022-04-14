class Student < ApplicationRecord
  ROLE_LIST = %w(admin author instructor subscriber).freeze

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  def generate_password_token!
   self.reset_password_token = generate_token
   self.reset_password_sent_at = Time.now.utc
   save!
  end

  def author?
    roles.include?('author')
  end
  def admin?
    roles.include?('admin')
  end
  def instructor?
    roles.include?('instructor')
  end
  def password_token_valid?
   (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
   self.reset_password_token = nil
   self.password = password
   save!
  end

  private

  def generate_token
   SecureRandom.hex(10)
  end
end
