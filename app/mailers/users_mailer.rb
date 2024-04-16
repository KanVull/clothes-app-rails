class UsersMailer < ApplicationMailer
  def user_activation(user)
    @link = edit_user_activation_url(user.activation_token, email: user.email)

    mail(to: user.email, subject: "Store - Account activation")
  end

  def password_reset
    mail(to: user.email, subject: "Store - Password recovery")
  end
end
