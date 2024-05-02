class NotifyApplicantMailer < ApplicationMailer
    def notify_email(user,msg,position,status)
        @user = user
        @msg = msg
        @position = position
        @status = status
        mail(to: @user.email, subject: 'Job Submission Notification!')
    end
end
