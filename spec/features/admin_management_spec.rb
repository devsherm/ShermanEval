# spec/features/admin_management_spec.rb

require 'rails_helper'

RSpec.describe 'Admin Management', type: :feature do
  let(:user) { create(:user) } # Non-admin user
  let(:admin) { create(:user, admin: true) } # Admin user

  before do
    # Log in as admin
    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'

    expect(page).to have_content('Signed in successfully')
  end

  describe 'Viewing Applicants' do
    it 'shows all applicants and allows sorting by category' do
      # Create sample applicants
      applicant1 = create(:applicant, user:, name: 'Applicant 1', category: nil)
      applicant2 = create(:applicant, user:, name: 'Applicant 2')
      applicant3 = create(:applicant, user: create(:user), name: 'Applicant 3')

      visit v1_applicants_path

      # Check that all applicants are shown
      expect(page).to have_content(applicant1.name)
      expect(page).to have_content(applicant2.name)
      expect(page).to have_content(applicant3.name)

      # Sort by category
      select 'Category', from: 'sort_by'
      click_button 'Sort'

      # Check if sorted applicants are displayed correctly (adjust as needed)
      expect(page).to have_content('Not Categorized')
    end
  end

  describe 'Categorizing Applicants' do
    let(:admin) { create(:user, admin: true) }
    let(:applicant) { create(:applicant, user: admin, category: nil) }

    it 'updates category and redirects correctly' do
      visit v1_applicant_path(applicant)

      select 'Approved', from: 'category' # Adjust this line as needed
      click_button 'Update Category' # Adjust this line as needed

      expect(page).to have_content('Applicant categorized successfully.')
      expect(applicant.reload.category).to eq('Approved')
    end
  end

  describe 'Sending Notifications' do
    let(:admin) { create(:user, admin: true) }
    let(:applicant) { create(:applicant, user: admin) }

    it 'sends an email and redirects' do
      visit notify_v1_applicant_path(applicant)

      fill_in 'Notification Message', with: 'Notification Message'
      click_button 'Send Notification'

      expect(page).to have_content('Email sent successfully.')
      expect(current_path).to eq(root_path)
    end
  end
end
