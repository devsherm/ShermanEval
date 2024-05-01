# spec/models/user_spec.rb
RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid with an improperly formatted email' do
      user.email = 'invalid-email'
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('is invalid')
    end

    it 'is invalid without a password' do
      user.password = nil
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'is valid without a name' do
      user.name = nil
      expect(user).to be_valid
    end
  end

  context 'associations' do
    it 'has many applicants' do
      expect(user).to respond_to(:applicants)
    end

    it 'destroys associated applicants' do
      create(:applicant, user:)
      expect { user.destroy }.to change { Applicant.count }.by(-1)
    end
  end

  context 'devise modules' do
    it 'locks after multiple failed login attempts' do
      5.times do
        user.valid_for_authentication? { false }
      end
      expect(user.access_locked?).to eq(true), 'User should be locked after multiple failed attempts'
    end

    it 'resets password and sends email' do
      expect { user.send_reset_password_instructions }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
  end
end
