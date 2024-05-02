class ApplicantMailer < ApplicationMailer
  default from: 'admin@example.com'
  
  def contact_applicant(subject, content, applicant_name, applicant_email)
    @content = content
    @applicant_name = applicant_name
    mail(:to => applicant_email, :subject => subject)
  end
end