# spec/requests/v1/applicants_spec.rb

require 'rails_helper'

RSpec.describe 'Applicants', type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }

  before do
    sign_in(user) # Using a regular user by default
  end

  describe 'GET /v1/applicants' do
    context 'when a regular user' do
      it 'shows only their own applicants' do
        # Sample applicants setup
        applicant1 = create(:applicant, user:, name: 'Applicant 1')
        applicant2 = create(:applicant, user:, name: 'Applicant 2')
        other_applicant = create(:applicant, user: create(:user), name: 'Other Applicant')

        get v1_applicants_path
        expect(response).to have_http_status(:success)

        expect(response.body).to include(applicant1.name, applicant2.name)
        expect(response.body).not_to include(other_applicant.name)
      end
    end

    context 'when an admin user' do
      before { sign_in(admin) }

      it 'shows all applicants' do
        applicant1 = create(:applicant, user:, name: 'Applicant 1')
        applicant2 = create(:applicant, user:, name: 'Applicant 2')
        other_applicant = create(:applicant, user: create(:user), name: 'Other Applicant')

        get v1_applicants_path
        expect(response).to have_http_status(:success)

        expect(response.body).to include(applicant1.name, applicant2.name, other_applicant.name)
      end
    end
  end

  describe 'GET /v1/applicant/:id' do
    let(:applicant) { create(:applicant, user:, name: 'Test Applicant') }

    it "shows the applicant's details" do
      get v1_applicant_path(applicant)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Test Applicant')
    end
  end

  describe 'PATCH/PUT /v1/applicant/:id' do
    let(:applicant) { create(:applicant, user:) }

    before { sign_in(user) }

    it 'updates and redirects properly' do
      patch v1_applicant_path(applicant), params: { applicant: { name: 'Updated Applicant' } }
      expect(response).to redirect_to(v1_applicant_path(applicant))
      follow_redirect!
      expect(response.body).to include('Application updated successfully.')
      expect(applicant.reload.name).to eq('Updated Applicant')
    end
  end

  describe 'POST /v1/applicant/:id/categorize' do
    let(:applicant) { create(:applicant, user:, category: nil) }

    context 'when an admin categorizes an applicant' do
      before { sign_in(admin) }

      it 'updates the category and redirects to its show page' do
        post categorize_v1_applicant_path(applicant), params: { category: 'Approved' }
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('Applicant categorized successfully.')
        expect(applicant.reload.category).to eq('Approved')
      end
    end
  end

  describe 'POST /v1/applicant/:id/send_notification' do
    let(:applicant) { create(:applicant, user:) }

    before { sign_in(user) }

    it 'sends an email and redirects' do
      post send_notification_v1_applicant_path(applicant), params: { message: 'Notification Message' }
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('Email sent successfully.')
    end
  end
end
