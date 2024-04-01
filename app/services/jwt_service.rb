class JwtService
  SECRET_KEY = ENV["JWT_SECRET"]

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY, "HS256")
  end

  def self.decode(token)
    JWT.decode(token, SECRET_KEY, true, algorithm: "HS256")
  end
end
