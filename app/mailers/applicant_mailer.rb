# app/mailers/applicant_mailer.rb

class ApplicantMailer < ApplicationMailer
  def notification(applicant, message)
    @applicant = applicant
    @message = message

    mail(to: @applicant.email, subject: 'Notification from Sherman Buildings') do |format|
      format.text { render plain: @message }
      format.html { render 'notification' }  # We'll create a corresponding HTML template
    end
  end
end

