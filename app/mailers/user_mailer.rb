class UserMailer < ApplicationMailer
  def send_questionnaire_email(user, cc, message)
    @user = user
    @cc = cc
    @message = message

    mail(from: 'ShermanEval@demo.com', to: @user.email, cc: @cc, subject: 'Your Questionnaire Response')
  end
end