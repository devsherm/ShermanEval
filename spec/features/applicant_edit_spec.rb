# spec/features/applicant_edit_spec.rb

require 'rails_helper'

RSpec.describe 'Applicant Edit', type: :feature do
  let(:user) { create(:user) }
  let(:applicant) { create(:applicant, user:) }

  before do
    # Sign in the user
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    expect(page).to have_content('Signed in successfully')
  end

  it 'allows a user to edit an existing applicant' do
    # Navigate to the applicant edit page
    visit edit_v1_applicant_path(applicant)

    # Fill in updated values
    fill_in 'Name', with: 'Updated Applicant'
    fill_in 'Email', with: 'updated@applicant.com'
    fill_in 'Posting Pay', with: '60k-70k'
    fill_in 'Requested Pay', with: '65k'
    fill_in 'Posting Schedule', with: 'Part-time'
    select 'Contractor With Maximum Flexibility', from: 'Preferred Employment Class'
    fill_in 'Preferred Work Schedule', with: '20 hours/week'
    select 'AWS', from: 'App Hosting Service'
    select 'MySQL', from: 'Database Used'
    fill_in 'Rpd schema', with: 'Revised schema'
    select 'Azure', from: 'Document Storage Service'
    select 'beauty of UI', from: 'Values'
    fill_in 'GPT Description', with: 'Revised GPT usage'
    fill_in 'Feedback', with: 'Updated feedback'
    choose 'applicant_gpt_use_no'

    # Save the changes
    click_button 'Update Application'

    # Check for success message
    expect(page).to have_content('Application updated successfully')

    # Check if the updated values are reflected
    expect(page).to have_content('Updated Applicant')
    expect(page).to have_content('60k-70k')
  end
end
