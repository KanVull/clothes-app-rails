class User < ApplicationRecord
  attr_accessor :activation_token, :reset_token
  has_many :orders
  has_one :cart, dependent: :destroy
  has_secure_password

  validates :email, presence: true, uniqueness: true

  before_create :create_activation_digest

  def admin?
    is_admin
  end

  def activated?
    activated
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def update_activation_digest
    self.activation_token = Token.new_token
    update_attribute(:activation_digest, Token.digest(self.activation_token))
  end

  def create_reset_password_digest
    self.reset_token = Token.new_token
    update_attribute(:reset_password_digest,  Token.digest(reset_token))
    update_attribute(:reset_password_sent_at, Time.zone.now)
  end

  def password_reset_expired?
    reset_password_sent_at < 2.hours.ago
  end

  def send_activation_email
    UsersMailer.user_activation(self).deliver_now
  end

  def send_password_reset_email
    UsersMailer.password_reset(self).deliver_now
  end

  private

  def create_activation_digest
    self.activation_token = Token.new_token
    self.activation_digest = Token.digest(self.activation_token)
  end
end
