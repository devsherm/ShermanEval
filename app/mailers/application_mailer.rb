class ApplicationMailer < ActionMailer::Base
  default from: "dont-reply@shermanapplicants.com"
  layout "mailer"

  def send_email(email, subject, body)
    mail(to: email, subject:, body:)
  end
end
