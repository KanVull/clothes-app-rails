class UsersMailerPreview < ActionMailer::Preview
  def user_activation
    user = User.first
    user.activation_token = Token.new_token
    UsersMailer.user_activation(user)
  end

  def password_reset
    user = User.first
    user.reset_token = Token.new_token
    UsersMailer.password_reset(user)
  end
end
