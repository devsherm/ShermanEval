class ApplicantMailer < ApplicationMailer
  def send_email_to_applicant(applicant:, sender:)
    @applicant = applicant
    @sender = sender
    @user = applicant.user

    begin
      mail(to: @applicant.email, subject: subject_line) do |format|
        format.html { render template: "mailers/#{email_template}" }
      end.deliver_now
      
      create_mail_history(email_template, 'succeed')
    rescue StandardError => e
      Rails.logger.error "Error sending email: #{e.message}"
      create_mail_history(email_template, 'failed')
    end
  end

  private

  def create_mail_history(email_template, status)
    @user.mail_histories.create(
      subject: subject_line,
      status: status,
      sender_email: @sender.email
    )
  end

  def email_template
    case @applicant.status
    when 'approved'
      'applicant_approved'
    when 'denied'
      'applicant_denied'
    else
      'applicant_pending'
    end
  end

  def subject_line
    case @applicant.status
    when 'approved'
      'Congratulations on making it to the next step'
    when 'denied'
      'Unfortunately to let you know that you didn’t make it to the next round'
    else
      'We have received your job application'
    end 
  end
end
