require 'jwt'

# service to encrypt and decrypt jwt token
class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base).first
  rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError => e
    nil
  end
end
