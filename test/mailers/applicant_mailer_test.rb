# app/test/mailers/applicant_mailer_test.rb

require 'test_helper'
require 'email_spec'

class ApplicantMailerTest < ActionMailer::TestCase
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  test 'notification email' do
    applicant = applicants(:one)
    mail = ApplicantMailer.notification(applicant, 'You have been approved!')

    assert mail.to.include?(applicant.email)
    assert mail.subject.include?('Notification from Sherman Buildings')
    expect(mail).to have_body_text('You have been approved!')
  end
end
