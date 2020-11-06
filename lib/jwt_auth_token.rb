class JwtAuthToken
  # Encode a hash in a json web token
  require 'exceptions'
  require 'jwt'

  module Constants
    DEFAULT_TTL = 1.month
    ENCRYPTION_TYPE = 'HS256'
  end


  def self.encode(payload, ttl_in_seconds = Constants::DEFAULT_TTL)
    payload[:exp] = ttl_in_seconds.seconds.from_now.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base, Constants::ENCRYPTION_TYPE)
  end

  # Decode a token and return the payload inside
  # If will throw an error if expired or invalid or invalid audience. See the docs for the JWT gem.
  def self.decode(token, leeway = nil)
    decoded = JWT.decode(
      token,
      Rails.application.secrets.secret_key_base,
      {leeway: leeway, algorithm: Constants::ENCRYPTION_TYPE}
    )
    HashWithIndifferentAccess.new(decoded[0])
  rescue JWT::ExpiredSignature
    raise Exceptions::AuthenticationTimeoutError
  rescue JWT::VerificationError, JWT::DecodeError
    raise Exceptions::NotAuthenticatedError
  end
end