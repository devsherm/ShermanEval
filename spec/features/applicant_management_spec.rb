# spec/features/applicant_management_spec.rb

require 'rails_helper'

RSpec.describe 'Applicant Management', type: :feature do
  let(:user) { create(:user) } # Assuming FactoryBot provides a user factory

  before do
    # User registration or login
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Signed in successfully')
  end

  it 'allows a user to create a new applicant' do
    visit new_v1_applicant_path

    fill_in 'Name', with: 'Test Applicant'
    fill_in 'Email', with: 'test@applicant.com'
    fill_in 'Posting pay', with: '50k-60k'
    fill_in 'Requesting pay', with: '55k'
    fill_in 'Posting sched', with: 'Full-time'
    select 'Contractor With Maximum Flexibility', from: 'Requesting class'
    fill_in 'Requesting schedule', with: '40 hours/week'
    select 'Heroku', from: 'App host'
    select 'PostgreSQL', from: 'applicant_app_db'
    fill_in 'Rpd schema', with: 'applicant_rpd_schema' # Update this line with the correct label
    select 'AWS', from: 'Doc store'
    select 'speed of development', from: 'My values'
    fill_in 'Gpt desc', with: 'Using GPT for coding'
    fill_in 'Give me feedback. What am I doing wrong?', with: 'Nothing'

    # For the radio button:
    choose 'applicant_gpt_use_yes' # Update this line with the correct id or value

    click_button 'Create Application'

    expect(page).to have_content('Application submitted successfully')
    expect(page).to have_content('Test Applicant')
  end
end
