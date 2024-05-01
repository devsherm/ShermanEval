# spec/features/user_authentication_spec.rb

require 'rails_helper'

RSpec.describe 'User Authentication', type: :feature do
  let(:user) { create(:user) } # Using FactoryBot to create a user instance

  describe 'User Sign-Up' do
    it 'allows a new user to sign up' do
      visit new_user_registration_path

      fill_in 'Email', with: 'newuser@example.com'
      fill_in 'Password', with: 'newpassword'
      fill_in 'Password confirmation', with: 'newpassword'
      fill_in 'Name', with: 'New User'

      click_button 'Sign Up'

      # Check for successful sign-up message
      expect(page).to have_content('Welcome! You have signed up successfully.')

      # Check if user is redirected to the expected page
      expect(page).to have_content('Home')
    end
  end

  describe 'User Sign-Out' do
    before do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign In'

      expect(page).to have_content('Signed in successfully')
    end

    it 'allows a user to sign out' do
      # Click the "Sign Out" button
      click_button 'Sign Out'

      # Verify user is redirected to the login page
      expect(page).to have_content('Sign In')
    end
  end

  describe 'Password Reset' do
    it 'allows a user to request a password reset' do
      visit new_user_session_path

      click_link 'Forgot Password?'

      fill_in 'Email', with: user.email
      click_button 'Send Reset Instructions'

      # Check for successful reset email
      expect(page).to have_content('You will receive an email with instructions')

      # Assuming you handle email delivery verification elsewhere
    end

    it 'allows a user to reset their password' do
      # Simulate receiving reset link and visiting it
      visit edit_user_password_path(reset_password_token: user.send_reset_password_instructions)

      fill_in 'New password', with: 'newpassword123'
      fill_in 'Confirm your new password', with: 'newpassword123'

      click_button 'Change my password'

      # Check for success message
      expect(page).to have_content('Your password has been changed successfully.')
    end
  end
end
