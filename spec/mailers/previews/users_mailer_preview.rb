class UsersMailerPreview < ActionMailer::Preview
  def user_activation
    user = User.first
    user.activation_token = Token.new_token
    UsersMailer.user_activation(user)
  end

  def password_reset
    user = User.first
    UserMailer.password_reset(user)
  end
end
