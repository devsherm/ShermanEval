# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'sherman@no-reply.com'
  layout 'mailer'

  def send_applicant_mail(params)
    applicant = Applicant.find(params[:applicant_id])
    subject = params[:subject]
    body = params[:body]

    mail(
      to: applicant.email,
      body:,
      content_type: 'text/html',
      subject:
    )
  end
end
