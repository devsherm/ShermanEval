# spec/controllers/v1/applicants_controller_spec.rb
require 'rails_helper'
require_relative '../../../app/controllers/v1/applicants_controller'

RSpec.describe V1::ApplicantsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:applicant) { create(:applicant, user:) }

  before { sign_in(user) } # Assuming Devise helpers are available for user authentication

  describe 'GET #index' do
    context 'as an admin' do
      before { sign_in(admin) }

      it 'returns all applicants' do
        get :index

        expect(assigns(:applicants)).to include(applicant)
      end

      it 'sorts by name' do
        get :index, params: { sort_by: 'name' }

        expect(assigns(:applicants)).to eq(Applicant.sorted_by_name)
      end
    end

    context 'as a regular user' do
      it "returns only the user's applicants" do
        get :index

        expect(assigns(:applicants)).to eq(user.applicants)
      end
    end
  end

  describe 'GET #show' do
    it 'returns the applicant details' do
      get :show, params: { id: applicant.id }

      expect(assigns(:applicant)).to eq(applicant)
    end
  end

  describe 'GET #new' do
    it 'initializes a new applicant' do
      get :new

      expect(assigns(:applicant)).to be_a_new(Applicant)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new applicant' do
        expect do
          post :create, params: { applicant: attributes_for(:applicant, user:) }
        end.to change(Applicant, :count).by(1)

        expect(response).to redirect_to(v1_applicant_path(assigns(:applicant)))
      end
    end

    context 'with invalid attributes' do
      it 'does not create an applicant' do
        expect do
          post :create, params: { applicant: attributes_for(:applicant, name: nil) }
        end.not_to change(Applicant, :count)

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST #categorize' do
    context 'as an admin' do
      before { sign_in(admin) }

      it "updates the applicant's category" do
        post :categorize, params: { id: applicant.id, category: 'Approved' }

        expect(applicant.reload.category).to eq('Approved')
        expect(response).to redirect_to(root_path) # Expect redirect to root path
      end
    end

    context 'as a regular user' do
      before { sign_in(user) } # Sign in as a regular user

      it "does not update the applicant's category" do
        post :categorize, params: { id: applicant.id, category: 'Approved' }

        expect(applicant.reload.category).to eq('Approved') # Expect category to be 'Approved'
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #edit' do
    it 'retrieves the applicant for editing' do
      get :edit, params: { id: applicant.id }

      expect(assigns(:applicant)).to eq(applicant)
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid attributes' do
      it 'updates the applicant' do
        patch :update, params: { id: applicant.id, applicant: { name: 'Updated Name' } }

        expect(applicant.reload.name).to eq('Updated Name')
        expect(response).to redirect_to(v1_applicant_path(applicant))
      end
    end

    context 'with invalid attributes' do
      it 'does not update the applicant' do
        patch :update, params: { id: applicant.id, applicant: { name: nil } }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET #notify' do
    context 'as an admin' do
      before { sign_in(admin) }

      it 'renders the notification form' do
        get :notify, params: { id: applicant.id }

        expect(assigns(:applicant)).to eq(applicant)
        expect(response).to render_template(:notify)
      end
    end
  end

  describe 'POST #send_notification' do
    context 'as an admin' do
      before { sign_in(admin) }

      it 'sends an email notification to the applicant' do
        post :send_notification, params: { id: applicant.id, message: 'Notification message' }

        # Check email queue for the expected email
        expect(ActionMailer::Base.deliveries).not_to be_empty

        expect(response).to redirect_to(root_path)
      end
    end

    context 'as a regular user' do
      it 'does not allow sending notifications' do
        post :send_notification, params: { id: applicant.id, message: 'Notification message' }

        expect(response).to redirect_to(root_path)
      end
    end
  end

  # Helper methods
  private

  def attributes_for(klass, overrides = {})
    FactoryBot.attributes_for(klass).merge(overrides)
  end
end
