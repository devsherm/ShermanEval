# app/mailers/applicant_mailer.rb

class ApplicantMailer < ApplicationMailer
  def notification(applicant, message)
    @applicant = applicant
    @message = message

    mail(to: @applicant.email, subject: 'Notification from Sherman Buildings')
  end
end
