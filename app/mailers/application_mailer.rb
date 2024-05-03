class ApplicationMailer < ActionMailer::Base
    default from: 'from@example.com'
  
    def status_update_email(email)
      mail(to: email, subject: 'Application Status Update')
    end
  end