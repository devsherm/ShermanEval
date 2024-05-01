# app/test/controllers/applicants_controller_test.rb

require 'test_helper'

class ApplicantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @applicant = applicants(:one)
    sign_in users(:one) # Assuming Devise for authentication
  end

  test 'should get index' do
    get v1_applicants_path
    assert_response :success
  end

  test 'should create applicant' do
    assert_difference('Applicant.count') do
      post v1_applicants_path, params: { applicant: { name: 'New Applicant', email: 'new@example.com' } }
    end
    assert_redirected_to v1_applicant_path(Applicant.last)
  end

  test 'should categorize applicant' do
    post categorize_v1_applicant_path(@applicant), params: { category: 'Approved' }
    assert_equal 'Approved', @applicant.reload.category
  end

  # Add more tests for other actions...
end
