class ContactMailer < ApplicationMailer
    def contact_us(email, subject, message)
        @email = email
        @subject = subject
        @message = message
        mail(to: ENV["DEFAULT_FROM_EMAIL"], subject: 'Jop Applications Portal!')
    end
end
