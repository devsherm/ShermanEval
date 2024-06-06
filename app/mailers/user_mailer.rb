class UserMailer < ApplicationMailer
  default from: 'sherman_eval@example.com'

  def custom_email(user, subject, message)
    @user = user
    @message = message
    mail(to: @user.email, subject: subject)
  end
end
