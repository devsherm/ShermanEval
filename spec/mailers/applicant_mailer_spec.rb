require 'rails_helper'

# spec/mailers/applicant_mailer_spec.rb

RSpec.describe ApplicantMailer, type: :mailer do
  let(:user) { create(:user) } # Create a valid user using FactoryBot
  let(:applicant) { create(:applicant, user:) } # Create an associated applicant

  describe '#notification' do
    let(:message) { 'Your application is under review.' } # Test message
    let(:mail) { ApplicantMailer.notification(applicant, message) }

    it 'renders the headers correctly' do
      expect(mail.subject).to eq('Notification from Sherman Buildings')
      expect(mail.to).to eq([applicant.email])
      expect(mail.from).to eq(['from@example.com']) # Replace with your mailer's default sender
    end

    it 'renders the body with the correct message' do
      expect(mail.body.encoded).to include(message)
    end

    it 'sends the email' do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
  end
end
