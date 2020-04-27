
class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

  def self.encode(payload, exp = 48.hours.from_now)
    payload[:exp] = exp.to_i
    payload.reverse_merge!(meta)
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end

  # Validates the payload hash for expiration and meta claims
  def self.valid_payload(payload)
    return false if expired(payload) || payload['iss'] != meta[:iss] || payload['aud'] != meta[:aud]
    true
  end

  # Default options to be encoded in the token
  def self.meta
    {
      exp: 7.days.from_now.to_i,
      iss: ENV['APP_JWT_ISSUER'],
      aud: ENV['APP_JWT_AUD'],
    }
  end

  # Validates if the token is expired by exp parameter
  def self.expired(payload)
    Time.at(payload['exp']) < Time.now
  end
end
