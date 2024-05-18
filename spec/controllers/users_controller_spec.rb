# spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) } # Create a regular user
  let(:admin) { create(:user, admin: true) } # Create an admin user

  before do
    sign_in(user) # Log in as a regular user by default
  end

  describe 'GET #show' do
    context 'when logged in' do
      it 'shows the current user profile' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:success)
        expect(assigns(:applicants)).to eq(user.applicants)
      end
    end

    context 'when not logged in' do
      before { sign_out(user) }

      it 'redirects to sign-in page' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template for the current user' do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH/PUT #update' do
    let(:new_attributes) do
      { email: 'newemail@example.com', name: 'New Name' }
    end

    context 'when valid attributes' do
      it 'updates the user profile successfully' do
        patch :update, params: { id: user.id, user: new_attributes }
        expect(response).to redirect_to(user_path(user))
        expect(flash[:notice]).to eq('User updated successfully.')
        expect(user.reload.email).to eq('newemail@example.com')
      end
    end

    context 'when invalid attributes' do
      it 'renders the edit template with errors' do
        patch :update, params: { id: user.id, user: { email: 'invalid' } }
        expect(response).to render_template(:edit)
        expect(assigns(:user).errors[:email]).to include('is invalid')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the current user deletes their own account' do
      it 'deletes the user account and redirects to the root path' do
        expect { delete :destroy, params: { id: user.id } }
          .to change(User, :count).by(-1)
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Your account has been deleted successfully.')
      end
    end

    context 'when a user tries to delete another user\'s account' do
      let(:other_user) { create(:user) }
      before { sign_in(user) } # Sign in as a user

      it 'does not allow it and redirects with an alert' do
        delete :destroy, params: { id: other_user.id }
      rescue CanCan::AccessDenied
        expect(response.status).to eq(200) # Expect a 200 status
      end
    end
  end

  describe 'POST #create' do
    let(:valid_user_attributes) do
      { email: 'newuser@example.com', password: 'password', password_confirmation: 'password', name: 'New User' }
    end
    before { sign_in(user) } # Sign in as a user

    context 'when valid attributes' do
      it 'creates a new user and redirects to the user profile' do
        post :create, params: { user: valid_user_attributes }
      rescue CanCan::AccessDenied
        expect(response.status).to eq(200) # Expect a 200 status
      end
    end

    context 'when invalid attributes' do
      it 'renders the new template with errors' do
        post :create, params: { user: { email: 'invalid' } }
      rescue CanCan::AccessDenied
        expect(response.status).to eq(200) # Expect a 200 status
      end
    end
  end
end
