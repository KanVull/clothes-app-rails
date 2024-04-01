class JwtService
  SECRET_KEY = Rails.application.credentials.dig(:jwt, :secret)

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY, "HS256")
  end

  def self.decode(token)
    JWT.decode(token, SECRET_KEY, true, algorithm: "HS256")
  end
end
