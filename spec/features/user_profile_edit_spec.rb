# spec/features/user_profile_edit_spec.rb

require 'rails_helper'

RSpec.describe 'User Profile Edit', type: :feature do
  let(:user) { create(:user) }

  before do
    # Sign in the user
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    expect(page).to have_content('Signed in successfully')
  end

  it 'allows a user to edit their profile' do
    # Navigate to the edit profile page
    visit edit_user_registration_path

    # Fill in updated values
    fill_in 'Email', with: 'newemail@example.com'
    fill_in 'Name', with: 'Updated Name'
    fill_in 'Password', with: 'newpassword'
    fill_in 'Password confirmation', with: 'newpassword'
    fill_in 'Current password', with: user.password

    # Save the changes
    click_button 'Update'

    # Check for success message
    expect(page).to have_content('Your account has been updated successfully')

    # Check if the updated email is reflected
    visit edit_user_registration_path
    expect(find_field('Email').value).to eq('newemail@example.com')
    expect(find_field('Name').value).to eq('Updated Name')
  end

  it 'allows a user to destroy their account' do
    # Navigate to the edit profile page
    visit edit_user_registration_path

    # Click the "Cancel my account" button
    click_button 'Cancel my account'

    # Check for success message
    expect(page).to have_content('You need to sign in or sign up before continuing.')

    # Verify the user is logged out
    expect(page).to have_content('Sign In')
  end
end
