class User < ApplicationRecord
  attr_accessor :activation_token
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

  def send_activation_email
    UsersMailer.user_activation(self).deliver_now
  end

  private

  def create_activation_digest
    self.activation_token = Token.new_token
    self.activation_digest = Token.digest(self.activation_token)
  end
end
